
PROGRAM _INIT

	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	fbMainTsm(MpLink := ADR(gMainModule), 
						Enable := TRUE, 
						Parameters := ADR(parMainTsm));
	 
						
	MpPackMLStateIsActive(gMainModule,mpPACKML_STATE_EXECUTE,1);					
	gTrakSystem;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

