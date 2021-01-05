
PROGRAM _INIT
	(* Insert code here *)
	
	ST_name(0,ADR(ModuleLink),0);
	
	IF (ModuleLink = 'EM2::Config2') THEN
	
		ModuleName := 'EM2';
		
		StartValue := 0;
	
	ELSIF (ModuleLink = 'EM3::Config3') THEN
	
		ModuleName := 'EM3';
			
		StartValue := 10000;
		
	END_IF	
	
	Counter := StartValue;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	ConfigAlarm;
	ConfigWarning;
	ConfigInformation;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

