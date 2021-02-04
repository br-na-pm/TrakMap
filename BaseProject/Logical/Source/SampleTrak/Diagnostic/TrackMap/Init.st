

PROGRAM _INIT 
	
	paperOptions.Segments.SegmentCount := TrackDiag.SegmentCount;

	paperOptions.Segments.Enabled := TRUE;
	paperOptions.Segments.Segments := ADR(TrackDiag.Seg[0]);
	paperOptions.Segments.SegmentStyles.SegDefault := 0;
	paperOptions.Segments.SegmentStyles.SegError := 1;
	paperOptions.Segments.SegmentStyles.SegOkay := 2;
	paperOptions.Segments.SegmentStyles.SegWarning := 3;
	
	paperCore.Options := ADR(paperOptions);
	
	paperCore.Enable := TRUE;
	 
END_PROGRAM