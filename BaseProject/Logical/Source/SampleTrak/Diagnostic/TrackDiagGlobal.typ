(*Insert your comment here.*)

TYPE
	DiagStatusType : 	STRUCT 
		Sys : SystemStatusType;
		Asm : AsmStatusType;
		Seg : SegmentDataType;
		Shuttle : ShuttleStatusType;
		PS : ARRAY[0..NUM_PS]OF PowerSupplyStatusType;
		Hub : ARRAY[0..NUM_HUBS]OF HubStatusType;
		IO : IOStatusType;
		CPU : CPUStatusType;
		SegmentCount : USINT; (*Number Of segments*)
	END_STRUCT;
	SystemStatusType : 	STRUCT 
		ConfigCheckComplete : BOOL;
		ConfigCheckOk : BOOL;
		StatusMessage : STRING[0];
	END_STRUCT;
	AsmStatusType : 	STRUCT 
		AssemblyDisabled : BOOL;
		AssemblyReady : BOOL;
		AssemblyHoming : BOOL;
		AssemblyStopping : BOOL;
		AssemblyErrorStop : BOOL;
		CommunicationReady : BOOL;
		ReadyForPowerOn : BOOL;
		PowerOn : BOOL;
		StartupCount : UDINT;
		ShuttleInErrorStopCount : UINT;
	END_STRUCT;
	SegStatusType : 	STRUCT 
		CommunicationReady : BOOL;
		ReadyForPowerOn : BOOL;
		PowerOn : BOOL; 
		StartupCount : UDINT;
		CommunicationState : McCommunicationStateEnum;
		SegmentDisiabled : BOOL;
		SegmentReady : BOOL;
		SegmentStopping : BOOL;
		SegmentErrorStop : BOOL;
		ErrorCode : UINT;
		DCBus : TrkDiagSegStatusDCBusType;
		Temp : TrkDiagSegStatusTempType;
	END_STRUCT;
	ShuttleStatusType : 	STRUCT 
		Position : REAL;
		Velocity : REAL;
		LagError : REAL;
		Segment : REAL;
		Channel_ID : REAL;
		ErrorMessage : STRING[0];
	END_STRUCT;
	PowerSupplyStatusType : 	STRUCT 
		ModuleOk : BOOL;
		CurrentLimit01 : BOOL;
		Voltage01 : SINT;
		Current01 : INT;
		ClearOutput01 : BOOL;
		ErrorOutput01 : BOOL;
		OverloadError01 : BOOL;
		StatusPhaseDetection01 : BOOL;
		StatusOvertemperture01 : BOOL;
		StatusOvervoltage01 : BOOL;
		ChopperActive01 : BOOL;
		StatusChopper01 : BOOL;
		StatusBleeder01 : BOOL;
		StatusOutput02 : BOOL;
	END_STRUCT;
	HubStatusType : 	STRUCT 
		ErrorMessage : STRING[0];
		X20BC8083_ModuleOK : BOOL;
		X20PS9400_ModuleOk : BOOL;
		X20PS9400_StatusInput01 : BOOL;
		X20PS9400_StatusInput02 : BOOL;
		PLK_LinkOk : BOOL;
		PLK_CycleOk : BOOL;
		PLK_SyncOk : BOOL;
	END_STRUCT;
	IOStatusType : 	STRUCT 
		X20BT9400_ModuleOk : BOOL;
		X20BT9400_StatusInput01 : BOOL;
		X20BT9400_StatusInput02 : BOOL;
		X20DI2371_ModuleOk : BOOL;
		X20DI2371_DigitalInput01 : BOOL;
		X20DI2371_DigitalInput02 : BOOL;
	END_STRUCT;
	CPUStatusType : 	STRUCT 
		TemperatureCPU : UINT;
		TemperatureBoard : UINT;
	END_STRUCT;
	ErrorSegInfoType : 	STRUCT 
		Error : USINT;
	END_STRUCT;
END_TYPE

(*LogBook def*)

TYPE
	LogBookStateEnum : 
		( (*State machine*)
		stateWait,
		stateCreate,
		stateOpen,
		stateLatest,
		stateNext,
		stateDetails1,
		stateDetails2,
		stateDetails3,
		stateCheckFilter,
		stateUpdateList,
		stateDetails4,
		stateFilter,
		statePrep,
		stateError,
		stateNone
		);
	LogBookSeverityEnum : 
		(
		severityNotification,
		severityInformation,
		severityWarning,
		severityError
		);
	LogBookTypeEnum : 
		(
		logAccessSecurity,
		logCommisioning,
		logConnectivity,
		logFieldbus,
		logFirewall,
		logMapp,
		logMotion,
		logSafety,
		logSystem,
		logTextSystem,
		logUnitSystem,
		logUser,
		logVisualization
		);
	LogBookSortingEnum : 
		(
		sortingASC,
		sortingDESC
		);
	LogBookCmdType : 	STRUCT  (*Command structure*)
		Refresh : BOOL; (*Read all entries*)
		Update : BOOL; (*Update entries*)
		Create : BOOL; (*Create a new entry*)
		ResetError : BOOL; (*Reset error*)
	END_STRUCT;
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
		Sorting : LogBookSortingEnum := sortingDESC; (*Sort date asc or desc*)
		AbortOnEntriesLimit : BOOL; (*Stop looking for additional entries when limit is reached*)
		AutoUpdate : BOOL; (*Automatically update data*)
		AutoUpdateInterval : UINT := 60; (*Interval for auto update in s*)
		CreateErrorNo : UINT; (*Error no for new entry*)
		CreateErrorText : STRING[LOGBOOK_TEXT_LEN]; (*Error text for new entry*)
		CreateSeverity : LogBookSeverityEnum := severityNotification; (*Error severiry for new entry*)
		CreateLogbook : LogBookTypeEnum := logUser; (*Error logbook for new entry*)
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
