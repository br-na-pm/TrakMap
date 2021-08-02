
PROGRAM _INIT

	SegDefinition;
	
	paperCore.SegmentCount := TrakDiag.Seg.SegCount;
	paperCore.Segments := ADR(TrakDiag.Seg.SegList);
	paperCore.Options := ADR(paperOptions);
	paperCore.Enable := TRUE;
	paperCore.Assembly := ADR(DiagInterface.SampleTrak);
	paperCore.ShuttleMon := ADR(DiagInterface.ShuttleMon);
	
	paperOptions.Segment.Enabled := TRUE;
	paperOptions.Shuttle.Enabled := FALSE;
	paperOptions.Color.Enabled := FALSE;
END_PROGRAM
