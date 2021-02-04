(*Insert your comment here.*)

TYPE
	DiagStatus_typ : 	STRUCT 
		Sys : SystemStatus_typ;
		Asm : AsmStatus_typ;
		Seg : ARRAY[0..NUM_SEG]OF tpCoreSegmentTyp;
		Shuttle : ShuttleStatus_typ;
		PS : ARRAY[0..NUM_PS]OF PowerSupplyStatus_typ;
		Hub : ARRAY[0..NUM_HUBS]OF HubStatus_typ;
		IO : IOStatus_typ;
		CPU : CPUStatus_typ;
	END_STRUCT;
	SystemStatus_typ : 	STRUCT 
		ConfigCheckComplete : BOOL;
		ConfigCheckOk : BOOL;
		StatusMessage : STRING[0];
	END_STRUCT;
	AsmStatus_typ : 	STRUCT 
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
	SegStatus_typ : 	STRUCT 
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
		DCBus : SegStatusDCBus_typ;
		Temp : SegStatusTemp_typ;
	END_STRUCT;
	ShuttleStatus_typ : 	STRUCT 
		Position : REAL;
		Velocity : REAL;
		LagError : REAL;
		Segment : REAL;
		Channel_ID : REAL;
		ErrorMessage : STRING[0];
	END_STRUCT;
	PowerSupplyStatus_typ : 	STRUCT 
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
	HubStatus_typ : 	STRUCT 
		ErrorMessage : STRING[0];
		X20BC8083_ModuleOK : BOOL;
		X20PS9400_ModuleOk : BOOL;
		X20PS9400_StatusInput01 : BOOL;
		X20PS9400_StatusInput02 : BOOL;
		PLK_LinkOk : BOOL;
		PLK_CycleOk : BOOL;
		PLK_SyncOk : BOOL;
	END_STRUCT;
	IOStatus_typ : 	STRUCT 
		X20BT9400_ModuleOk : BOOL;
		X20BT9400_StatusInput01 : BOOL;
		X20BT9400_StatusInput02 : BOOL;
		X20DI2371_ModuleOk : BOOL;
		X20DI2371_DigitalInput01 : BOOL;
		X20DI2371_DigitalInput02 : BOOL;
	END_STRUCT;
	CPUStatus_typ : 	STRUCT 
		TemperatureCPU : UINT;
		TemperatureBoard : UINT;
	END_STRUCT;
	ErrorSegInfo_typ : 	STRUCT 
		Error : USINT;
		SegName : STRING[80];
	END_STRUCT;
END_TYPE

(*LogBook def*)

TYPE
	enumLogbookState : 
		( (*State machine*)
		stateWait,
		stateCreate,
		stateOpen,
		stateLatest,
		stateNext,
		stateDetails1,
		stateDetails2,
		stateDetails3,
		stateDetails4,
		stateFilter,
		statePrep,
		stateError,
		stateNone
		);
	enumSeverity : 
		(
		severityNotification,
		severityInformation,
		severityWarning,
		severityError
		);
	enumLogbookType : 
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
	enumSorting : 
		(
		sortingASC,
		sortingDESC
		);
	logbookCMD : 	STRUCT  (*Command structure*)
		Refresh : BOOL; (*Read all entries*)
		Update : BOOL; (*Update entries*)
		Create : BOOL; (*Create a new entry*)
		ResetError : BOOL; (*Reset error*)
	END_STRUCT;
	logbookPAR : 	STRUCT  (*Parameter structure*)
		DateNow : DATE_AND_TIME; (*Current date and time*)
		TableConfig : STRING[100]; (*Hide unused rows*)
		EntriesMax : UINT; (*Maximum number of entries, shadow of LOGBOOK_ENTRIES_MAX*)
		FilterErrorNo : UDINT; (*Filter by error number*)
		FilterErrorText : STRING[LOGBOOK_TEXT_LEN]; (*Filter by error text*)
		FilterSeverity : ARRAY[0..3]OF BOOL := [4(TRUE)]; (*Filter by severity*)
		FilterLogbook : ARRAY[0..LOGBOOK_BOOKS_MAX]OF BOOL := [14(TRUE)]; (*Filter by logbook*)
		FilterDateStart : DATE; (*Filter by date*)
		FilterDateEnd : DATE;
		Sorting : enumSorting := sortingDESC; (*Sort date asc or desc*)
		AbortOnEntriesLimit : BOOL; (*Stop looking for additional entries when limit is reached*)
		AutoUpdate : BOOL; (*Automatically update data*)
		AutoUpdateInterval : UINT := 60; (*Interval for auto update in s*)
		CreateErrorNo : UINT; (*Error no for new entry*)
		CreateErrorText : STRING[LOGBOOK_TEXT_LEN]; (*Error text for new entry*)
		CreateSeverity : enumSeverity := severityNotification; (*Error severiry for new entry*)
		CreateLogbook : enumLogbookType := logUser; (*Error logbook for new entry*)
	END_STRUCT;
	logbookERR : 	STRUCT  (*Error structure*)
		State : enumLogbookState; (*State where the error occured*)
	END_STRUCT;
	logbookDAT : 	STRUCT  (*Data structure*)
		Entries : logbookENTRIES;
		EntriesTotal : UINT; (*Total number of entries*)
		CntSeverity : ARRAY[0..3]OF UINT; (*Counts by severity*)
		CntLogbook : ARRAY[0..LOGBOOK_BOOKS_MAX]OF UINT; (*Counts by logbook*)
		LastUpdate : STRING[25]; (*Last refresh run*)
	END_STRUCT;
	logbookENTRIES : 	STRUCT  (*Entries structure*)
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
	logbookMAIN : 	STRUCT  (*Main structure*)
		CMD : logbookCMD;
		PAR : logbookPAR;
		DAT : logbookDAT;
		ERR : logbookERR;
		Status : DINT;
		StatusText : STRING[80];
	END_STRUCT;
