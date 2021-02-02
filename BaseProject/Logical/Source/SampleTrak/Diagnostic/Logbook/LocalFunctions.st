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