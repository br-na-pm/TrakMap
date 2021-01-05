
PROGRAM _INIT

	//call each variable for mappView
	FilterConfiguration;
	SortConfiguration;
	HistoryFilter;
	HistorySort;
		
	//call each AlarmX MpLink so it variable exists in memory and can be used in the AppModule variable mapping
	gAlarmXCore_EM2;
	gAlarmXCore_EM3;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Call alarm core component *)
	 
	fbAlarmModule(MpLink := ADR(ModuleInterface.AlarmCore), Enable := TRUE);		
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

