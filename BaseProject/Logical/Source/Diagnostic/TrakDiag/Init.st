
PROGRAM _INIT

	SegDefinition;
	
	paperCore.SegmentCount := TrakDiag.Seg.SegCount;
	paperCore.Segments := ADR(TrakDiag.Seg.SegList);
	paperCore.Options := ADR(paperOptions);
	paperCore.Enable := TRUE;
	paperCore.Assembly := ADR(DiagInterface.SampleTrak);
	paperCore.ShuttleMon := ADR(DiagInterface.ShuttleMon);
	
	//Replace with generated SVG ViewBox Values in format viewBox="MinX MinY Width Height"
	paperCore.ViewBoxCfg.MinX := -0.735577;
	paperCore.ViewBoxCfg.MinY := -0.115;
	paperCore.ViewBoxCfg.Width := 2.13115;
	paperCore.ViewBoxCfg.Height := 0.86;
	

	
END_PROGRAM
