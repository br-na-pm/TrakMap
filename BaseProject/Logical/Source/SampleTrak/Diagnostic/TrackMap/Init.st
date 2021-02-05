

PROGRAM _INIT
	
	#ifdef ASSEMBLY_STANDARD
	(*All segment references must be included in the following segment array*)
		TrackDiag.Seg[0].SegmentId := 'gSeg_A_1';
		TrackDiag.Seg[1].SegmentId := 'gSeg_A_2';
		TrackDiag.Seg[2].SegmentId := 'gSeg_A_3';
		TrackDiag.Seg[3].SegmentId := 'gSeg_A_4';
		TrackDiag.Seg[4].SegmentId := 'gSeg_A_5';
		TrackDiag.Seg[5].SegmentId := 'gSeg_A_6';
		TrackDiag.Seg[6].SegmentId := 'gSeg_A_7';
		TrackDiag.Seg[7].SegmentId := 'gSeg_A_8';
		TrackDiag.Seg[8].SegmentId := 'gSeg_A_9';
		TrackDiag.Seg[9].SegmentId := 'gSeg_A_10';
		TrackDiag.Seg[10].SegmentId := 'gSeg_A_11';
		TrackDiag.Seg[11].SegmentId := 'gSeg_A_12';
		
		paperCore.SegmentCount := 12;
	#endif
    
	
	
	paperCore.Segments := ADR(TrackDiag.Seg[0]);
	
	paperCore.Options := ADR(paperOptions);
	
	paperCore.Enable := TRUE;
	 
END_PROGRAM