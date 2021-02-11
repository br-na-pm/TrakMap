
ACTION TrakLoggerInit: 

	TrakLogger.CmdRefresh			:= FALSE;
	TrakLogger.ParaShowSegError		:= TRUE;
	TrakLogger.ParaShowSegWarning	:= TRUE;
	TrakLogger.ParaSegFilter		:= 'Asm';//'gSeg_';

	Step := TRAK_COMMAND;


END_ACTION


ACTION TrakLoggerCyclic: 

	MC_BR_SegCommandError_AcpTrak_0(Segment := ADR(TrackDiag.Seg.SegList[0].McType));
	
	IF MC_BR_SegCommandError_AcpTrak_0.Done THEN
		MC_BR_SegCommandError_AcpTrak_0.Execute := FALSE;
	END_IF	
	
	IF EDGEPOS(TrackDiag.Asm.AssemblyErrorStop) THEN
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
	


END_ACTION


		
ACTION SetAlarmIDCode: 
		
		// EventIDCode add new alarms triggers at the end otherwise 
		// the AlarmCount has to be adjusted not just here but also for all the alarms in the MpAlarmX config

		CASE EventIDCode OF 
		// every time the alarm is triggered it's counted so a total count can be displayed in the alarm message											
		1	 :  AlarmCount[0  ] :=  AlarmCount[0]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.1	');  
		2	 :  AlarmCount[1  ] :=  AlarmCount[1]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2	'); 
		7	 :  AlarmCount[2  ] :=  AlarmCount[2]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.7	'); 
		2048 :  AlarmCount[3  ] :=  AlarmCount[3]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2048'); 
		2049 :  AlarmCount[4  ] :=  AlarmCount[4]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2049'); 
		2050 :  AlarmCount[5  ] :=  AlarmCount[5]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2050'); 
		2051 :  AlarmCount[6  ] :=  AlarmCount[6]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2051'); 
		2052 :  AlarmCount[7  ] :=  AlarmCount[7]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2052'); 
		2053 :  AlarmCount[8  ] :=  AlarmCount[8]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2053'); 
		2054 :  AlarmCount[9  ] :=  AlarmCount[9]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2054'); 
		2055 :  AlarmCount[10 ] := AlarmCount[10]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2055'); 
		2056 :  AlarmCount[11 ] := AlarmCount[11]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2056'); 
		2057 :  AlarmCount[12 ] := AlarmCount[12]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2057'); 
		2058 :  AlarmCount[13 ] := AlarmCount[13]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2058'); 
		2060 :  AlarmCount[14 ] := AlarmCount[14]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2060'); 
		2061 :  AlarmCount[15 ] := AlarmCount[15]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2061'); 
		2063 :  AlarmCount[16 ] := AlarmCount[16]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2063'); 
		2064 :  AlarmCount[17 ] := AlarmCount[17]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2064'); 
		2066 :  AlarmCount[18 ] := AlarmCount[18]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2066'); 
		2067 :  AlarmCount[19 ] := AlarmCount[19]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2067'); 
		2068 :  AlarmCount[20 ] := AlarmCount[20]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2068'); 
		2069 :  AlarmCount[21 ] := AlarmCount[21]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2069'); 
		2070 :  AlarmCount[22 ] := AlarmCount[22]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2070'); 
		2071 :  AlarmCount[23 ] := AlarmCount[23]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2071'); 
		2074 :  AlarmCount[24 ] := AlarmCount[24]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2074'); 
		2077 :  AlarmCount[25 ] := AlarmCount[25]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2077'); 
		2080 :  AlarmCount[26 ] := AlarmCount[26]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.7392'); 
		2082 :  AlarmCount[27 ] := AlarmCount[27]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2080'); 
		2083 :  AlarmCount[28 ] := AlarmCount[28]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2083'); 
		2084 :  AlarmCount[29 ] := AlarmCount[29]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2084'); 
		2085 :  AlarmCount[30 ] := AlarmCount[30]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2085'); 
		2090 :  AlarmCount[31 ] := AlarmCount[31]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2090'); 
		2091 :  AlarmCount[32 ] := AlarmCount[32]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2091'); 
		2092 :  AlarmCount[33 ] := AlarmCount[33]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2092'); 
		2093 :  AlarmCount[34 ] := AlarmCount[34]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2093'); 
		2094 :  AlarmCount[35 ] := AlarmCount[35]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2094'); 
		2095 :  AlarmCount[36 ] := AlarmCount[36]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2095'); 
		2097 :  AlarmCount[37 ] := AlarmCount[37]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2097'); 
		2098 :  AlarmCount[38 ] := AlarmCount[38]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2098'); 
		2099 :  AlarmCount[39 ] := AlarmCount[39]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2099'); 
		2100 :  AlarmCount[40 ] := AlarmCount[40]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2100'); 
		2101 :  AlarmCount[41 ] := AlarmCount[41]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2101'); 
		2102 :  AlarmCount[42 ] := AlarmCount[42]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2102'); 
		2103 :  AlarmCount[43 ] := AlarmCount[43]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2103'); 
		2104 :  AlarmCount[44 ] := AlarmCount[44]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2104'); 
		2105 :  AlarmCount[45 ] := AlarmCount[45]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2105'); 
		2106 :  AlarmCount[46 ] := AlarmCount[46]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2106'); 
		2107 :  AlarmCount[47 ] := AlarmCount[47]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2107'); 
		2108 :  AlarmCount[48 ] := AlarmCount[48]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2108'); 
		2109 :  AlarmCount[49 ] := AlarmCount[49]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2109'); 
		2110 :  AlarmCount[50 ] := AlarmCount[50]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2110'); 
		2111 :  AlarmCount[51 ] := AlarmCount[51]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2111'); 
		2112 :  AlarmCount[52 ] := AlarmCount[52]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.2112'); 
		4096 :  AlarmCount[53 ] := AlarmCount[53]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4096'); 
		4097 :  AlarmCount[54 ] := AlarmCount[54]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4097'); 
		4101 :  AlarmCount[55 ] := AlarmCount[55]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4101'); 
		4102 :  AlarmCount[56 ] := AlarmCount[56]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4102'); 
		6144 :  AlarmCount[57 ] := AlarmCount[57]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6144'); 
		6165 :  AlarmCount[58 ] := AlarmCount[58]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6165'); 
		6148 :  AlarmCount[59 ] := AlarmCount[59]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6148'); 
		6149 :  AlarmCount[60 ] := AlarmCount[60]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6149'); 
		6156 :  AlarmCount[61 ] := AlarmCount[61]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6156'); 
		6157 :  AlarmCount[62 ] := AlarmCount[62]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6157'); 
		6158 :  AlarmCount[63 ] := AlarmCount[63]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.6158'); 
		12288:  AlarmCount[64 ] := AlarmCount[64]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12288'); 
		12291:  AlarmCount[65 ] := AlarmCount[65]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12291'); 
		12293:  AlarmCount[66 ] := AlarmCount[66]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12293'); 
		12294:  AlarmCount[67 ] := AlarmCount[67]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12294'); 
		12295:  AlarmCount[68 ] := AlarmCount[68]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12295'); 
		12296:  AlarmCount[69 ] := AlarmCount[69]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12296'); 
		12297:  AlarmCount[70 ] := AlarmCount[70]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12297'); 
		12298:  AlarmCount[71 ] := AlarmCount[71]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12298'); 
		12299:  AlarmCount[72 ] := AlarmCount[72]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12299'); 
		12300:  AlarmCount[73 ] := AlarmCount[73]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12300'); 
		12301:  AlarmCount[74 ] := AlarmCount[74]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12301'); 
		12302:  AlarmCount[75 ] := AlarmCount[75]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12302'); 
		12303:  AlarmCount[76 ] := AlarmCount[76]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12303'); 
		12304:  AlarmCount[77 ] := AlarmCount[77]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12304'); 
		12305:  AlarmCount[78 ] := AlarmCount[78]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12305'); 
		12307:  AlarmCount[79 ] := AlarmCount[79]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12307'); 
		12312:  AlarmCount[80 ] := AlarmCount[80]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12312'); 
		12313:  AlarmCount[81 ] := AlarmCount[81]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12313'); 
		12314:  AlarmCount[82 ] := AlarmCount[82]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12314'); 
		12315:  AlarmCount[83 ] := AlarmCount[83]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12315'); 
		12316:  AlarmCount[84 ] := AlarmCount[84]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12316'); 
		12317:  AlarmCount[85 ] := AlarmCount[85]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12317'); 
		12320:  AlarmCount[86 ] := AlarmCount[86]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12320'); 
		12322:  AlarmCount[87 ] := AlarmCount[87]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12322'); 
		12323:  AlarmCount[88 ] := AlarmCount[88]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12323'); 
		12328:  AlarmCount[89 ] := AlarmCount[89]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12328'); 
		12330:  AlarmCount[90 ] := AlarmCount[90]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12330'); 
		12331:  AlarmCount[91 ] := AlarmCount[91]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12331'); 
		12333:  AlarmCount[92 ] := AlarmCount[92]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12333'); 
		12334:  AlarmCount[93 ] := AlarmCount[93]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12334'); 
		12335:  AlarmCount[94 ] := AlarmCount[94]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12335'); 
		12336:  AlarmCount[95 ] := AlarmCount[95]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12336'); 
		12337:  AlarmCount[96 ] := AlarmCount[96]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12337'); 
		12338:  AlarmCount[97 ] := AlarmCount[97]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12338'); 
		12340:  AlarmCount[98 ] := AlarmCount[98]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12340'); 
		12341:  AlarmCount[99 ] := AlarmCount[99]  + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12341'); 
		12342:  AlarmCount[100] := AlarmCount[100] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12342'); 
		12343:  AlarmCount[101] := AlarmCount[101] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12343'); 
		12344:  AlarmCount[102] := AlarmCount[102] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12344'); 
		12345:  AlarmCount[103] := AlarmCount[103] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12345'); 
		12346:  AlarmCount[104] := AlarmCount[104] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12346'); 
		12347:  AlarmCount[105] := AlarmCount[105] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12347'); 
		12348:  AlarmCount[106] := AlarmCount[106] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.12348'); 
		4007:   AlarmCount[107] := AlarmCount[107] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4007');  
		7230:   AlarmCount[108] := AlarmCount[108] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.7230');  
		4005:   AlarmCount[109] := AlarmCount[109] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4005');  
		4098:   AlarmCount[110] := AlarmCount[110] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.4098');  
		9106:   AlarmCount[111] := AlarmCount[111] + 1;   MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.9106');  
		
		ELSE
			MpAlarmXSet(DiagInterface.AlarmCore,'EventIDCode.xxxx');
		END_CASE

END_ACTION


		
