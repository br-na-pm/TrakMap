

PROGRAM _INIT 
	
	paperCore.SegmentCount := TrackDiag.SegmentCount;

	paperCore.Segments := ADR(TrackDiag.Seg);
	
	paperCore.Options := ADR(paperOptions);
	
	paperCore.Enable := TRUE;
	 
END_PROGRAM