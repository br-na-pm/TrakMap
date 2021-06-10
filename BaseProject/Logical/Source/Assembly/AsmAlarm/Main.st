
PROGRAM _INIT
	(* Insert code here *)
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
	gAlarmXCore_TrakModule;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
	fbAlarmTrakModule(MpLink := ADR(TrakInterface.AlarmCore), Enable := TRUE);
	
	TriggerTestAlarm;
	TriggerTestInformation;
	TriggerTestWarning;	

	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

