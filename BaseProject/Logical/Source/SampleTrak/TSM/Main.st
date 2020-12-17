
PROGRAM _INIT
	(* Call global variables until they are use somewhere else *)
	gSampleTrakMon;
	gSampleTrak;
	gTrakModule;
	gSeg_A_1;
	gSeg_A_2;
	gSeg_A_3;
	gSeg_A_4;
	gSeg_A_5;
	gSeg_A_6;
	gSeg_A_7;
	gSeg_A_8;
	gSeg_A_9;
	gSeg_A_10;
	gSeg_A_11;
	gSeg_A_12;
	gSampleTrak_SectorTrackA;
	 
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

