
PROGRAM _INIT
	(* Insert code here *)
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
	gAlarmXCore_TrackModule;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
	fbAlarmTrackModule(MpLink := ADR(TrackInterface.AlarmCore), Enable := TRUE);
	
	TriggerTestAlarm;
	TriggerTestInformation;
	TriggerTestWarning;	

	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

