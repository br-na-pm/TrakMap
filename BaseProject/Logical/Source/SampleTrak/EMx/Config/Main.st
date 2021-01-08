
PROGRAM _INIT
	(* Insert code here *)
	
	ST_name(0,ADR(ModuleLink),0);
	
	IF (ModuleLink = 'EMx::ConfigEMx') THEN
	
		ModuleName := 'EMx';
		ConfigCategory := ModuleName;
		ConfigHeader.Version := '0.0.1';
		
	ELSIF (ModuleLink = 'EMx::ConfigEMx') THEN
	
		ModuleName := 'EMx';
		ConfigCategory := ModuleName;
		ConfigHeader.Version := '0.0.1';
				
	END_IF	
	 
	gPackMLModule_EMx;
	gRecipeXml_EMx;
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	fbModuleConfig(MpLink := ADR(ModuleInterface.RecipeCore), 
				Enable := TRUE, 
				DeviceName := ADR('Config'), 
				FileName := ADR(ModuleName), 
				Header := ADR(ConfigHeader), 
				Category := ADR(ConfigCategory));
				
	fbConfigRegPar(MpLink := ADR(ModuleInterface.RecipeCore), Enable := TRUE , PVName := ADR('ModuleInterface'), Category := ADR(ConfigCategory));		

	ProcessInformation;
	ProcessWarning;
	ProcessAlarm;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

