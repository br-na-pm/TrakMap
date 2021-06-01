
PROGRAM _INIT

	SegDefinition;
	
	paperCore.SegmentCount := TrakDiag.Seg.SegCount;
	paperCore.Segments := ADR(TrakDiag.Seg.SegList);
	paperCore.Options := ADR(paperOptions);
	paperCore.Enable := TRUE;

	
END_PROGRAM
