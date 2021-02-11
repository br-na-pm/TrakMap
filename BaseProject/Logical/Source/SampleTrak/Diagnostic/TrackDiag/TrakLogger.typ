(*read & filter motion logger*)

TYPE
	TrakLoggerType : 	STRUCT 
		CmdRefresh : BOOL; (*command read & filter motion logger*)
		ParaShowSegError : BOOL; (*filter - show motion logger enties severity error*)
		ParaShowSegWarning : BOOL; (*filter - show motion logger enties severity warning*)
		ParaSegFilter : STRING[8]; (*show only entries with names beginning with this string*)
		Message : STRING[256]; (*message ArEventLog handling*)
		Record : ARRAY[0..500]OF TrakLoggerRecordType;
	END_STRUCT;
	TrakLoggerRecordType : 	STRUCT 
		ObjectID : STRING[36]; (*logger entry "Entered by"*)
		EventID : DINT; (*logger entry "ID"*)
		EventIDSeverity : USINT; (*logger entry "Severity"*)
		EventIDFacility : UINT; (*logger entry "Facility"*)
		EventIDCode : UINT; (*logger entry "Code"*)
		EventTimeStamp : TIME; (*logger entry "Time"*)
		Text : STRING[300]; (*logger entry "Description"*)
		Description : STRING[256]; (*logger entry "Description"*)
	END_STRUCT;
END_TYPE

(*enum*)

TYPE
	StepEnum : 
		(
		TRAK_COMMAND := 0,
		TRAK_RESET,
		TRAK_GET_IDENT := 10,
		TRAK_GET_IDENT_WAIT,
		TRAK_GET_LATEST_ID,
		TRAK_GET_LATEST_ID_WAIT,
		TRAK_GET_PREVIOUS_ID := 20,
		TRAK_GET_PREVIOUS_ID_WAIT,
		TRAK_READ_ID := 30,
		TRAK_READ_ID_WAIT,
		TRAK_CHECK_FILTER := 40,
		TRAK_CHECK_FILTER_WAIT,
		TRAK_READ_DESCRIPTION := 50,
		TRAK_READ_DESCRIPTION_WAIT,
		TRAK_UPDATE_LIST := 60,
		TRAK_DONE := 90,
		TRAK_ERROR := 99
		);
END_TYPE
