
PROGRAM _INIT
	(* Call global variables until they are use somewhere else *)
	gSampleTrak;
	gTrackModule;
	gSampleTrak_SectorTrackA;
	gSampleTrakMon;
		
	#ifdef ASSEMBLY_STANDARD
	(*All segment references must be included in the following segment array*)
		gTrackData.Seg.SegList[0].Name  := 'gSeg_A_1'; 		gTrackData.Seg.SegList[0].McType := gSeg_A_1 ;
		gTrackData.Seg.SegList[1].Name  := 'gSeg_A_2';		gTrackData.Seg.SegList[1].McType := gSeg_A_2 ;
		gTrackData.Seg.SegList[2].Name  := 'gSeg_A_3'; 		gTrackData.Seg.SegList[2].McType := gSeg_A_3 ;
		gTrackData.Seg.SegList[3].Name  := 'gSeg_A_4';		gTrackData.Seg.SegList[3].McType := gSeg_A_4 ;
		gTrackData.Seg.SegList[4].Name  := 'gSeg_A_5';		gTrackData.Seg.SegList[4].McType := gSeg_A_5 ;
		gTrackData.Seg.SegList[5].Name  := 'gSeg_A_6';		gTrackData.Seg.SegList[5].McType := gSeg_A_6 ;
		gTrackData.Seg.SegList[6].Name  := 'gSeg_A_7';		gTrackData.Seg.SegList[6].McType := gSeg_A_7 ;
		gTrackData.Seg.SegList[7].Name  := 'gSeg_A_8';		gTrackData.Seg.SegList[7].McType := gSeg_A_8 ;
		gTrackData.Seg.SegList[8].Name  := 'gSeg_A_9';		gTrackData.Seg.SegList[8].McType := gSeg_A_9 ;
		gTrackData.Seg.SegList[9].Name  := 'gSeg_A_10';		gTrackData.Seg.SegList[9].McType := gSeg_A_10;
		gTrackData.Seg.SegList[10].Name := 'gSeg_A_11';		gTrackData.Seg.SegList[10].McType := gSeg_A_11;
		gTrackData.Seg.SegList[11].Name := 'gSeg_A_12';		gTrackData.Seg.SegList[11].McType := gSeg_A_12;
		
		gTrackData.Seg.SegCount := 12;
	
		gTrackData.Seg.SegListAdr := ADR(gTrackData.Seg.SegList);
		
	#endif
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
		
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

