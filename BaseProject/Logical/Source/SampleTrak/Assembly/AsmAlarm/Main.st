
PROGRAM _INIT
	(* Insert code here *)
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
	fbAlarmTrakModule(MpLink := ADR(gAlarmXCore_TrakModule), Enable := TRUE);
	
	TriggerTestAlarm;
	TriggerTestInformation;
	TriggerTestWarning;	
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

