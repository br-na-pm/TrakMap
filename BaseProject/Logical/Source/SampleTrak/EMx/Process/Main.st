
PROGRAM _INIT
	(* Insert code here *)
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	IF MpPackMLStateIsActive(ModuleInterface.MainPml,mpPACKML_STATE_EXECUTE,1) THEN
		Counter := Counter + 1;
	END_IF
	 
	ProcessAlarm;
	ProcessWarning;
	ProcessInformation;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

