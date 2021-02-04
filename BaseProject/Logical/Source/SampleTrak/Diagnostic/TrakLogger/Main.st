//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
// Copyright B&R Industrial Automation GmbH
// Author    B&R
// Created   Feb 1, 2018
// 
// trak motion logger filter task (optional)
// TC#8 => mandatory to be attached to idle task class!
// 
// * filters the "Motion" logger to display the newest 10 entries with severity "Error" or "Warning" entered by segments
// 
// "TrakLogger" - local interface structure
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



PROGRAM _CYCLIC

	MC_BR_AsmReadStatus_AcpTrak_0.Assembly := TrakLogger.AssemblyRef;
	MC_BR_AsmReadStatus_AcpTrak_0.Enable := TRUE;
	MC_BR_AsmReadStatus_AcpTrak_0();

	MC_BR_SegCommandError_AcpTrak_0(Segment := ADR(gSeg_A_1));
	
	IF EDGEPOS(MC_BR_AsmReadStatus_AcpTrak_0.AssemblyErrorStop) THEN
		TrakLogger.CmdRefresh := TRUE;
	END_IF

	REPEAT
		StepLast := Step;
		
		CASE Step OF
		
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// command
			TRAK_COMMAND:
				IF TrakLogger.CmdRefresh THEN
					Step := TRAK_RESET;
				END_IF
			
				
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// wait till all messages are entered into logger
			TRAK_RESET:
				FubTonWaitFirst.IN := TRUE;
				FubTonWaitFirst.PT := T#1s;
				FubTonWaitFirst();
				IF FubTonWaitFirst.Q THEN
					FubTonWaitFirst.IN := FALSE;
					
					brsmemset(ADR(TrakLogger.Record), 0, SIZEOF(TrakLogger.Record));
					TrakLogger.Message := '';
					SegmentErrorFound := 0;
					brsmemset(ADR(AlarmCount), 0, SIZEOF(AlarmCount));
									
					ArEventLogGetIdent_0.Execute			:= FALSE;
					ArEventLogGetLatestRecordID_0.Execute	:= FALSE;
					ArEventLogGetPreviousRecordID_0.Execute	:= FALSE;
					ArEventLogRead_0.Execute				:= FALSE;
					ArEventLogReadObjectID_0.Execute		:= FALSE;
					ArEventLogReadDescription_0.Execute		:= FALSE;
					Step := TRAK_GET_IDENT;
				END_IF
	
				
			///////////////////////////////////////////////////////////////////////////
			// open logger and read first EventID
			TRAK_GET_IDENT:
				ArEventLogGetIdent_0.Execute	:= TRUE;
				brsstrcpy(ADR(ArEventLogGetIdent_0.Name), ADR('$$motion'));
				Step := TRAK_GET_IDENT_WAIT;

			TRAK_GET_IDENT_WAIT:
				IF ArEventLogGetIdent_0.Done THEN
					Ident := ArEventLogGetIdent_0.Ident;
					ArEventLogGetIdent_0.Execute := FALSE;
					Step := TRAK_GET_LATEST_ID;
				ELSIF ArEventLogGetIdent_0.Error THEN
					TrakLogger.Message := 'Error GetIdent';
					Step := TRAK_ERROR;
				END_IF

							
			TRAK_GET_LATEST_ID:
				ArEventLogGetLatestRecordID_0.Execute	:= TRUE;
				ArEventLogGetLatestRecordID_0.Ident		:= Ident;
				Step := TRAK_GET_LATEST_ID_WAIT;

			TRAK_GET_LATEST_ID_WAIT:
				IF ArEventLogGetLatestRecordID_0.Done THEN
					RecordID := ArEventLogGetLatestRecordID_0.RecordID;
					ArEventLogGetLatestRecordID_0.Execute := FALSE;
					Step := TRAK_READ_ID;
				ELSIF ArEventLogGetLatestRecordID_0.Error THEN
					TrakLogger.Message := 'Error GetLatestRecordID';
					Step := TRAK_ERROR;
				END_IF
			
				
			///////////////////////////////////////////////////////////////////////////
			// read previous EventID
			TRAK_GET_PREVIOUS_ID:
				ArEventLogGetPreviousRecordID_0.Execute		:= TRUE;
				ArEventLogGetPreviousRecordID_0.Ident		:= Ident;
				ArEventLogGetPreviousRecordID_0.RecordID	:= RecordID;
				Step := TRAK_GET_PREVIOUS_ID_WAIT;
				
				

			TRAK_GET_PREVIOUS_ID_WAIT:
				IF ArEventLogGetPreviousRecordID_0.Done THEN
					RecordID := ArEventLogGetPreviousRecordID_0.PrevRecordID;
					ArEventLogGetPreviousRecordID_0.Execute := FALSE;
					Step := TRAK_READ_ID;
				ELSIF ArEventLogGetPreviousRecordID_0.Error THEN
					IF ArEventLogGetPreviousRecordID_0.StatusID = arEVENTLOG_ERR_RECORDID_INVALID THEN		// reached end of logger
						ArEventLogGetPreviousRecordID_0.Execute := FALSE;
						Step := TRAK_DONE;
					ELSE
						TrakLogger.Message := 'Error GetPreviousRecordID';
						Step := TRAK_ERROR;
					END_IF
				END_IF
			
				
			///////////////////////////////////////////////////////////////////////////
			// check if severity is 'Error' or 'Warning'
			TRAK_READ_ID:
				ArEventLogRead_0.Execute	:= TRUE;
				ArEventLogRead_0.Ident		:= Ident;
				ArEventLogRead_0.RecordID	:= RecordID;
				Step := TRAK_READ_ID_WAIT;

			TRAK_READ_ID_WAIT:
				IF ArEventLogRead_0.Done THEN
					EventID := ArEventLogRead_0.EventID;
					ArEventLogRead_0.Execute := FALSE;
					EventTimeStamp := ArEventLogRead_0.TimeStamp;

					EventIDSeverity	:= DINT_TO_USINT(SHR(EventID, 30) AND 16#03);
					EventIDFacility	:= DINT_TO_UINT(SHR(EventID, 16) AND 16#0FFF);
					EventIDCode		:= DINT_TO_UINT(SHR(EventID, 0) AND 16#FFFF);

					IF ((EventIDSeverity = arEVENTLOG_SEVERITY_ERROR) AND (TrakLogger.ParaShowSegError)) THEN
						Step := TRAK_CHECK_FILTER;
					ELSIF ((EventIDSeverity = arEVENTLOG_SEVERITY_WARNING) AND (TrakLogger.ParaShowSegWarning)) THEN
						Step := TRAK_CHECK_FILTER;
					ELSE
						Step := TRAK_GET_PREVIOUS_ID;
					END_IF
				ELSIF ArEventLogRead_0.Error THEN
					TrakLogger.Message := 'Error ReadRecordID';
					Step := TRAK_ERROR;
				END_IF
	
				
			///////////////////////////////////////////////////////////////////////////
			// check if 'Error' has been entered by a Segment
			TRAK_CHECK_FILTER:
				ArEventLogReadObjectID_0.Execute	:= TRUE;
				ArEventLogReadObjectID_0.Ident		:= Ident;
				ArEventLogReadObjectID_0.RecordID	:= RecordID;
				Step := TRAK_CHECK_FILTER_WAIT;

			TRAK_CHECK_FILTER_WAIT:
				IF ArEventLogReadObjectID_0.Done THEN
					ObjectID := ArEventLogReadObjectID_0.ObjectID;
					ArEventLogReadObjectID_0.Execute := FALSE;
					IF brsmemcmp(ADR(ObjectID), ADR(TrakLogger.ParaSegFilter), 3) = 0 THEN
						Step := TRAK_READ_DESCRIPTION;
					ELSE
						Step := TRAK_GET_PREVIOUS_ID;
					END_IF
				ELSIF ArEventLogReadObjectID_0.Error THEN
					TrakLogger.Message := 'Error ReadObjectID';
					Step := TRAK_ERROR;
				END_IF
	
				
			///////////////////////////////////////////////////////////////////////////
			// read and display description text if filter criterias are matching
			TRAK_READ_DESCRIPTION:
				ArEventLogReadDescription_0.Execute			:= TRUE;
				ArEventLogReadDescription_0.Ident			:= Ident;
				ArEventLogReadDescription_0.RecordID		:= RecordID;
			//	ArEventLogReadDescription_0.LanguageCode	:= ;
			//	ArEventLogReadDescription_0.Qualifier		:= ;
				ArEventLogReadDescription_0.TextBuffer		:= ADR(Description);
				ArEventLogReadDescription_0.TextBufferSize	:= SIZEOF(Description);
				Step := TRAK_READ_DESCRIPTION_WAIT;

			TRAK_READ_DESCRIPTION_WAIT:
				IF ArEventLogReadDescription_0.Done THEN
					ArEventLogReadDescription_0.Execute := FALSE;
					Step := TRAK_UPDATE_LIST;
				ELSIF ArEventLogReadDescription_0.Error THEN
					TrakLogger.Message := 'Error ReadDescription';
					Step := TRAK_ERROR;
				END_IF
	
			TRAK_UPDATE_LIST:
				TrakLogger.Record[SegmentErrorFound].ObjectID			:= ObjectID;
				TrakLogger.Record[SegmentErrorFound].EventID			:= EventID;
				TrakLogger.Record[SegmentErrorFound].EventIDSeverity	:= EventIDSeverity;
				TrakLogger.Record[SegmentErrorFound].EventIDFacility	:= EventIDFacility;
				TrakLogger.Record[SegmentErrorFound].EventIDCode		:= EventIDCode;
				TrakLogger.Record[SegmentErrorFound].Description		:= Description;

				TrakLogger.Record[SegmentErrorFound].EventTimeStamp	:= UDINT_TO_TIME((EventTimeStamp.sec MOD (24*60*60))*1000 + (EventTimeStamp.nsec / 1000000));		// convert to TIME format (ms since start of day)

				brsstrcpy(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(''));
				ascTIME(TrakLogger.Record[SegmentErrorFound].EventTimeStamp, ADR(TempString), SIZEOF(TempString));
				TIME_TO_TIMEStructure(TrakLogger.Record[SegmentErrorFound].EventTimeStamp,ADR(TimeStruct)); // for checking against older entries

				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(TempString));
				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(' => '));

				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(ObjectID));
	
				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(': Error '));
				brsitoa(EventIDCode, ADR(TempString));
				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(TempString));
	
				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(' => '));
				brsstrcat(ADR(TrakLogger.Record[SegmentErrorFound].Text), ADR(Description));
				
				IF SegmentErrorFound = 0 THEN
					FirstEntryCheckSum := TimeStruct.minute; // save the timestamp minute of the first entry as checksum
				END_IF	
				
				SegmentErrorFound := SegmentErrorFound + 1;
							
				SetAlarmIDCode; //case statement to trigger alarms
					
				// stop reading the logger when the end of the array is reached OR 
				// when the entries start having a different timestamp which means they are older
				IF SegmentErrorFound > 499 OR (FirstEntryCheckSum <> (TimeStruct.minute) ) THEN 
					Step := TRAK_DONE;
				ELSE
					Step := TRAK_GET_PREVIOUS_ID;
				END_IF
			
				
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			TRAK_DONE:
				TrakLogger.CmdRefresh := FALSE;
				Step := TRAK_COMMAND;
	
				
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			TRAK_ERROR:
				IF TrakLogger.CmdRefresh = 0 THEN
					TrakLogger.Message := '';
					ArEventLogGetIdent_0.Execute			:= FALSE;
					ArEventLogGetLatestRecordID_0.Execute	:= FALSE;
					ArEventLogGetPreviousRecordID_0.Execute	:= FALSE;
					ArEventLogRead_0.Execute				:= FALSE;
					ArEventLogReadObjectID_0.Execute		:= FALSE;
					ArEventLogReadDescription_0.Execute		:= FALSE;
					Step := TRAK_COMMAND;
				END_IF
			
		END_CASE
	
		ArEventLogGetIdent_0();
		ArEventLogGetLatestRecordID_0();
		ArEventLogGetPreviousRecordID_0();
		ArEventLogRead_0();
		ArEventLogReadObjectID_0();
		ArEventLogReadDescription_0();
		
	UNTIL
		// to speed processing time of this sequence up: repeat sequence till the step is not changing any more (sequence is waiting for a FUB)
		Step = StepLast

	END_REPEAT
	
	
END_PROGRAM





PROGRAM _EXIT

END_PROGRAM

