// --------------------------------------------------------------------------------------------------------------------
// Logbook Task
// This task reads the PLC logbook and creates the data structure to display it in mappView
// --------------------------------------------------------------------------------------------------------------------
PROGRAM _INIT
	// Set time range to all on startup
	DTGetTime_0.enable := TRUE;
	DTGetTime_0();
	gLogbook.PAR.FilterDateStart := STRING_TO_DATE('D#1999-12-31');
	gLogbook.PAR.FilterDateEnd := DT_TO_DATE(DTGetTime_0.DT1);
	
	// Read data after reboot
	gLogbook.CMD.Refresh := TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	// Abort current update run
	IF EDGENEG(gLogbook.CMD.Refresh) THEN
		IF 	state <> stateError THEN
			gLogbook.Status := ERR_OK;
			state := stateWait;
		END_IF
	END_IF
	// Run task multiple times to speed up process
	FOR executions:=1 TO LOGBOOK_EXECUTIONS DO
		// --------------------------------------------------------------------------------------------------------------------
		// Logbook state machine
		// --------------------------------------------------------------------------------------------------------------------
		CASE state OF
			// --------------------------------------------------------------------------------------------------------------------
			// Wait for new command
			// --------------------------------------------------------------------------------------------------------------------
			stateWait:
				// --------------------------------------------------------------------------------------------------------------------
				// Get current date
				DTGetTime_0.enable := TRUE;
				DTGetTime_0();
				gLogbook.PAR.DateNow := DTGetTime_0.DT1;
				gLogbook.PAR.EntriesMax := LOGBOOK_ENTRIES_MAX;
				
				// --------------------------------------------------------------------------------------------------------------------
				// Refresh all logbook data
				IF gLogbook.CMD.Refresh THEN
					// Erase old data, set busy state
					brsmemset(ADR(Logbook), 0, SIZEOF(Logbook));
					brsmemset(ADR(gLogbook.DAT), 0, SIZEOF(gLogbook.DAT));
					gLogbook.Status := ERR_FUB_BUSY;
					state := stateOpen;
				END_IF

				// --------------------------------------------------------------------------------------------------------------------
				// Auto update logbook data 
				IF gLogbook.PAR.AutoUpdate THEN
					AutoRefresh.IN := TRUE;
					AutoRefresh.PT := gLogbook.PAR.AutoUpdateInterval*100;
					AutoRefresh();
					IF AutoRefresh.Q THEN
						AutoRefresh(IN:= FALSE);
						gLogbook.CMD.Update := TRUE;
						state := stateNext;
					END_IF
				ELSE
					AutoRefresh(IN:= FALSE);
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Update only latest logbook data
				IF gLogbook.CMD.Update THEN
					brsmemset(ADR(Logbook.RecordIDIsLast), 0, SIZEOF(Logbook.RecordIDIsLast));
					brsmemset(ADR(Logbook.RecordID), 0, SIZEOF(Logbook.RecordID));
					// Start at the beginning set busy state
					Logbook.CntLogbook := 0;
					gLogbook.Status := ERR_FUB_BUSY;
					state := stateLatest;
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Create new logbook entry
				IF gLogbook.CMD.Create THEN
					gLogbook.Status := ERR_FUB_BUSY;
					state := stateCreate;
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
				
				// --------------------------------------------------------------------------------------------------------------------
				// Show status, reset error command
				gLogbook.CMD.ResetError := FALSE;
				gLogbook.StatusText := 'Waiting...last update ';
				brsstrcat(ADR(gLogbook.StatusText), ADR(gLogbook.DAT.LastUpdate));
				EXIT;
				// --------------------------------------------------------------------------------------------------------------------
				// Create a new logbook entry
				// --------------------------------------------------------------------------------------------------------------------
			stateCreate:
				eventID := ArEventLogMakeEventID(UDINT_TO_USINT(gLogbook.PAR.CreateSeverity), 0 , gLogbook.PAR.CreateErrorNo);
				brsmemset(ADR(AddData), 0, SIZEOF(AddData));
				brsstrcpy(ADR(AddData), ADR(gLogbook.PAR.CreateErrorText));
				
				ArEventLogWrite_0.Execute := TRUE;
				ArEventLogWrite_0.Ident := Logbook.Ident[gLogbook.PAR.CreateLogbook];
				ArEventLogWrite_0.EventID := eventID;
				ArEventLogWrite_0.ObjectID := 'User event';
				ArEventLogWrite_0.AddDataFormat := arEVENTLOG_ADDFORMAT_TEXT;
				ArEventLogWrite_0.AddData := ADR(AddData);
				ArEventLogWrite_0.AddDataSize := brsstrlen(ADR(AddData));
				ArEventLogWrite_0();

				// Success
				IF ArEventLogWrite_0.Done AND ArEventLogWrite_0.StatusID = ERR_OK THEN
					ArEventLogWrite_0(Execute := FALSE);
					gLogbook.CMD.Create := FALSE;
					gLogbook.CMD.Update := TRUE;
					state := stateWait;
				// Error
				ELSIF ArEventLogWrite_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogWrite_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Open logbook
				// --------------------------------------------------------------------------------------------------------------------
			stateOpen:
				// Last logbook reached 
				IF Logbook.CntLogbook > LOGBOOK_BOOKS_MAX THEN				
					Logbook.CntLogbook := 0;
					state := stateLatest;
					EXIT;
				END_IF
				ArEventLogGetIdent_0.Execute := gLogbook.CMD.Refresh;
				ArEventLogGetIdent_0.Name := LOGBOOK_NAMES[Logbook.CntLogbook];
				ArEventLogGetIdent_0();
	
				// Success
				IF (ArEventLogGetIdent_0.Done AND ArEventLogGetIdent_0.StatusID = ERR_OK) OR ArEventLogGetIdent_0.StatusID = arEVENTLOG_ERR_LOGBOOK_NOT_FOUND THEN
					Logbook.Ident[Logbook.CntLogbook] := ArEventLogGetIdent_0.Ident;
					Logbook.CntLogbook := Logbook.CntLogbook + 1;					
					ArEventLogGetIdent_0(Execute := FALSE);
					// Error
				ELSIF ArEventLogGetIdent_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogGetIdent_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read latest entry
				// --------------------------------------------------------------------------------------------------------------------
			stateLatest:
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
						state := stateDetails1;
						// No new entry
					ELSE
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						state := statePrep;
					END_IF
					// Error
				ELSIF ArEventLogGetLatestRecordID_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogGetLatestRecordID_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read next entry
				// --------------------------------------------------------------------------------------------------------------------
			stateNext:
				animation := WorkingStatus(ADR(gLogbook.StatusText), ADR('reading entries...'), animation);
				ArEventLogGetPreviousRecordID_0.Execute := TRUE;
				ArEventLogGetPreviousRecordID_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogGetPreviousRecordID_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogGetPreviousRecordID_0();

				// Success
				IF ArEventLogGetPreviousRecordID_0.Done AND ArEventLogGetPreviousRecordID_0.StatusID = ERR_OK THEN
					// Store this record ID for next step
					Logbook.RecordID[Logbook.CntLogbook] := ArEventLogGetPreviousRecordID_0.PrevRecordID;
					// Stop update when previous record ID is reached
					IF Logbook.RecordID[Logbook.CntLogbook] = Logbook.RecordIDOld[Logbook.CntLogbook] AND gLogbook.CMD.Update THEN
						// Remember latest entry, set is last flag
						Logbook.RecordIDOld[Logbook.CntLogbook] := Logbook.RecordIDLatest[Logbook.CntLogbook];
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						state := statePrep;
					ELSE
						state := stateDetails1;
					END_IF
					// Error
				ELSIF ArEventLogGetPreviousRecordID_0.Error THEN
					// Last entry reached is not an error
					IF ArEventLogGetPreviousRecordID_0.StatusID = arEVENTLOG_ERR_RECORDID_INVALID THEN
						// Remember latest entry, set is last flag
						Logbook.RecordIDOld[Logbook.CntLogbook] := Logbook.RecordIDLatest[Logbook.CntLogbook];
						Logbook.RecordIDIsLast[Logbook.CntLogbook] := TRUE;
						state := statePrep;
						// Everything else is an error
					ELSE
						gLogbook.ERR.State := state;
						gLogbook.Status := ArEventLogGetPreviousRecordID_0.StatusID;
						state := stateError;
					END_IF
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read event id and time stamp
				// --------------------------------------------------------------------------------------------------------------------
			stateDetails1:
				ArEventLogRead_0.Execute := TRUE;
				ArEventLogRead_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogRead_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogRead_0();

				// Success
				IF ArEventLogRead_0.Done AND (ArEventLogRead_0.StatusID = ERR_OK OR ArEventLogRead_0.StatusID = arEVENTLOG_WRN_NO_EVENTID) THEN
					state := stateDetails2;
				// Error
				ELSIF ArEventLogRead_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogRead_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read error no
				// --------------------------------------------------------------------------------------------------------------------
			stateDetails2:
				ArEventLogReadErrorNumber_0.Execute := TRUE;
				ArEventLogReadErrorNumber_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogReadErrorNumber_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogReadErrorNumber_0();

				// Success
				IF (ArEventLogReadErrorNumber_0.Done AND ArEventLogReadErrorNumber_0.StatusID = ERR_OK) OR ArEventLogReadErrorNumber_0.StatusID = arEVENTLOG_ERR_NO_ERRORNUMBER THEN
					brsmemset(ADR(ErrorText), 0, SIZEOF(ErrorText));
					state := stateDetails3;
				// Error
				ELSIF ArEventLogReadErrorNumber_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogReadErrorNumber_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read error description
				// --------------------------------------------------------------------------------------------------------------------
			stateDetails3:
				ArEventLogReadDescription_0.Execute := TRUE;
				ArEventLogReadDescription_0.Ident := Logbook.Ident[Logbook.CntLogbook];
				ArEventLogReadDescription_0.RecordID := Logbook.RecordID[Logbook.CntLogbook];
				ArEventLogReadDescription_0.TextBuffer := ADR(ErrorText);
				ArEventLogReadDescription_0.TextBufferSize := SIZEOF(ErrorText);
				ArEventLogReadDescription_0();

				// Success
				IF (ArEventLogReadDescription_0.Done AND (ArEventLogReadDescription_0.StatusID = ERR_OK OR ArEventLogReadDescription_0.StatusID = arEVENTLOG_WRN_NO_EVENTID)) OR ArEventLogReadDescription_0.StatusID = arEVENTLOG_ERR_NO_DESCRIPTION THEN
					brsmemset(ADR(AddData), 0, SIZEOF(AddData));
					state := stateDetails4;
				// Error
				ELSIF ArEventLogReadDescription_0.Error THEN
					gLogbook.ERR.State := state;
					gLogbook.Status := ArEventLogReadDescription_0.StatusID;
					state := stateError;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Read additional information
				// --------------------------------------------------------------------------------------------------------------------
			stateDetails4:
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
						state := stateFilter;
					// Error
					ELSIF ArEventLogReadDescription_0.Error THEN
						gLogbook.ERR.State := state;
						gLogbook.Status := ArEventLogReadAddData_0.StatusID;
						state := stateError;
					END_IF
				ELSE
					state := stateFilter;
				END_IF				
				// --------------------------------------------------------------------------------------------------------------------
				// Apply filter settings
				// --------------------------------------------------------------------------------------------------------------------
			stateFilter:
				// --------------------------------------------------------------------------------------------------------------------
				// Filters
				cntFilterNo := 0;
				cntFilterText := 0;
				cntFilterLogbook := 0;
				cntFilterSeverity := 0;
				cntFilterDate := 0;
				// --------------------------------------------------------------------------------------------------------------------
				// Check if logbook should be read
				IF  gLogbook.PAR.FilterLogbook[Logbook.CntLogbook] THEN
					cntFilterLogbook := cntFilterLogbook + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check if error text matches search string
				IF gLogbook.PAR.FilterErrorText = '' OR IsInstr(ADR(ErrorText), ADR(gLogbook.PAR.FilterErrorText)) THEN
					cntFilterText := cntFilterText + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Make sure error number matches filter
				IF gLogbook.PAR.FilterErrorNo = 0 OR gLogbook.PAR.FilterErrorNo = ArEventLogReadErrorNumber_0.ErrorNumber THEN
					cntFilterNo := cntFilterNo + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check severity filter settings
				IF ArEventLogRead_0.EventID <> 0 THEN
					gLogbook.DAT.CntSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] := gLogbook.DAT.CntSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] + 1;
					IF gLogbook.PAR.FilterSeverity[GetSeverity(EventID := ArEventLogRead_0.EventID)] THEN
						cntFilterSeverity := cntFilterSeverity + 1;
					END_IF
				ELSE
					gLogbook.DAT.CntSeverity[ArEventLogReadErrorNumber_0.Severity] := gLogbook.DAT.CntSeverity[ArEventLogReadErrorNumber_0.Severity] + 1;
					IF gLogbook.PAR.FilterSeverity[ArEventLogReadErrorNumber_0.Severity] THEN
						cntFilterSeverity := cntFilterSeverity + 1;
					END_IF
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Check date range
				tmpSTR:= DT_TO_STRING(DATE_TO_DT(gLogbook.PAR.FilterDateStart));
				brsmemcpy(ADR(tmpSTR)+13, ADR('-00:00:00'), 9);
				TimeStart := STRING_TO_DT(tmpSTR);
				tmpSTR:= DT_TO_STRING(DATE_TO_DT(gLogbook.PAR.FilterDateEnd));
				brsmemcpy(ADR(tmpSTR)+13, ADR('-23:59:59'), 9);
				TimeEnd := STRING_TO_DT(tmpSTR);
				IF ArEventLogRead_0.TimeStamp.sec >= DT_TO_UDINT(TimeStart) AND ArEventLogRead_0.TimeStamp.sec <= DT_TO_UDINT(TimeEnd) THEN
					cntFilterDate := cntFilterDate + 1;
				END_IF
				// --------------------------------------------------------------------------------------------------------------------
				// Count logbook entries
				gLogbook.DAT.CntLogbook[Logbook.CntLogbook] := gLogbook.DAT.CntLogbook[Logbook.CntLogbook] +  1;
			
				// --------------------------------------------------------------------------------------------------------------------
				// Transfer data
				IF cntFilterNo > 0 AND cntFilterText > 0 AND cntFilterLogbook > 0 AND cntFilterSeverity > 0 AND cntFilterDate > 0 THEN						
					// --------------------------------------------------------------------------------------------------------------------
					// Find new place for entry
					idx := InsertEntry(ADR(gLogbook.DAT), ArEventLogRead_0.TimeStamp.sec, UDINT_TO_UINT(ArEventLogRead_0.TimeStamp.nsec/1000000), gLogbook.PAR.Sorting);
					IF idx <> NO_SPACE THEN
						// Store date and time
						gLogbook.DAT.Entries.DTsec[idx] := ArEventLogRead_0.TimeStamp.sec;
						gLogbook.DAT.Entries.DTmsec[idx] := UDINT_TO_UINT(ArEventLogRead_0.TimeStamp.nsec/1000000);
						// Add timestamp
						tmpDT := UDINT_TO_DT(ArEventLogRead_0.TimeStamp.sec);
						DT_TO_DTStructure(tmpDT, ADR(tmpDTstruct));
						brsmemset(ADR(gLogbook.DAT.Entries.Timestamp[idx]), 0, SIZEOF(gLogbook.DAT.Entries.Timestamp[idx]));
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.day, '');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.month, '.');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.year, '.');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.hour, ' ');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.minute, ':');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), tmpDTstruct.second, ':');
						NormalizeDateTime(ADR(gLogbook.DAT.Entries.Timestamp[idx]), gLogbook.DAT.Entries.DTmsec[idx], '.');
						// Add event ID, code, logbook, severity
						gLogbook.DAT.Entries.EventID[gLogbook.DAT.EntriesTotal] := ArEventLogRead_0.EventID;
						IF ArEventLogRead_0.EventID <> 0 THEN
							gLogbook.DAT.Entries.Severity[idx] := GetSeverity(EventID := ArEventLogRead_0.EventID);
						ELSE
							gLogbook.DAT.Entries.Severity[idx] := ArEventLogReadErrorNumber_0.Severity;
						END_IF
						gLogbook.DAT.Entries.Code[idx] := GetCode(EventID := ArEventLogRead_0.EventID);
						gLogbook.DAT.Entries.FacilityCode[idx] := GetFacility(EventID := ArEventLogRead_0.EventID);
						gLogbook.DAT.Entries.LogbookName[idx] := LOGBOOK_TEXT[Logbook.CntLogbook];
						// Add error number and text, use event ID if error no is 0
						IF ArEventLogReadErrorNumber_0.ErrorNumber <> 0 THEN
							gLogbook.DAT.Entries.ErrorNo[idx] := ArEventLogReadErrorNumber_0.ErrorNumber;
						ELSE
							gLogbook.DAT.Entries.ErrorNo[idx] := ArEventLogRead_0.EventID;
						END_IF
						httpUtf8ToString_0(enable := TRUE, pSrc := ADR(ErrorText), pDest := ADR(gLogbook.DAT.Entries.ErrorText[idx]), destSize := SIZEOF(gLogbook.DAT.Entries.ErrorText[idx]));
					END_IF
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Hide unused table rows
				brsitoa(gLogbook.DAT.EntriesTotal, ADR(tmpSTR));
				gLogbook.PAR.TableConfig := '{"specRows":[{"from":';
				brsstrcat(ADR(gLogbook.PAR.TableConfig), ADR(tmpSTR));
				brsstrcat(ADR(gLogbook.PAR.TableConfig), ADR(', "to":'));
				brsitoa(LOGBOOK_ENTRIES_MAX, ADR(tmpSTR));
				brsstrcat(ADR(gLogbook.PAR.TableConfig), ADR(tmpSTR));
				brsstrcat(ADR(gLogbook.PAR.TableConfig), ADR(', "visible":false}]}'));	
				
				state := statePrep;
			
				// --------------------------------------------------------------------------------------------------------------------
				// Perpare for next entry
				// --------------------------------------------------------------------------------------------------------------------
			statePrep:
				// --------------------------------------------------------------------------------------------------------------------
				// Reset buffer and function blocks
				brsmemset(ADR(AddData), 0, SIZEOF(AddData));
				ArEventLogGetLatestRecordID_0(Execute := FALSE);
				ArEventLogGetPreviousRecordID_0(Execute := FALSE);
				ArEventLogRead_0(Execute := FALSE);
				ArEventLogReadErrorNumber_0(Execute := FALSE);
				ArEventLogReadDescription_0(Execute := FALSE);
				ArEventLogReadAddData_0(Execute := FALSE);
				
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
				IF Logbook.CntLogbook > LOGBOOK_BOOKS_MAX OR (gLogbook.PAR.AbortOnEntriesLimit AND gLogbook.DAT.EntriesTotal = LOGBOOK_ENTRIES_MAX) THEN
					// Add last update
					DT_TO_DTStructure(gLogbook.PAR.DateNow, ADR(tmpDTstruct));
					brsmemset(ADR(gLogbook.DAT.LastUpdate), 0, SIZEOF(gLogbook.DAT.LastUpdate));
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.day, '');
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.month, '.');
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.year, '.');
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.hour, ' ');
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.minute, ':');
					NormalizeDateTime(ADR(gLogbook.DAT.LastUpdate), tmpDTstruct.second, ':');
					// Reset status and command
					gLogbook.Status := ERR_OK;
					gLogbook.CMD.Refresh := FALSE;
					gLogbook.CMD.Update := FALSE;
					state := stateWait;
				ELSE
					// Read latest entry
					IF Logbook.RecordID[Logbook.CntLogbook] = 0 THEN
						state := stateLatest;
						// Read next entry
					ELSE
						state := stateNext;
					END_IF
				END_IF
				
				// --------------------------------------------------------------------------------------------------------------------
				// Error state
				// --------------------------------------------------------------------------------------------------------------------
			stateError:
				gLogbook.StatusText := 'Error...';
				brsmemset(ADR(gLogbook.CMD), 0, SIZEOF(gLogbook.CMD)-1);
				// Reset error
				IF gLogbook.CMD.ResetError THEN
					gLogbook.ERR.State := stateNone;
					gLogbook.Status := 0;
					gLogbook.CMD.ResetError := FALSE;
					state := stateWait;	
				END_IF
				EXIT;
		END_CASE;
	END_FOR;


END_PROGRAM

