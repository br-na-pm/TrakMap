
PROGRAM _INIT
	(* Insert code here *)
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
	gAlarmXCore_DiagModule;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
	fbAlarmDiagModule(MpLink := ADR(DiagInterface.AlarmCore), Enable := TRUE);
	
	TriggerTestAlarm;
	TriggerTestInformation;
	TriggerTestWarning;	

	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

