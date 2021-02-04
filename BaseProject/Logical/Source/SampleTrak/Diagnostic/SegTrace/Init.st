

PROGRAM _INIT
	//Setup the par ids we want to read
	gSegTraceIf.Pars.ParIds[0].DataType := mcACPTRAK_SEG_PARTYPE_REAL;
	gSegTraceIf.Pars.ParIds[0].ParID := 63801;	//Balancer current actual group 1
	
	gSegTraceIf.Pars.ParIds[1].DataType := mcACPTRAK_SEG_PARTYPE_REAL;
	gSegTraceIf.Pars.ParIds[1].ParID := 63802;	//Balancer current actual group 2
	
	gSegTraceIf.Pars.ParIds[2].DataType := mcACPTRAK_SEG_PARTYPE_REAL;
	gSegTraceIf.Pars.ParIds[2].ParID := 63803;	//Balancer current actual group 3
	
	gSegTraceIf.Pars.ParIds[3].DataType := mcACPTRAK_SEG_PARTYPE_REAL;
	gSegTraceIf.Pars.ParIds[3].ParID := mcACPPAR_UDC_ACT;	//Actual DC bus voltage value
	
	gSegTraceIf.Pars.ParIds[4].DataType := mcACPTRAK_SEG_PARTYPE_REAL;
	gSegTraceIf.Pars.ParIds[4].ParID := mcACPPAR_UDC_MIDDLE_ACT;	//Actual mid point DC bus voltage value
	
	//Setup the interface as needed
	gSegTraceIf.Pars.BalancerCurrentLimit := 24;
	gSegTraceIf.Pars.PS_UDC_Value := 58;
	gSegTraceIf.Pars.PowerFailDetectRatio := 0.779;
	
	//Setup the MpRecipe Blocks
	IF DiagCpuIsSimulated() THEN
		gSegTraceIf.Pars.Export.FileDev := 'SegTraceSim';
	ELSE
		gSegTraceIf.Pars.Export.FileDev := 'SegTrace';
	END_IF
	gSegTraceIf.Pars.Export.FileName := 'DefaultSegTraceExport';
	RecipeXml.MpLink := ADR(gMpRecipeDiagXml);
	RecipeXml.Enable := TRUE;
	RecipeXml.Category := ADR('SegTrace');
	RecipeXml.DeviceName := ADR(gSegTraceIf.Pars.Export.FileDev);
	RegPar[0].Enable := TRUE;
	RegPar[0].Category := ADR('SegTrace');
	RegPar[0].MpLink := ADR(gMpRecipeDiagXml);
	RegPar[0].PVName := ADR('gSegTraceIf.Status');
	RegPar[1].Enable := TRUE;
	RegPar[1].Category := ADR('SegTrace');
	RegPar[1].MpLink := ADR(gMpRecipeDiagXml);
	RegPar[1].PVName := ADR('SegTrace:segTraceResults');
	
	gSegTraceIf.Pars.SegmentCount := TrackDiag.SegmentCount;

	//FB Call
	RecipeXml();
	RegPar[0]();
	RegPar[1]();
END_PROGRAM