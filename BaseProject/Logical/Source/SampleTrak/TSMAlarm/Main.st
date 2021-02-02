
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
	
	// Reset the Export cmd from mappView when export is done
	IF fbAlarmHistMainTSM.Export AND fbAlarmHistMainTSM.CommandDone THEN
		fbAlarmHistMainTSM.Export := FALSE;
	END_IF	
	
	TriggerTestAlarm;
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

