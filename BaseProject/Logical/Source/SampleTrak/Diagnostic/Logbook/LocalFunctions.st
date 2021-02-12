// --------------------------------------------------------------------------------------------------------------------
// Gets severity from EventId (bits 31-30)
FUNCTION GetSeverity
	IF ArEventLogIsError(EventID := EventID) THEN
		GetSeverity := arEVENTLOG_SEVERITY_ERROR;
	ELSIF ArEventLogIsWarning(EventID := EventID) THEN
		GetSeverity := arEVENTLOG_SEVERITY_WARNING;
	ELSIF ArEventLogIsInformation(EventID := EventID) THEN
		GetSeverity := arEVENTLOG_SEVERITY_INFO;
	ELSIF ArEventLogIsSuccess(EventID := EventID) THEN
		GetSeverity := arEVENTLOG_SEVERITY_SUCCESS;
	END_IF
END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// Gets code from EventId (bits 15-0)
FUNCTION GetCode
	GetCode := DINT_TO_UINT(EventID);
END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// Gets facility from EventId (bits 27-16)
FUNCTION GetFacility
	GetFacility := DINT_TO_UINT(SHR(EventID, 16) AND 16#0FFF);
END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// Insert new entry
FUNCTION InsertEntry
	// Lets see where new entry fits
	FOR idx:=1 TO DAT.EntriesTotal DO
		// Sorting is ascending
		IF Sorting = sortingASC THEN
			// New entry is old than this entry
			IF DTsec < DAT.Entries.DTsec[idx] THEN
				EXIT;
				// If entries are within the same second check milisecond data
			ELSIF DTsec = DAT.Entries.DTsec[idx] THEN
				IF DTmsec < DAT.Entries.DTmsec[idx] THEN
					EXIT;
				END_IF
			END_IF
			// Sorting is descending
		ELSE
			// New entry is newer than this entry
			IF DTsec > DAT.Entries.DTsec[idx] THEN
				EXIT;
				// If entries are within the same second check milisecond data
			ELSIF DTsec = DAT.Entries.DTsec[idx] THEN
				IF DTmsec > DAT.Entries.DTmsec[idx] THEN
					EXIT;
				END_IF
			END_IF
		END_IF
	END_FOR;

	// Add data as long as buffer is not full
	IF DAT.EntriesTotal < LOGBOOK_ENTRIES_MAX THEN
		IF DAT.EntriesTotal = 1 AND idx = 1 THEN
			idy := 1;			
		ELSIF DAT.EntriesTotal >= idx THEN
			idy := DAT.EntriesTotal - idx + 1;
		END_IF
		DAT.EntriesTotal := DAT.EntriesTotal + 1;
		// If buffer is full check where entry fits
	ELSE
		// Entry is beyond scope of buffer
		IF idx > LOGBOOK_ENTRIES_MAX THEN
			InsertEntry := NO_SPACE;
			RETURN;
		ELSE
			IF DAT.EntriesTotal - idx > 0 THEN
				idy := DAT.EntriesTotal - idx;
			END_IF
		END_IF
	END_IF
	
	// Dont move if there is nothing to move
	IF idy <> 0 THEN
		brsmemmove(ADR(DAT.Entries.Code[idx+1]),ADR(DAT.Entries.Code[idx]), idy * SIZEOF(DAT.Entries.Code[1]));
		brsmemmove(ADR(DAT.Entries.Timestamp[idx+1]),ADR(DAT.Entries.Timestamp[idx]), idy * SIZEOF(DAT.Entries.Timestamp[1]));
		brsmemmove(ADR(DAT.Entries.DTsec[idx+1]),ADR(DAT.Entries.DTsec[idx]), idy * SIZEOF(DAT.Entries.DTsec[1]));
		brsmemmove(ADR(DAT.Entries.DTmsec[idx+1]),ADR(DAT.Entries.DTmsec[idx]), idy * SIZEOF(DAT.Entries.DTmsec[1]));
		brsmemmove(ADR(DAT.Entries.ErrorNo[idx+1]),ADR(DAT.Entries.ErrorNo[idx]), idy * SIZEOF(DAT.Entries.ErrorNo[1]));
		brsmemmove(ADR(DAT.Entries.ErrorText[idx+1]),ADR(DAT.Entries.ErrorText[idx]), idy * SIZEOF(DAT.Entries.ErrorText[1]));
		brsmemmove(ADR(DAT.Entries.EventID[idx+1]),ADR(DAT.Entries.EventID[idx]), idy * SIZEOF(DAT.Entries.EventID[1]));
		brsmemmove(ADR(DAT.Entries.FacilityCode[idx+1]),ADR(DAT.Entries.FacilityCode[idx]), idy * SIZEOF(DAT.Entries.FacilityCode[1]));
		brsmemmove(ADR(DAT.Entries.LogbookName[idx+1]),ADR(DAT.Entries.LogbookName[idx]), idy * SIZEOF(DAT.Entries.LogbookName[1]));
		brsmemmove(ADR(DAT.Entries.Severity[idx+1]),ADR(DAT.Entries.Severity[idx]), idy * SIZEOF(DAT.Entries.Severity[1]));
	END_IF
	InsertEntry := idx;

END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// Normalize 2 digit date and time values
FUNCTION NormalizeDateTime
	tmpSTR2 := addSTR;
	IF(value < 10) THEN
		brsstrcat(ADR(tmpSTR2), ADR('0'));
	END_IF
	brsitoa(value, ADR(tmpSTR1));
	brsstrcat(ADR(tmpSTR2), ADR(tmpSTR1));
	brsstrcat(target, ADR(tmpSTR2));
	NormalizeDateTime := TRUE;
END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// Working status																						
FUNCTION WorkingStatus
	animation := animation+1;
	
	IF (animation = 80) THEN
		animation := 0;
	END_IF
	
	brsstrcpy(target, text);
	CASE(animation) OF
		0..19	: brsstrcat(target, ADR('/'));
		20..39	: brsstrcat(target, ADR('-'));
		40..59	: brsstrcat(target, ADR('\'));
		60..79	: brsstrcat(target, ADR('|'));
	END_CASE;
	WorkingStatus := animation;
END_FUNCTION

// --------------------------------------------------------------------------------------------------------------------
// Is second string in first string																		
FUNCTION IsInstr
	IF (brsstrlen(string1) > brsstrlen(string2)) THEN
		FOR idx:=0 TO brsstrlen(string1) - brsstrlen(string2) DO
			IF (brsmemcmp(string1 + idx, string2, brsstrlen(string2)) = 0) THEN
				IsInstr := TRUE;
				EXIT;
			END_IF
		END_FOR;
	END_IF
END_FUNCTION


(* Trigger proper alarms *)
FUNCTION SetTrakSegAlarm

		SetTrakSegAlarm := TRUE;
		// EventIDCode add new alarms triggers at the end otherwise 
		// the AlarmCount has to be adjusted not just here but also for all the alarms in the MpAlarmX config

		CASE EventIDCode OF 
		// every time the alarm is triggered it's counted so a total count can be displayed in the alarm message											
		1	 :  AlarmCount[0  ] :=  AlarmCount[0]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.1	');  
		2	 :  AlarmCount[1  ] :=  AlarmCount[1]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2	'); 
		7	 :  AlarmCount[2  ] :=  AlarmCount[2]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.7	'); 
		2048 :  AlarmCount[3  ] :=  AlarmCount[3]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2048'); 
		2049 :  AlarmCount[4  ] :=  AlarmCount[4]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2049'); 
		2050 :  AlarmCount[5  ] :=  AlarmCount[5]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2050'); 
		2051 :  AlarmCount[6  ] :=  AlarmCount[6]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2051'); 
		2052 :  AlarmCount[7  ] :=  AlarmCount[7]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2052'); 
		2053 :  AlarmCount[8  ] :=  AlarmCount[8]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2053'); 
		2054 :  AlarmCount[9  ] :=  AlarmCount[9]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2054'); 
		2055 :  AlarmCount[10 ] := AlarmCount[10]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2055'); 
		2056 :  AlarmCount[11 ] := AlarmCount[11]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2056'); 
		2057 :  AlarmCount[12 ] := AlarmCount[12]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2057'); 
		2058 :  AlarmCount[13 ] := AlarmCount[13]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2058'); 
		2060 :  AlarmCount[14 ] := AlarmCount[14]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2060'); 
		2061 :  AlarmCount[15 ] := AlarmCount[15]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2061'); 
		2063 :  AlarmCount[16 ] := AlarmCount[16]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2063'); 
		2064 :  AlarmCount[17 ] := AlarmCount[17]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2064'); 
		2066 :  AlarmCount[18 ] := AlarmCount[18]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2066'); 
		2067 :  AlarmCount[19 ] := AlarmCount[19]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2067'); 
		2068 :  AlarmCount[20 ] := AlarmCount[20]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2068'); 
		2069 :  AlarmCount[21 ] := AlarmCount[21]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2069'); 
		2070 :  AlarmCount[22 ] := AlarmCount[22]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2070'); 
		2071 :  AlarmCount[23 ] := AlarmCount[23]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2071'); 
		2074 :  AlarmCount[24 ] := AlarmCount[24]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2074'); 
		2077 :  AlarmCount[25 ] := AlarmCount[25]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2077'); 
		2080 :  AlarmCount[26 ] := AlarmCount[26]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.7392'); 
		2082 :  AlarmCount[27 ] := AlarmCount[27]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2080'); 
		2083 :  AlarmCount[28 ] := AlarmCount[28]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2083'); 
		2084 :  AlarmCount[29 ] := AlarmCount[29]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2084'); 
		2085 :  AlarmCount[30 ] := AlarmCount[30]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2085'); 
		2090 :  AlarmCount[31 ] := AlarmCount[31]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2090'); 
		2091 :  AlarmCount[32 ] := AlarmCount[32]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2091'); 
		2092 :  AlarmCount[33 ] := AlarmCount[33]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2092'); 
		2093 :  AlarmCount[34 ] := AlarmCount[34]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2093'); 
		2094 :  AlarmCount[35 ] := AlarmCount[35]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2094'); 
		2095 :  AlarmCount[36 ] := AlarmCount[36]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2095'); 
		2097 :  AlarmCount[37 ] := AlarmCount[37]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2097'); 
		2098 :  AlarmCount[38 ] := AlarmCount[38]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2098'); 
		2099 :  AlarmCount[39 ] := AlarmCount[39]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2099'); 
		2100 :  AlarmCount[40 ] := AlarmCount[40]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2100'); 
		2101 :  AlarmCount[41 ] := AlarmCount[41]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2101'); 
		2102 :  AlarmCount[42 ] := AlarmCount[42]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2102'); 
		2103 :  AlarmCount[43 ] := AlarmCount[43]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2103'); 
		2104 :  AlarmCount[44 ] := AlarmCount[44]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2104'); 
		2105 :  AlarmCount[45 ] := AlarmCount[45]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2105'); 
		2106 :  AlarmCount[46 ] := AlarmCount[46]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2106'); 
		2107 :  AlarmCount[47 ] := AlarmCount[47]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2107'); 
		2108 :  AlarmCount[48 ] := AlarmCount[48]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2108'); 
		2109 :  AlarmCount[49 ] := AlarmCount[49]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2109'); 
		2110 :  AlarmCount[50 ] := AlarmCount[50]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2110'); 
		2111 :  AlarmCount[51 ] := AlarmCount[51]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2111'); 
		2112 :  AlarmCount[52 ] := AlarmCount[52]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.2112'); 
		4096 :  AlarmCount[53 ] := AlarmCount[53]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4096'); 
		4097 :  AlarmCount[54 ] := AlarmCount[54]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4097'); 
		4101 :  AlarmCount[55 ] := AlarmCount[55]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4101'); 
		4102 :  AlarmCount[56 ] := AlarmCount[56]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4102'); 
		6144 :  AlarmCount[57 ] := AlarmCount[57]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6144'); 
		6165 :  AlarmCount[58 ] := AlarmCount[58]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6165'); 
		6148 :  AlarmCount[59 ] := AlarmCount[59]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6148'); 
		6149 :  AlarmCount[60 ] := AlarmCount[60]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6149'); 
		6156 :  AlarmCount[61 ] := AlarmCount[61]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6156'); 
		6157 :  AlarmCount[62 ] := AlarmCount[62]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6157'); 
		6158 :  AlarmCount[63 ] := AlarmCount[63]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.6158'); 
		12288:  AlarmCount[64 ] := AlarmCount[64]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12288'); 
		12291:  AlarmCount[65 ] := AlarmCount[65]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12291'); 
		12293:  AlarmCount[66 ] := AlarmCount[66]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12293'); 
		12294:  AlarmCount[67 ] := AlarmCount[67]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12294'); 
		12295:  AlarmCount[68 ] := AlarmCount[68]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12295'); 
		12296:  AlarmCount[69 ] := AlarmCount[69]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12296'); 
		12297:  AlarmCount[70 ] := AlarmCount[70]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12297'); 
		12298:  AlarmCount[71 ] := AlarmCount[71]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12298'); 
		12299:  AlarmCount[72 ] := AlarmCount[72]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12299'); 
		12300:  AlarmCount[73 ] := AlarmCount[73]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12300'); 
		12301:  AlarmCount[74 ] := AlarmCount[74]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12301'); 
		12302:  AlarmCount[75 ] := AlarmCount[75]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12302'); 
		12303:  AlarmCount[76 ] := AlarmCount[76]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12303'); 
		12304:  AlarmCount[77 ] := AlarmCount[77]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12304'); 
		12305:  AlarmCount[78 ] := AlarmCount[78]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12305'); 
		12307:  AlarmCount[79 ] := AlarmCount[79]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12307'); 
		12312:  AlarmCount[80 ] := AlarmCount[80]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12312'); 
		12313:  AlarmCount[81 ] := AlarmCount[81]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12313'); 
		12314:  AlarmCount[82 ] := AlarmCount[82]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12314'); 
		12315:  AlarmCount[83 ] := AlarmCount[83]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12315'); 
		12316:  AlarmCount[84 ] := AlarmCount[84]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12316'); 
		12317:  AlarmCount[85 ] := AlarmCount[85]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12317'); 
		12320:  AlarmCount[86 ] := AlarmCount[86]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12320'); 
		12322:  AlarmCount[87 ] := AlarmCount[87]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12322'); 
		12323:  AlarmCount[88 ] := AlarmCount[88]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12323'); 
		12328:  AlarmCount[89 ] := AlarmCount[89]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12328'); 
		12330:  AlarmCount[90 ] := AlarmCount[90]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12330'); 
		12331:  AlarmCount[91 ] := AlarmCount[91]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12331'); 
		12333:  AlarmCount[92 ] := AlarmCount[92]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12333'); 
		12334:  AlarmCount[93 ] := AlarmCount[93]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12334'); 
		12335:  AlarmCount[94 ] := AlarmCount[94]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12335'); 
		12336:  AlarmCount[95 ] := AlarmCount[95]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12336'); 
		12337:  AlarmCount[96 ] := AlarmCount[96]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12337'); 
		12338:  AlarmCount[97 ] := AlarmCount[97]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12338'); 
		12340:  AlarmCount[98 ] := AlarmCount[98]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12340'); 
		12341:  AlarmCount[99 ] := AlarmCount[99]  + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12341'); 
		12342:  AlarmCount[100] := AlarmCount[100] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12342'); 
		12343:  AlarmCount[101] := AlarmCount[101] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12343'); 
		12344:  AlarmCount[102] := AlarmCount[102] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12344'); 
		12345:  AlarmCount[103] := AlarmCount[103] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12345'); 
		12346:  AlarmCount[104] := AlarmCount[104] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12346'); 
		12347:  AlarmCount[105] := AlarmCount[105] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12347'); 
		12348:  AlarmCount[106] := AlarmCount[106] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.12348'); 
		4007:   AlarmCount[107] := AlarmCount[107] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4007');  
		7230:   AlarmCount[108] := AlarmCount[108] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.7230');  
		4005:   AlarmCount[109] := AlarmCount[109] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4005');  
		4098:   AlarmCount[110] := AlarmCount[110] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.4098');  
		9106:   AlarmCount[111] := AlarmCount[111] + 1;   MpAlarmXSet(AlarmMpLink,'EventIDCode.9106');  
		
		ELSE
			MpAlarmXSet(AlarmMpLink,'EventIDCode.xxxx');
		END_CASE


END_FUNCTION
