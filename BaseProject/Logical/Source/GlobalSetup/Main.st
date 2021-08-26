
PROGRAM _INIT
	(* Call global variables until they are use somewhere else *)
	gSampleTrak;
	gTrakModule;
	gSampleTrak_SectorTrakA;
	gSampleTrak_SectorTrakB;
	gSampleTrak_SectorTrakAll;
	gSampleTrakMon;
		
	#ifdef ASSEMBLY_STANDARD
	(*All segment references must be included in the following segment array*)
	gTrakData.Seg.SegList[0].Name  := 'gSeg_A_1'; 		gTrakData.Seg.SegList[0].McType := gSeg_A_1 ;
	gTrakData.Seg.SegList[1].Name  := 'gSeg_A_2';		gTrakData.Seg.SegList[1].McType := gSeg_A_2 ;
	gTrakData.Seg.SegList[2].Name  := 'gSeg_A_3'; 		gTrakData.Seg.SegList[2].McType := gSeg_A_3 ;
	gTrakData.Seg.SegList[3].Name  := 'gSeg_A_4';		gTrakData.Seg.SegList[3].McType := gSeg_A_4 ;
	gTrakData.Seg.SegList[4].Name  := 'gSeg_A_5';		gTrakData.Seg.SegList[4].McType := gSeg_A_5 ;
	gTrakData.Seg.SegList[5].Name  := 'gSeg_A_6';		gTrakData.Seg.SegList[5].McType := gSeg_A_6 ;
	gTrakData.Seg.SegList[6].Name  := 'gSeg_A_7';		gTrakData.Seg.SegList[6].McType := gSeg_A_7 ;
	gTrakData.Seg.SegList[7].Name  := 'gSeg_A_8';		gTrakData.Seg.SegList[7].McType := gSeg_A_8 ;
	gTrakData.Seg.SegList[8].Name  := 'gSeg_A_9';		gTrakData.Seg.SegList[8].McType := gSeg_A_9 ;
	gTrakData.Seg.SegList[9].Name  := 'gSeg_A_10';		gTrakData.Seg.SegList[9].McType := gSeg_A_10;
	gTrakData.Seg.SegList[10].Name := 'gSeg_A_11';		gTrakData.Seg.SegList[10].McType := gSeg_A_11;
	gTrakData.Seg.SegList[11].Name := 'gSeg_A_12';		gTrakData.Seg.SegList[11].McType := gSeg_A_12;
		
	gTrakData.Seg.SegList[12].Name  := 'gSeg_B_1';		gTrakData.Seg.SegList[12].McType := gSeg_B_1;
	gTrakData.Seg.SegList[13].Name  := 'gSeg_B_2';		gTrakData.Seg.SegList[13].McType := gSeg_B_2;
	gTrakData.Seg.SegList[14].Name  := 'gSeg_B_3';		gTrakData.Seg.SegList[14].McType := gSeg_B_3;
	gTrakData.Seg.SegList[15].Name  := 'gSeg_B_4';		gTrakData.Seg.SegList[15].McType := gSeg_B_4;
	gTrakData.Seg.SegList[16].Name  := 'gSeg_B_5';		gTrakData.Seg.SegList[16].McType := gSeg_B_5;
	gTrakData.Seg.SegList[17].Name  := 'gSeg_B_6';		gTrakData.Seg.SegList[17].McType := gSeg_B_6;
	gTrakData.Seg.SegList[18].Name  := 'gSeg_B_7';		gTrakData.Seg.SegList[18].McType := gSeg_B_7;
	gTrakData.Seg.SegList[19].Name  := 'gSeg_B_8';		gTrakData.Seg.SegList[19].McType := gSeg_B_8;
	gTrakData.Seg.SegList[20].Name  := 'gSeg_B_9';		gTrakData.Seg.SegList[20].McType := gSeg_B_9;
	gTrakData.Seg.SegList[21].Name  := 'gSeg_B_10';		gTrakData.Seg.SegList[21].McType := gSeg_B_10;
	gTrakData.Seg.SegList[22].Name  := 'gSeg_B_11';		gTrakData.Seg.SegList[22].McType := gSeg_B_11;
	


	gTrakData.Seg.SegCount := 23;
	
	gTrakData.Seg.SegListAdr := ADR(gTrakData.Seg.SegList);
		
	#endif
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
		
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

