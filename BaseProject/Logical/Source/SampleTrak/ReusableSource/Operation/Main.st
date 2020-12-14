
PROGRAM _INIT
	(* Insert code here *)
	
		ST_name(0,ADR(ModuleName),0);
	
	IF (ModuleName = 'EM3::Operation3') THEN
	
		StartValue := 10000;
	
	ELSIF (ModuleName = 'EM2::Operation2') THEN
	
		StartValue := 0;
		
	END_IF	
	 
	Counter := StartValue;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* This is just a test *)
	
	IF MpPackMLStateIsActive(ModuleInterface.MainPml,mpPACKML_STATE_EXECUTE,1) THEN
		Counter := Counter + 1;
	END_IF
	 
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

