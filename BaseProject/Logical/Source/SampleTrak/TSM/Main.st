
PROGRAM _INIT
	(* Insert code here *)
	gSampleTrakMon;
	gSampleTrak;
	gTrakModule;
	Seg_A_1;
	Seg_A_2;
	Seg_A_3;
	Seg_A_4;
	Seg_A_5;
	Seg_A_6;
	Seg_A_7;
	Seg_A_8;
	Seg_A_9;
	Seg_A_10;
	Seg_A_11;
	Seg_A_12;
	SampleTrak_SectorTrackA;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	fbMainTsm(MpLink := ADR(gMainModule), 
						Enable := TRUE, 
						Parameters := ADR(parMainTsm));
	 
						
	MpPackMLStateIsActive(gMainModule,mpPACKML_STATE_EXECUTE,1);					
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

