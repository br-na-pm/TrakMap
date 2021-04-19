
PROGRAM _INIT
	(* Insert code here *)
	

	 
END_PROGRAM

PROGRAM _CYCLIC
	(* This is just a test *)
	
	IF MpPackMLStateIsActive(ModuleInterface.MainPml,mpPACKML_STATE_EXECUTE,1) THEN
		Counter := Counter + 1;
	END_IF
	 	
	OperationAlarm;
	OperationWarning;
	OperationInformation;
	

	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

