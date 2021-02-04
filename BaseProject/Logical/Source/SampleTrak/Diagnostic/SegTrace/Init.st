

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
	
	#ifdef ASSEMBLY_STANDARD
		(*All segment references must be included in the following segment array*)
		gSegTraceIf.Pars.Segments[0] := ADR(gSeg_A_1 );			segTraceResults[0].SegmentName := 'gSeg_A_1 ';
		gSegTraceIf.Pars.Segments[1] := ADR(gSeg_A_2 );			segTraceResults[1].SegmentName := 'gSeg_A_2 ';
		gSegTraceIf.Pars.Segments[2] := ADR(gSeg_A_3 );			segTraceResults[2].SegmentName := 'gSeg_A_3 ';
		gSegTraceIf.Pars.Segments[3] := ADR(gSeg_A_4 );			segTraceResults[3].SegmentName := 'gSeg_A_4 ';
		gSegTraceIf.Pars.Segments[4] := ADR(gSeg_A_5 );			segTraceResults[4].SegmentName := 'gSeg_A_5 ';
		gSegTraceIf.Pars.Segments[5] := ADR(gSeg_A_6 );			segTraceResults[5].SegmentName := 'gSeg_A_6 ';
		gSegTraceIf.Pars.Segments[6] := ADR(gSeg_A_7 );			segTraceResults[6].SegmentName := 'gSeg_A_7 ';
		gSegTraceIf.Pars.Segments[7] := ADR(gSeg_A_8 );			segTraceResults[7].SegmentName := 'gSeg_A_8 ';
		gSegTraceIf.Pars.Segments[8] := ADR(gSeg_A_9 );			segTraceResults[8].SegmentName := 'gSeg_A_9 ';
		gSegTraceIf.Pars.Segments[9] := ADR(gSeg_A_10);			segTraceResults[9].SegmentName := 'gSeg_A_10';
		gSegTraceIf.Pars.Segments[10] :=ADR(gSeg_A_11);			segTraceResults[10].SegmentName :='gSeg_A_11';
		gSegTraceIf.Pars.Segments[11] :=ADR(gSeg_A_12);			segTraceResults[11].SegmentName :='gSeg_A_12';
		
		gSegTraceIf.Pars.SegmentCount := 12;
	#endif	
	//FB Call
	RecipeXml();
	RegPar[0]();
	RegPar[1]();
END_PROGRAM