(*Insert your comment here.*)

TYPE
	ErrorSegInfoType : 	STRUCT 
		Error : USINT;
	END_STRUCT;
END_TYPE

(*LogBook def*)

TYPE
	LogBookStateEnum : 
		( (*State machine*)
		STATE_WAIT,
		STATE_CREATE,
		STATE_OPEN,
		STATE_LATEST,
		STATE_NEXT,
		STATE_DETAILS_1,
		STATE_DETAILS_2,
		STATE_DETAILS_3,
		STATE_CHECK_FILTER,
		STATE_UPDATE_LIST,
		STATE_DETAILS_4,
		STATE_FILTER,
		STATE_PREP,
		STATE_ERROR,
		STATE_NONE
		);
	LogBookSeverityEnum : 
		(
		SEVERITY_NOTIFICATION,
		SEVERITY_INFORMATION,
		SEVERITY_WARNING,
		SEVERITY_ERROR
		);
	LogBookTypeEnum : 
		(
		LOG_ACCESS_SECURITY,
		LOG_COMMISIONING,
		LOG_CONNECTIVITY,
		LOG_FIELDBUS,
		LOG_FIREWALL,
		LOG_MAPP,
		LOG_MOTION,
		LOG_SAFETY,
		LOG_SYSTEM,
		LOG_TEXTSYSTEM,
		LOG_UNITSYSTEM,
		LOG_USER,
		LOG_VISUALIZATION
		);
	LogBookSortingEnum : 
		(
		SORTING_ASC,
		SORTING_DESC
		);
	LogBookParType : 	STRUCT  (*Parameter structure*)
		DateNow : DATE_AND_TIME; (*Current date and time*)
		TableConfig : STRING[100]; (*Hide unused rows*)
		EntriesMax : UINT; (*Maximum number of entries, shadow of LOGBOOK_ENTRIES_MAX*)
		FilterErrorNo : UDINT; (*Filter by error number*)
		FilterErrorText : STRING[LOGBOOK_TEXT_LEN]; (*Filter by error text*)
		FilterSeverity : ARRAY[0..3]OF BOOL := [4(TRUE)]; (*Filter by severity*)
		FilterLogbook : ARRAY[0..LOGBOOK_BOOKS_MAX]OF BOOL := [14(TRUE)]; (*Filter by logbook*)
		FilterDateStart : DATE; (*Filter by date*)
		FilterDateEnd : DATE;
		Sorting : LogBookSortingEnum := SORTING_DESC; (*Sort date asc or desc*)
		AbortOnEntriesLimit : BOOL; (*Stop looking for additional entries when limit is reached*)
		AutoUpdate : BOOL; (*Automatically update data*)
		AutoUpdateInterval : UINT := 60; (*Interval for auto update in s*)
		CreateErrorNo : UINT; (*Error no for new entry*)
		CreateErrorText : STRING[LOGBOOK_TEXT_LEN]; (*Error text for new entry*)
		CreateSeverity : LogBookSeverityEnum := SEVERITY_NOTIFICATION; (*Error severiry for new entry*)
		CreateLogbook : LogBookTypeEnum := LOG_USER; (*Error logbook for new entry*)
	END_STRUCT;
	LogBookErrorType : 	STRUCT  (*Error structure*)
		State : LogBookStateEnum; (*State where the error occured*)
	END_STRUCT;
	LogBookDataType : 	STRUCT  (*Data structure*)
		Entries : LogBookDataEntryType;
		EntriesTotal : UINT; (*Total number of entries*)
		CntSeverity : ARRAY[0..3]OF UINT; (*Counts by severity*)
		CntLogbook : ARRAY[0..LOGBOOK_BOOKS_MAX]OF UINT; (*Counts by logbook*)
		LastUpdate : STRING[25]; (*Last refresh run*)
	END_STRUCT;
	LogBookDataEntryType : 	STRUCT  (*Entries structure*)
		EventID : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF DINT; (*Event ID*)
		Timestamp : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF STRING[25]; (*Date and time*)
		DTsec : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF UDINT; (*Date and time in sec*)
		DTmsec : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF UDINT; (*Additional milliseconds*)
		Severity : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF USINT; (*Severity*)
		Code : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF UINT; (*Code*)
		FacilityCode : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF UINT; (*Facility code*)
		LogbookName : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF STRING[30]; (*Logbook text*)
		ErrorNo : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF DINT; (*Error number*)
		ErrorText : ARRAY[1..LOGBOOK_ENTRIES_MAX]OF STRING[LOGBOOK_TEXT_LEN]; (*Error text*)
	END_STRUCT;
	LogBookCmdType : 	STRUCT  (*Command structure*)
		Refresh : BOOL; (*Read all entries*)
		Update : BOOL; (*Update entries*)
		Create : BOOL; (*Create a new entry*)
		ResetError : BOOL; (*Reset error*)
	END_STRUCT;
	LogBookSegErrorType : 	STRUCT 
		ParaSegFilter : STRING[8]; (*show only entries with names beginning with this string*)
		Message : STRING[256]; (*message ArEventLog handling*)
		Record : ARRAY[0..500]OF LogBookSegErrorRecordType;
	END_STRUCT;
	LogBookSegErrorRecordType : 	STRUCT 
		ObjectID : STRING[36]; (*logger entry "Entered by"*)
		EventID : DINT; (*logger entry "ID"*)
		EventIDSeverity : USINT; (*logger entry "Severity"*)
		EventIDFacility : UINT; (*logger entry "Facility"*)
		EventIDCode : UINT; (*logger entry "Code"*)
		EventTimeStamp : TIME; (*logger entry "Time"*)
		Text : STRING[300]; (*logger entry "Description"*)
		Description : STRING[256]; (*logger entry "Description"*)
	END_STRUCT;
	LogBookCtrlType : 	STRUCT  (*Main structure*)
		Cmd : LogBookCmdType;
		Par : LogBookParType;
		Data : LogBookDataType;
		Error : LogBookErrorType;
		SegError : LogBookSegErrorType;
		Status : DINT;
		StatusText : STRING[80];
	END_STRUCT;
END_TYPE
