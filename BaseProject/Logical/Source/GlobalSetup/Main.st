
PROGRAM _INIT
	(* Call global variables until they are use somewhere else *)
	gSampleTrak;
	gTrackModule;
	gSampleTrak_SectorTrackA;
		
	#ifdef ASSEMBLY_STANDARD
	(*All segment references must be included in the following segment array*)
		gSegmentSetup.Name[0]  := 'gSeg_A_1'; 	gSegmentSetup.McType[0 ] := gSeg_A_1 ;
		gSegmentSetup.Name[1]  := 'gSeg_A_2';	gSegmentSetup.McType[1 ] := gSeg_A_2 ;
		gSegmentSetup.Name[2]  := 'gSeg_A_3'; 	gSegmentSetup.McType[2 ] := gSeg_A_3 ;
		gSegmentSetup.Name[3]  := 'gSeg_A_4';	gSegmentSetup.McType[3 ] := gSeg_A_4 ;
		gSegmentSetup.Name[4]  := 'gSeg_A_5';	gSegmentSetup.McType[4 ] := gSeg_A_5 ;
		gSegmentSetup.Name[5]  := 'gSeg_A_6';	gSegmentSetup.McType[5 ] := gSeg_A_6 ;
		gSegmentSetup.Name[6]  := 'gSeg_A_7';	gSegmentSetup.McType[6 ] := gSeg_A_7 ;
		gSegmentSetup.Name[7]  := 'gSeg_A_8';	gSegmentSetup.McType[7 ] := gSeg_A_8 ;
		gSegmentSetup.Name[8]  := 'gSeg_A_9';	gSegmentSetup.McType[8 ] := gSeg_A_9 ;
		gSegmentSetup.Name[9]  := 'gSeg_A_10';	gSegmentSetup.McType[9 ] := gSeg_A_10;
		gSegmentSetup.Name[10] := 'gSeg_A_11';	gSegmentSetup.McType[10] := gSeg_A_11;
		gSegmentSetup.Name[11] := 'gSeg_A_12';	gSegmentSetup.McType[11] := gSeg_A_12;
		
		gSegmentSetup.Count := 12;
	#endif
	
	
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

