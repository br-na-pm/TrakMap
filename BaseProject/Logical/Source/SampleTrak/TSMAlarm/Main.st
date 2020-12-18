
PROGRAM _INIT
	(* Insert code here *)
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	fbAlarmMainTSM(MpLink := ADR(gAlarmXCore), Enable := TRUE);
	fbAlarmHistMainTSM(MpLink := ADR(gAlarmXHistory), Enable := TRUE, DeviceName := ADR('User'));
	
	TriggerTestAlarm;
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

