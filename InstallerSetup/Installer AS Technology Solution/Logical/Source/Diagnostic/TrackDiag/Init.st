
PROGRAM _INIT


	(* parameter setup for TrackDiag *)	
	//Replace with your segment names!
	TrackDiag.Seg.SegList[0].Name  := 'gSeg_A_1'; 		TrackDiag.Seg.SegList[0].McType := gSeg_A_1 ;
	TrackDiag.Seg.SegList[1].Name  := 'gSeg_A_2';		TrackDiag.Seg.SegList[1].McType := gSeg_A_2 ;
	TrackDiag.Seg.SegList[2].Name  := 'gSeg_A_3'; 		TrackDiag.Seg.SegList[2].McType := gSeg_A_3 ;
	TrackDiag.Seg.SegList[3].Name  := 'gSeg_A_4';		TrackDiag.Seg.SegList[3].McType := gSeg_A_4 ;
	TrackDiag.Seg.SegList[4].Name  := 'gSeg_A_5';		TrackDiag.Seg.SegList[4].McType := gSeg_A_5 ;
	TrackDiag.Seg.SegList[5].Name  := 'gSeg_A_6';		TrackDiag.Seg.SegList[5].McType := gSeg_A_6 ;
	TrackDiag.Seg.SegList[6].Name  := 'gSeg_A_7';		TrackDiag.Seg.SegList[6].McType := gSeg_A_7 ;
	TrackDiag.Seg.SegList[7].Name  := 'gSeg_A_8';		TrackDiag.Seg.SegList[7].McType := gSeg_A_8 ;
	TrackDiag.Seg.SegList[8].Name  := 'gSeg_A_9';		TrackDiag.Seg.SegList[8].McType := gSeg_A_9 ;
	TrackDiag.Seg.SegList[9].Name  := 'gSeg_A_10';		TrackDiag.Seg.SegList[9].McType := gSeg_A_10;
	TrackDiag.Seg.SegList[10].Name := 'gSeg_A_11';		TrackDiag.Seg.SegList[10].McType := gSeg_A_11;
	TrackDiag.Seg.SegList[11].Name := 'gSeg_A_12';		TrackDiag.Seg.SegList[11].McType := gSeg_A_12;
		
	TrackDiag.Seg.SegCount := 12;
	
	TrackDiag.Seg.SegListAdr := ADR(TrackDiag.Seg.SegList);
	
	(* Replace with your assembly name *)
	DiagFbs.Asm.ReadInfo.Assembly := ADR(DiagInterface.SampleTrak);//Replace with your assembly name
	DiagFbs.Asm.ReadStatus.Assembly 	:= ADR(DiagInterface.SampleTrak);
	

	paperCore.SegmentCount := TrackDiag.Seg.SegCount;
	paperCore.Segments := ADR(TrackDiag.Seg.SegList);
	paperCore.Options := ADR(paperOptions);
	paperCore.Enable := TRUE;

	
END_PROGRAM
