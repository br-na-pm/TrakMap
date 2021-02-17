// --------------------------------------------------------------------------------------------------------------------
// Logbook Task
// This task reads the PLC logbook and creates the data structure to display it in mappView
// --------------------------------------------------------------------------------------------------------------------
PROGRAM _INIT
	// Set time range to all on startup
	DTGetTime_0.enable := TRUE;
	DTGetTime_0();
	LogbookInterface.Par.FilterDateStart := STRING_TO_DATE('D#1999-12-31');
	LogbookInterface.Par.FilterDateEnd := DT_TO_DATE(DTGetTime_0.DT1);
	
	// Read data after reboot
	LogbookInterface.Cmd.Refresh := TRUE;
	
	// define what object type should be searched for
	LogbookInterface.SegError.ParaSegFilter		:= 'gSeg_';
END_PROGRAM

PROGRAM _CYCLIC
	// Abort current update run
	IF EDGENEG(LogbookInterface.Cmd.Refresh) THEN
		IF 	LogbookState <> STATE_ERROR THEN
			LogbookInterface.Status := ERR_OK;
			LogbookState := STATE_WAIT;
		END_IF
	END_IF
	
	IF EDGEPOS(DiagInterface.TrakInterface.Asm.Status.ErrorStop) THEN
		LogbookInterface.Cmd.Update := TRUE;
	END_IF	
	
	// Run task multiple times to speed up process
	FOR executions:=1 TO LOGBOOK_EXECUTIONS DO
		// --------------------------------------------------------------------------------------------------------------------
		// Logbook State machine
		// --------------------------------------------------------------------------------------------------------------------
		CASE LogbookState OF
		// --------------------------------------------------------------------------------------------------------------------
		// Wait for new command
		// --------------------------------------------------------------------------------------------------------------------
			STATE_WAIT:
				// --------------------------------------------------------------------------------------------------------------------
				// Get current date
				DTGetTime_0.enable := TRUE;
				DTGetTime_0();
				LogbookInterface.Par.DateNow := DTGetTime_0.DT1;
				LogbookInterface.Par.EntriesMax := LOGBOOK_ENTRIES_MAX;
					
				// --------------------------------------------------------------------------------------------------------------------
				// Refresh all logbook data
				IF LogbookInterface.Cmd.Refresh THEN
					// Erase old data, set busy state
					brsmemset(ADR(Logbook), 0, SIZEOF(Logbook));
					brsmemset(ADR(LogbookInterface.Data), 0, SIZEOF(LogbookInterface.Data));
					LogbookInterface.Status := ERR_FUB_BUSY;
					LogbookState := STATE_OPEN;
				END_IF

				// --------------------------------------------------------------------------------------------------------------------
				// Auto update logbook data 
				IF LogbookInterface.Par.AutoUpdate THEN
					AutoRefresh.IN := TRUE;
					AutoRefresh.PT := LogbookInterface.Par.AutoUpdateInterval*100;
					AutoRefresh();
					IF AutoRefresh.Q THEN
						AutoRefresh(IN:= FALSE);
						LogbookInterface.Cmd.Update := TRUE;
						LogbookState := STATE_NEXT;
					END_IF
				ELSE
					AutoRefresh(IN:= FALSE);
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Update only latest logbook data
				IF LogbookInterface.Cmd.Update THEN
					brsmemset(ADR(Logbook.RecordIDIsLast), 0, SIZEOF(Logbook.RecordIDIsLast));
					brsmemset(ADR(Logbook.RecordID), 0, SIZEOF(Logbook.RecordID));
					
					brsmemset(ADR(LogbookInterface.SegError.Record), 0, SIZEOF(LogbookInterface.SegError.Record));
					LogbookInterface.SegError.Message := '';
					SegmentErrorFound := 0;
					
					brsmemset(ADR(AlarmCount), 0, SIZEOF(AlarmCount));
					
					
					// Start at the beginning set busy state
					Logbook.CntLogbook := 0;
					LogbookInterface.Status := ERR_FUB_BUSY;
					LogbookState := STATE_LATEST;
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Create new logbook entry
				IF LogbookInterface.Cmd.Create THEN
					LogbookInterface.Status := ERR_FUB_BUSY;
					LogbookState := STATE_CREATE;
				END_IF

				// --------------------------------------------------------------------------------------------------------------------
				// Reset function blocks
				ArEventLogGetIdent_0(Execute := FALSE);
				ArEventLogGetLatestRecordID_0(Execute := FALSE);
				ArEventLogGetPreviousRecordID_0(Execute := FALSE);
				ArEventLogRead_0(Execute := FALSE);
				ArEventLogReadErrorNumber_0(Execute := FALSE);
				ArEventLogReadDescription_0(Execute := FALSE);
				ArEventLogReadAddData_0(Execute := FALSE);
				ArEventLogWrite_0(Execute := FALSE);
				ArEventLogReadObjectID_0(Execute := FALSE);
				
				// --------------------------------------------------------------------------------------------------------------------
				// Show status, reset error command
				LogbookInterface.Cmd.ResetError := FALSE;
				LogbookInterface.StatusText := 'Waiting...last update ';
				brsstrcat(ADR(LogbookInterface.StatusText), ADR(LogbookInterface.Data.LastUpdate));
				EXIT;
		// --------------------------------------------------------------------------------------------------------------------
		// Create a new logbook entry
		// --------------------------------------------------------------------------------------------------------------------
			STATE_CREATE:
				eventID := ArEventLogMakeEventID(UDINT_TO_USINT(LogbookInterface.Par.CreateSeverity), 0 , LogbookInterface.Par.CreateErrorNo);
				brsmemset(ADR(AddData), 0, SIZEOF(AddData));
				brsstrcpy(ADR(AddData), ADR(LogbookInterface.Par.CreateErrorText));
				
				ArEventLogWrite_0.Execute := TRUE;
				ArEventLogWrite_0.Ident := Logbook.Ident[LogbookInterface.Par.CreateLogbook];
				ArEventLogWrite_0.EventID := eventID;
				ArEventLogWrite_0.ObjectID := 'User event';
				ArEventLogWrite_0.AddDataFormat := arEVENTLOG_ADDFORMAT_TEXT;
				ArEventLogWrite_0.AddData := ADR(AddData);
				ArEventLogWrite_0.AddDataSize := brsstrlen(ADR(AddData));
				ArEventLogWrite_0();

				// Success
				IF ArEventLogWrite_0.Done AND ArEventLogWrite_0.StatusID = ERR_OK THEN
					ArEventLogWrite_0(Execute := FALSE);
					LogbookInterface.Cmd.Create := FALSE;
					LogbookInterface.Cmd.Update := TRUE;
					LogbookState := STATE_WAIT;
				// Error
				ELSIF ArEventLogWrite_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogWrite_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Open logbook
		// --------------------------------------------------------------------------------------------------------------------
			STATE_OPEN:
				// Last logbook reached 
				IF Logbook.CntLogbook > LOGBOOK_BOOKS_MAX THEN				
					Logbook.CntLogbook := 0;
					LogbookState := STATE_LATEST;
					EXIT;
				END_IF
				ArEventLogGetIdent_0.Execute := LogbookInterface.Cmd.Refresh;
				ArEventLogGetIdent_0.Name := LOGBOOK_NAMES[Logbook.CntLogbook];
				ArEventLogGetIdent_0();
	
				// Success
				IF (ArEventLogGetIdent_0.Done AND ArEventLogGetIdent_0.StatusID = ERR_OK) OR ArEventLogGetIdent_0.StatusID = arEVENTLOG_ERR_LOGBOOK_NOT_FOUND THEN
					Logbook.Ident[Logbook.CntLogbook] := ArEventLogGetIdent_0.Ident;
					Logbook.CntLogbook := Logbook.CntLogbook + 1;					
					ArEventLogGetIdent_0(Execute := FALSE);
					// Error
				ELSIF ArEventLogGetIdent_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogGetIdent_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Read latest entry
		// --------------------------------------------------------------------------------------------------------------------
			STATE_LATEST:
				ArEventLogGetLatestRecordID_0.Execute := TRUE;
				ArEventLogGetLatestRecordID_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogGetLatestRecordID_0();

				// Success
				IF ArEventLogGetLatestRecordID_0.Done AND ArEventLogGetLatestRecordID_0.StatusID = ERR_OK THEN
					// Store this record ID for next step
					Logbook.RecordID[Logbook.CntLogbook] := ArEventLogGetLatestRecordID_0.RecordID;
					// If there is a new entry
					IF ArEventLogGetLatestRecordID_0.RecordID > Logbook.RecordIDOld[Logbook.CntLogbook] THEN
						// Store latest ID for next update command, reset is last flag
						Logbook.RecordIDLatest[Logbook.CntLogbook] := ArEventLogGetLatestRecordID_0.RecordID;
						LogbookState := STATE_DETAILS_1;
						// No new entry
					ELSE
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						LogbookState := STATE_PREP;
					END_IF
					// Error
				ELSIF ArEventLogGetLatestRecordID_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogGetLatestRecordID_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Read next entry
		// --------------------------------------------------------------------------------------------------------------------
			STATE_NEXT:
				animation := WorkingStatus(ADR(LogbookInterface.StatusText), ADR('reading entries...'), animation);
				ArEventLogGetPreviousRecordID_0.Execute := TRUE;
				ArEventLogGetPreviousRecordID_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogGetPreviousRecordID_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogGetPreviousRecordID_0();

				// Success
				IF ArEventLogGetPreviousRecordID_0.Done AND ArEventLogGetPreviousRecordID_0.StatusID = ERR_OK THEN
					// Store this record ID for next step
					Logbook.RecordID[Logbook.CntLogbook] := ArEventLogGetPreviousRecordID_0.PrevRecordID;
					// Stop update when previous record ID is reached
					IF Logbook.RecordID[Logbook.CntLogbook] = Logbook.RecordIDOld[Logbook.CntLogbook] AND LogbookInterface.Cmd.Update THEN
						// Remember latest entry, set is last flag
						Logbook.RecordIDOld[Logbook.CntLogbook] := Logbook.RecordIDLatest[Logbook.CntLogbook];
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						LogbookState := STATE_PREP;
					ELSE
						LogbookState := STATE_DETAILS_1;
					END_IF
					// Error
				ELSIF ArEventLogGetPreviousRecordID_0.Error THEN
					// Last entry reached is not an error
					IF ArEventLogGetPreviousRecordID_0.StatusID = arEVENTLOG_ERR_RECORDID_INVALID THEN
						// Remember latest entry, set is last flag
						Logbook.RecordIDOld[Logbook.CntLogbook] := Logbook.RecordIDLatest[Logbook.CntLogbook];
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						LogbookState := STATE_PREP;
						// Everything else is an error
					ELSE
						LogbookInterface.Error.State := LogbookState;
						LogbookInterface.Status := ArEventLogGetPreviousRecordID_0.StatusID;
						LogbookState := STATE_ERROR;
					END_IF
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Read event id and time stamp
		// --------------------------------------------------------------------------------------------------------------------
			STATE_DETAILS_1:
				ArEventLogRead_0.Execute := TRUE;
				ArEventLogRead_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogRead_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogRead_0();

				// Success
				IF ArEventLogRead_0.Done AND (ArEventLogRead_0.StatusID = ERR_OK OR ArEventLogRead_0.StatusID = arEVENTLOG_WRN_NO_EVENTID) THEN
					LogbookState := STATE_DETAILS_2;
				
					EventID := ArEventLogRead_0.EventID;
					EventTimeStamp := ArEventLogRead_0.TimeStamp;
					EventIDSeverity	:= DINT_TO_USINT(SHR(EventID, 30) AND 16#03);
					EventIDFacility	:= DINT_TO_UINT(SHR(EventID, 16) AND 16#0FFF);
					EventIDCode		:= DINT_TO_UINT(SHR(EventID, 0) AND 16#FFFF);

				// Error
				ELSIF ArEventLogRead_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogRead_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Read error no
		// --------------------------------------------------------------------------------------------------------------------
			STATE_DETAILS_2:
				ArEventLogReadErrorNumber_0.Execute := TRUE;
				ArEventLogReadErrorNumber_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogReadErrorNumber_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogReadErrorNumber_0();

				// Success
				IF (ArEventLogReadErrorNumber_0.Done AND ArEventLogReadErrorNumber_0.StatusID = ERR_OK) OR ArEventLogReadErrorNumber_0.StatusID = arEVENTLOG_ERR_NO_ERRORNUMBER THEN
					brsmemset(ADR(ErrorText), 0, SIZEOF(ErrorText));
					LogbookState := STATE_DETAILS_3;
				// Error
				ELSIF ArEventLogReadErrorNumber_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogReadErrorNumber_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Read error description
		// --------------------------------------------------------------------------------------------------------------------
			STATE_DETAILS_3:
				ArEventLogReadDescription_0.Execute := TRUE;
				ArEventLogReadDescription_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogReadDescription_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogReadDescription_0.TextBuffer := ADR(ErrorText);
				ArEventLogReadDescription_0.TextBufferSize := SIZEOF(ErrorText);
				ArEventLogReadDescription_0();

				// Success
				IF (ArEventLogReadDescription_0.Done AND (ArEventLogReadDescription_0.StatusID = ERR_OK OR ArEventLogReadDescription_0.StatusID = arEVENTLOG_WRN_NO_EVENTID)) OR ArEventLogReadDescription_0.StatusID = arEVENTLOG_ERR_NO_DESCRIPTION THEN
					brsmemset(ADR(AddData), 0, SIZEOF(AddData));
					IF ((Logbook.CntLogbook = 6) AND (EventIDSeverity = arEVENTLOG_SEVERITY_ERROR)) THEN (*6 = index for motion logbook*)
						LogbookState := STATE_CHECK_FILTER;
					ELSE	
						LogbookState := STATE_DETAILS_4;
					END_IF	
				// Error
				ELSIF ArEventLogReadDescription_0.Error THEN
					LogbookInterface.Error.State := LogbookState;
					LogbookInterface.Status := ArEventLogReadDescription_0.StatusID;
					LogbookState := STATE_ERROR;
				END_IF
		// --------------------------------------------------------------------------------------------------------------------
		// Check if 'Error' has been entered by a Segment
		// --------------------------------------------------------------------------------------------------------------------	
			STATE_CHECK_FILTER:
				ArEventLogReadObjectID_0.Execute	:= TRUE;
				ArEventLogReadObjectID_0.Ident		:= Logbook.Ident[Logbook.CntLogbook];
				ArEventLogReadObjectID_0.RecordID	:= Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogReadObjectID_0();

				IF ArEventLogReadObjectID_0.Done THEN
					ObjectID := ArEventLogReadObjectID_0.ObjectID;
					ArEventLogReadObjectID_0.Execute := FALSE;
					IF brsmemcmp(ADR(ObjectID), ADR(LogbookInterface.SegError.ParaSegFilter), 3) = 0 THEN
						LogbookState := STATE_UPDATE_LIST;
					ELSE
						LogbookState := STATE_DETAILS_4;
					END_IF
				ELSIF ArEventLogReadObjectID_0.Error THEN
					LogbookInterface.SegError.Message := 'Error ReadObjectID';
					LogbookState := STATE_ERROR;
				END_IF	
				
		// --------------------------------------------------------------------------------------------------------------------
		// Update the segment error list which is used for alarms
		// --------------------------------------------------------------------------------------------------------------------	
			STATE_UPDATE_LIST:
				LogbookInterface.SegError.Record[SegmentErrorFound].ObjectID		:= ObjectID;
				LogbookInterface.SegError.Record[SegmentErrorFound].EventID			:= EventID;
				LogbookInterface.SegError.Record[SegmentErrorFound].EventIDSeverity	:= EventIDSeverity;
				LogbookInterface.SegError.Record[SegmentErrorFound].EventIDFacility	:= EventIDFacility;
				LogbookInterface.SegError.Record[SegmentErrorFound].EventIDCode		:= EventIDCode;
				LogbookInterface.SegError.Record[SegmentErrorFound].Description		:= Description;

				LogbookInterface.SegError.Record[SegmentErrorFound].EventTimeStamp	:= UDINT_TO_TIME((EventTimeStamp.sec MOD (24*60*60))*1000 + (EventTimeStamp.nsec / 1000000));		// convert to TIME format (ms since start of day)

				brsstrcpy(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(''));
				ascTIME(LogbookInterface.SegError.Record[SegmentErrorFound].EventTimeStamp, ADR(TempString), SIZEOF(TempString));
				TIME_TO_TIMEStructure(LogbookInterface.SegError.Record[SegmentErrorFound].EventTimeStamp,ADR(TimeStruct)); // for checking against older entries

				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(TempString));
				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(' => '));

				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(ObjectID));
	
				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(': Error '));
				brsitoa(EventIDCode, ADR(TempString));
				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(TempString));
	
				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(' => '));
				brsstrcat(ADR(LogbookInterface.SegError.Record[SegmentErrorFound].Text), ADR(Description));
				
				IF SegmentErrorFound = 0 THEN
					FirstEntryCheckSum := TimeStruct.minute; // save the timestamp minute of the first entry as checksum
				END_IF	
				
				SegmentErrorFound := SegmentErrorFound + 1;
						
				SetTrakSegAlarm(DiagInterface.AlarmCore,EventIDCode,ADR(AlarmCount));
									
				// stop reading the logger when the end of the array is reached OR 
				// when the entries start having a different timestamp which means they are older
				IF SegmentErrorFound > 499 OR (FirstEntryCheckSum <> (TimeStruct.minute) ) THEN 
					LogbookState := STATE_DETAILS_4;
				ELSE
					LogbookState := STATE_DETAILS_4;
				END_IF
				
				
		
		// --------------------------------------------------------------------------------------------------------------------
		// Read additional information
		// --------------------------------------------------------------------------------------------------------------------
			STATE_DETAILS_4:
				// Skip if no additional data is available
				IF ArEventLogRead_0.AddDataSize > 0 THEN
					// Read additional data
					ArEventLogReadAddData_0.Execute := TRUE;
					ArEventLogReadAddData_0.Ident := Logbook.Ident[Logbook.CntLogbook];
					ArEventLogReadAddData_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
					ArEventLogReadAddData_0.AddData := ADR(AddData);
					// Limit buffer to max size
					IF ArEventLogRead_0.AddDataSize < SIZEOF(AddData) THEN
						ArEventLogReadAddData_0.BytesToRead := ArEventLogRead_0.AddDataSize;
					ELSE
						ArEventLogReadAddData_0.BytesToRead := SIZEOF(AddData);
					END_IF
					ArEventLogReadAddData_0();
	
					// Success
					IF (ArEventLogReadAddData_0.Done AND ArEventLogReadAddData_0.StatusID = ERR_OK) OR ArEventLogReadAddData_0.StatusID = arEVENTLOG_INF_SIZE THEN
						// Enter standard text if additional does not fit
						IF ArEventLogReadAddData_0.StatusID = arEVENTLOG_INF_SIZE THEN
							brsstrcat(ADR(ErrorText), ADR('\n >>> '));
							brsstrcat(ADR(ErrorText), ADR('Additional buffer is too small'));
						ELSE
							// Make sure string is readable
							IF brsstrcmp(ADR(AddData), ADR('')) <> 0 AND ArEventLogRead_0.AddDataFormat = arEVENTLOG_ADDFORMAT_TEXT THEN
								brsstrcat(ADR(ErrorText), ADR('\n >>> '));
								// Limit additional text to max size
								IF ArEventLogReadAddData_0.AddDataSize < SIZEOF(ErrorText) - brsstrlen(ADR(ErrorText)) THEN		
									brsstrcat(ADR(ErrorText), ADR(AddData));
								ELSE
									brsmemcpy(ADR(ErrorText) + brsstrlen(ADR(ErrorText)), ADR(AddData), SIZEOF(ErrorText) - brsstrlen(ADR(ErrorText)));
								END_IF
							END_IF
						END_IF
						LogbookState := STATE_FILTER;
					// Error
					ELSIF ArEventLogReadDescription_0.Error THEN
						LogbookInterface.Error.State := LogbookState;
						LogbookInterface.Status := ArEventLogReadAddData_0.StatusID;
						LogbookState := STATE_ERROR;
					END_IF
				ELSE
					LogbookState := STATE_FILTER;
				END_IF				
		// --------------------------------------------------------------------------------------------------------------------
		// Apply filter settings
		// --------------------------------------------------------------------------------------------------------------------
			STATE_FILTER:
				// --------------------------------------------------------------------------------------------------------------------
				// Filters
				cntFilterNo := 0;
				cntFilterText := 0;
				cntFilterLogbook := 0;
				cntFilterSeverity := 0;
				cntFilterDate := 0;
				// --------------------------------------------------------------------------------------------------------------------
				// Check if logbook should be read
				IF  LogbookInterface.Par.FilterLogbook[Logbook.CntLogbook] THEN
					cntFilterLogbook := cntFilterLogbook + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check if error text matches search string
				IF LogbookInterface.Par.FilterErrorText = '' OR IsInstr(ADR(ErrorText), ADR(LogbookInterface.Par.FilterErrorText)) THEN
					cntFilterText := cntFilterText + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Make sure error number matches filter
				IF LogbookInterface.Par.FilterErrorNo = 0 OR LogbookInterface.Par.FilterErrorNo = ArEventLogReadErrorNumber_0.ErrorNumber THEN
					cntFilterNo := cntFilterNo + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check severity filter settings
				IF ArEventLogRead_0.EventID <> 0 THEN
					LogbookInterface.Data.CntSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] := LogbookInterface.Data.CntSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] + 1;
					IF LogbookInterface.Par.FilterSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] THEN
						cntFilterSeverity := cntFilterSeverity + 1;
					END_IF
				ELSE
					LogbookInterface.Data.CntSeverity[ArEventLogReadErrorNumber_0.Severity] := LogbookInterface.Data.CntSeverity[ArEventLogReadErrorNumber_0.Severity] + 1;
					IF LogbookInterface.Par.FilterSeverity[ArEventLogReadErrorNumber_0.Severity] THEN
						cntFilterSeverity := cntFilterSeverity + 1;
					END_IF
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check date range
				tmpSTR:= DT_TO_STRING(DATE_TO_DT(LogbookInterface.Par.FilterDateStart));
				brsmemcpy(ADR(tmpSTR)+13, ADR('-00:00:00'), 9);
				TimeStart := STRING_TO_DT(tmpSTR);
				tmpSTR:= DT_TO_STRING(DATE_TO_DT(LogbookInterface.Par.FilterDateEnd));
				brsmemcpy(ADR(tmpSTR)+13, ADR('-23:59:59'), 9);
				TimeEnd := STRING_TO_DT(tmpSTR);
				IF ArEventLogRead_0.TimeStamp.sec >= DT_TO_UDINT(TimeStart) AND ArEventLogRead_0.TimeStamp.sec <= DT_TO_UDINT(TimeEnd) THEN
					cntFilterDate := cntFilterDate + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Count logbook entries
				LogbookInterface.Data.CntLogbook[Logbook.CntLogbook] := LogbookInterface.Data.CntLogbook[Logbook.CntLogbook] +  1;
			
				// --------------------------------------------------------------------------------------------------------------------
				// Transfer data
				IF cntFilterNo > 0 AND cntFilterText > 0 AND cntFilterLogbook > 0 AND cntFilterSeverity > 0 AND cntFilterDate > 0 THEN						
					// --------------------------------------------------------------------------------------------------------------------
					// Find new place for entry
					idx := InsertEntry(ADR(LogbookInterface.Data), ArEventLogRead_0.TimeStamp.sec, UDINT_TO_UINT(ArEventLogRead_0.TimeStamp.nsec/1000000), LogbookInterface.Par.Sorting);
					IF idx <> NO_SPACE THEN
						// Store date and time
						LogbookInterface.Data.Entries.DTsec[idx] := ArEventLogRead_0.TimeStamp.sec;
						LogbookInterface.Data.Entries.DTmsec[idx] := UDINT_TO_UINT(ArEventLogRead_0.TimeStamp.nsec/1000000);
						// Add timestamp
						tmpDT := UDINT_TO_DT(ArEventLogRead_0.TimeStamp.sec);
						DT_TO_DTStructure(tmpDT, ADR(tmpDTstruct));
						brsmemset(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), 0, SIZEOF(LogbookInterface.Data.Entries.Timestamp[idx]));
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.day, '');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.month, '.');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.year, '.');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.hour, ' ');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.minute, ':');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), tmpDTstruct.second, ':');
						NormalizeDateTime(ADR(LogbookInterface.Data.Entries.Timestamp[idx]), LogbookInterface.Data.Entries.DTmsec[idx], '.');
						// Add event ID, code, logbook, severity
						LogbookInterface.Data.Entries.EventID[LogbookInterface.Data.EntriesTotal] := ArEventLogRead_0.EventID;
						IF ArEventLogRead_0.EventID <> 0 THEN
							LogbookInterface.Data.Entries.Severity[idx] := GetSeverity(EventID := ArEventLogRead_0.EventID);
						ELSE
							LogbookInterface.Data.Entries.Severity[idx] := ArEventLogReadErrorNumber_0.Severity;
						END_IF
						LogbookInterface.Data.Entries.Code[idx] := GetCode(EventID := ArEventLogRead_0.EventID);
						LogbookInterface.Data.Entries.FacilityCode[idx] := GetFacility(EventID := ArEventLogRead_0.EventID);
						LogbookInterface.Data.Entries.LogbookName[idx] := LOGBOOK_TEXT[Logbook.CntLogbook];
						// Add error number and text, use event ID if error no is 0
						IF ArEventLogReadErrorNumber_0.ErrorNumber <> 0 THEN
							LogbookInterface.Data.Entries.ErrorNo[idx] := ArEventLogReadErrorNumber_0.ErrorNumber;
						ELSE
							LogbookInterface.Data.Entries.ErrorNo[idx] := ArEventLogRead_0.EventID;
						END_IF
						httpUtf8ToString_0(enable := TRUE, pSrc := ADR(ErrorText), pDest := ADR(LogbookInterface.Data.Entries.ErrorText[idx]), destSize := SIZEOF(LogbookInterface.Data.Entries.ErrorText[idx]));
					END_IF
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Hide unused table rows
				brsitoa(LogbookInterface.Data.EntriesTotal, ADR(tmpSTR));
				LogbookInterface.Par.TableConfig := '{"specRows":[{"from":';
				brsstrcat(ADR(LogbookInterface.Par.TableConfig), ADR(tmpSTR));
				brsstrcat(ADR(LogbookInterface.Par.TableConfig), ADR(', "to":'));
				brsitoa(LOGBOOK_ENTRIES_MAX, ADR(tmpSTR));
				brsstrcat(ADR(LogbookInterface.Par.TableConfig), ADR(tmpSTR));
				brsstrcat(ADR(LogbookInterface.Par.TableConfig), ADR(', "visible":false}]}'));	
				
				LogbookState := STATE_PREP;
			
		// --------------------------------------------------------------------------------------------------------------------
		// Perpare for next entry
		// --------------------------------------------------------------------------------------------------------------------
			STATE_PREP:
				// --------------------------------------------------------------------------------------------------------------------
				// Reset buffer and function blocks
				brsmemset(ADR(AddData), 0, SIZEOF(AddData));
				ArEventLogGetLatestRecordID_0(Execute := FALSE);
				ArEventLogGetPreviousRecordID_0(Execute := FALSE);
				ArEventLogRead_0(Execute := FALSE);
				ArEventLogReadErrorNumber_0(Execute := FALSE);
				ArEventLogReadDescription_0(Execute := FALSE);
				ArEventLogReadAddData_0(Execute := FALSE);
				ArEventLogReadObjectID_0(Execute := FALSE);
				
				// --------------------------------------------------------------------------------------------------------------------
				// Find next logbook from here to the end
				REPEAT 
					Logbook.CntLogbook := Logbook.CntLogbook + 1;
					IF Logbook.CntLogbook <= LOGBOOK_BOOKS_MAX THEN
						IF (Logbook.Ident[Logbook.CntLogbook] <> 0 AND NOT Logbook.RecordIDIsLast[Logbook.CntLogbook]) OR (Logbook.Ident[Logbook.CntLogbook] <> 0 AND Logbook.RecordID[Logbook.CntLogbook] = 0) THEN
							EXIT;
						END_IF
					END_IF
					UNTIL Logbook.CntLogbook > LOGBOOK_BOOKS_MAX
				END_REPEAT;

				// --------------------------------------------------------------------------------------------------------------------
				// No logbook found, start at the beginning
				IF Logbook.CntLogbook > LOGBOOK_BOOKS_MAX THEN
					Logbook.CntLogbook := 0;
					// Find next logbook from start to the end
					REPEAT 
						IF (Logbook.Ident[Logbook.CntLogbook] <> 0 AND NOT Logbook.RecordIDIsLast[Logbook.CntLogbook]) OR (Logbook.Ident[Logbook.CntLogbook] <> 0 AND Logbook.RecordID[Logbook.CntLogbook] = 0) THEN
							EXIT;
						END_IF
						Logbook.CntLogbook := Logbook.CntLogbook + 1;
						UNTIL Logbook.CntLogbook > LOGBOOK_BOOKS_MAX
					END_REPEAT;
				END_IF

				// --------------------------------------------------------------------------------------------------------------------
				// Finish when no logbook found or max entries is reached
				IF Logbook.CntLogbook > LOGBOOK_BOOKS_MAX OR (LogbookInterface.Par.AbortOnEntriesLimit AND LogbookInterface.Data.EntriesTotal = LOGBOOK_ENTRIES_MAX) THEN
					// Add last update
					DT_TO_DTStructure(LogbookInterface.Par.DateNow, ADR(tmpDTstruct));
					brsmemset(ADR(LogbookInterface.Data.LastUpdate), 0, SIZEOF(LogbookInterface.Data.LastUpdate));
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.day, '');
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.month, '.');
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.year, '.');
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.hour, ' ');
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.minute, ':');
					NormalizeDateTime(ADR(LogbookInterface.Data.LastUpdate), tmpDTstruct.second, ':');
					// Reset status and command
					LogbookInterface.Status := ERR_OK;
					LogbookInterface.Cmd.Refresh := FALSE;
					LogbookInterface.Cmd.Update := FALSE;
					LogbookState := STATE_WAIT;
				ELSE
					// Read latest entry
					IF Logbook.RecordID[Logbook.CntLogbook] = 0 THEN
						LogbookState := STATE_LATEST;
						// Read next entry
					ELSE
						LogbookState := STATE_NEXT;
					END_IF
				END_IF
				
		// --------------------------------------------------------------------------------------------------------------------
		// Error state
		// --------------------------------------------------------------------------------------------------------------------
			STATE_ERROR:
				LogbookInterface.StatusText := 'Error...';
				brsmemset(ADR(LogbookInterface.Cmd), 0, SIZEOF(LogbookInterface.Cmd)-1);
				// Reset error
				IF LogbookInterface.Cmd.ResetError THEN
					LogbookInterface.Error.State := STATE_NONE;
					LogbookInterface.Status := 0;
					LogbookInterface.Cmd.ResetError := FALSE;
					LogbookState := STATE_WAIT;	
				END_IF
				EXIT;
		END_CASE;
	END_FOR;


END_PROGRAM

