
PROGRAM _INIT
	(* Insert code here *)
	
	ST_name(0,ADR(ModuleLink),0);
	
	IF (ModuleLink = 'EM2::Config2') THEN
	
		ModuleName := 'EM2';
		ConfigCategory := ModuleName;
		ConfigHeader.Version := '0.0.1';
		StartValue := 0;
	
	ELSIF (ModuleLink = 'EM3::Config3') THEN
	
		ModuleName := 'EM3';
		ConfigCategory := ModuleName;
		ConfigHeader.Version := '0.0.1';	
		StartValue := 10000;
		
	END_IF	
	
	Counter := StartValue;

	//call each AppModule based MpLinks so it variable exists in memory and can be used in the AppModule variable mapping
	gRecipeXml_EM2;
	gRecipeXml_EM3;
	gPackMLModule_EM2;
	gPackMLModule_EM3;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	ConfigAlarm;
	ConfigWarning;
	ConfigInformation;
	
	fbModuleConfig(MpLink := ADR(ModuleInterface.RecipeCore), 
			Enable := TRUE, 
			DeviceName := ADR('Config'), 
			FileName := ADR(ModuleName), 
			Header := ADR(ConfigHeader), 
			Category := ADR(ConfigCategory));
			
	fbConfigRegPar(MpLink := ADR(ModuleInterface.RecipeCore), Enable := TRUE , PVName := ADR('ModuleInterface'), Category := ADR(ConfigCategory));		
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

