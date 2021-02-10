

PROGRAM _INIT 
	
	paperCore.SegmentCount := TrackDiag.Seg.SegCount;

	paperCore.Segments := ADR(TrackDiag.Seg.SegList);
	
	paperCore.Options := ADR(paperOptions);
	
	paperCore.Enable := TRUE;
	 
END_PROGRAM