END_TYPE

(*Segment Trace Diagnostic Structures*)

TYPE
	segTraceIfTyp : 	STRUCT  (*Segment trace interface typ*)
		Cmds : segTraceIfCmdsTyp; (*Commands type*)
		Pars : segTraceIfParsTyp; (*Segment Trace parameters type*)
		Status : segTraceIfStatusTyp; (*Segmetn Trace status type*)
	END_STRUCT;
	segTraceIfCmdsTyp : 	STRUCT  (*Segment Trace Commands type*)
		Capture : BOOL; (*Capture/Execute the segment trace*)
		ErrorReset : BOOL; (*Error reset the segment trace*)
		Export : BOOL; (*Export trace results command*)
	END_STRUCT;
	segTraceIfParsTyp : 	STRUCT  (*Segment Trace parameters type*)
		Segments : {REDUND_UNREPLICABLE} ARRAY[0..MAX_SEGMENTS]OF UDINT; (*Array of references to segment variables*)
		ParIds : ARRAY[0..numPAR_IDS_ARRAY]OF McAcpTrakSegProcessParIDType; (*Array of parIds to read*)
		PS_UDC_Value : REAL; (*Configured DC bus voltage value for the power supplies*)
		PowerFailDetectRatio : REAL; (*Powerfail Detect Ratio used to validate DC bus voltage*)
		BalancerCurrentLimit : REAL; (*Set current limit for the calculation check*)
		SegmentCount : USINT; (*Number Of segments*)
		Export : segTraceIfExportParsTyp; (*Export parameters*)
	END_STRUCT;
	segTraceIfExportParsTyp : 	STRUCT  (*Export parameters*)
		FileName : STRING[80]; (*File name used for exporting*)
		FileDev : STRING[80]; (*File Device used for exporting*)
	END_STRUCT;
	segTraceIfStatusTyp : 	STRUCT  (*Segment Trace Status Type*)
		Active : BOOL; (*Segment trace is currently Active*)
		Done : BOOL; (*Segment Trace is Done*)
		Error : BOOL; (*Segment Trace has an Error*)
		Result : segTraceResultEnum; (*Segment Trace Result*)
		FailCount : USINT; (*Number of failed segments*)
		Failures : ARRAY[0..MAX_SEGMENTS]OF segTraceFailTyp; (*List of segments that failed the parID checks*)
	END_STRUCT;
	segTraceResultEnum : 
		( (*Segment Trace Result Enumeration*)
		segTraceUnknown, (*Unknown (test not run yet)*)
		segTracePass, (*Test Passed*)
		segTraceFail (*Test Failed*)
		);
	segTraceResultsValuesTyp : 	STRUCT  (*List of values read from the segment*)
		BalCurrent_Act_1 : REAL; (*Balancer current actual value 1*)
		BalCurrent_Act_2 : REAL; (*Balancer current actual value 2*)
		BalCurrent_Act_3 : REAL; (*Balancer current actual value 3*)
		UdcAct : REAL; (*Actual DC bus voltage on the segment*)
		UdcMiddleAct : REAL; (*Actual middle point DC Bus voltage on the segment*)
	END_STRUCT;
	segTraceResultsTyp : 	STRUCT  (*Segment Trace Results type*)
		SegmentName : STRING[32]; (*Segment Name*)
		BalancerPass : BOOL; (*Balancer sumation test passed*)
		UDCActPass : BOOL; (*DC bus voltage actual test passed*)
		UDCMiddlePass : BOOL; (*DC middle voltage actual test passed*)
		BalancerSum : REAL; (*Sum of balancer currents*)
		Values : segTraceResultsValuesTyp; (*List of values read from the segment*)
	END_STRUCT;
	segTraceFailTyp : 	STRUCT  (*Failed Test segment type*)
		SegName : STRING[32]; (*Segment Name*)
		WarningActive : BOOL; (*Segment has a warning active from the check. (Aide in HMI visualization)*)
		BalancerFail : BOOL; (*The balancer summation failed*)
		UDCActFail : BOOL; (*The UDC Act check failed*)
		UDCMiddleActFail : BOOL; (*The UDC Middle check failed*)
	END_STRUCT;
END_TYPE
