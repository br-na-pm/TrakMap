
PROGRAM _INIT
	(* Insert code here *)
	
	ST_name(0,ADR(ModuleName),0);
	
	IF (ModuleName = 'EM12::Process1') THEN
	
		StartValue := 1000;
	
	ELSIF (ModuleName = 'EM12::Process2') THEN
	
		StartValue := 0;
		
	ELSIF (ModuleName = 'EM12::Process3') THEN
	
		StartValue := 15000;	
		
	END_IF	
	 
	Counter := StartValue;
	
	MpAlarmX;
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IF MpPackMLStateIsActive(ModuleInterface.MainPml,mpPACKML_STATE_EXECUTE,1) THEN
		Counter := Counter + 1;
	END_IF
	 
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

