
PROGRAM _INIT

(* parameter setup for TrackMap *)

	paperCore.SegmentCount := TrackDiag.Seg.SegCount;

	paperCore.Segments := ADR(TrackDiag.Seg.SegList);
	
	paperCore.Options := ADR(paperOptions);
	
	paperCore.Enable := TRUE;

(* parameter setup for TrackDiag *)	
		
	AsmReadStatus.Assembly := ADR(DiagInterface.SampleTrak);
	AsmReadInfo.Assembly 	:= ADR(DiagInterface.SampleTrak);
	
END_PROGRAM


PROGRAM _CYCLIC
	
	MC_BR_SegCommandError_AcpTrak_0(Segment := ADR(TrackDiag.Seg.SegList[0].McType));
	
	IF MC_BR_SegCommandError_AcpTrak_0.Done THEN
		MC_BR_SegCommandError_AcpTrak_0.Execute := FALSE;
	END_IF
	

	(***********************************ASSEMBLY INFORMATION******************************	)
	(*Read Assebly Status*)

	AsmReadStatus.Enable	:= TRUE;
	AsmReadStatus();
	
	IF AsmReadStatus.Valid THEN
		TrackDiag.Asm.AssemblyDisabled 	:= AsmReadStatus.AssemblyDisabled;
		TrackDiag.Asm.AssemblyErrorStop := AsmReadStatus.AssemblyErrorStop;
		TrackDiag.Asm.AssemblyReady		:= AsmReadStatus.AssemblyReady;
		TrackDiag.Asm.AssemblyHoming	:= AsmReadStatus.AssemblyHoming;
		TrackDiag.Asm.AssemblyStopping	:= AsmReadStatus.AssemblyStopping;
	END_IF
	
	(*Read Assembly Info *)
	
	AsmReadInfo.Enable		:= TRUE;
	AsmReadInfo();
	
	IF AsmReadInfo.Valid THEN
		TrackDiag.Asm.CommunicationReady 	:= AsmReadInfo.AssemblyInfo.CommunicationReady;
		TrackDiag.Asm.PowerOn				:= AsmReadInfo.AssemblyInfo.PowerOn;
		TrackDiag.Asm.ReadyForPowerOn		:= AsmReadInfo.AssemblyInfo.ReadyForPowerOn;
		TrackDiag.Asm.ShuttleInErrorStopCount := AsmReadInfo.AssemblyInfo.ShuttlesInErrorStopCount;
		TrackDiag.Asm.StartupCount			:= AsmReadInfo.AssemblyInfo.StartupCount;	
	END_IF
	

	(****************************** SEGMENT ERROR INFORMATION *****************************************)
		
	FOR SegIndex := 0 TO NUM_SEG DO
	
		IF TrackDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN //If the array contains a segment reference
			SegReadInfo[SegIndex].Segment 	:= ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegReadInfo[SegIndex].Enable	:= TRUE;
			SegReadInfo[SegIndex]();
			
			IF SegReadInfo[SegIndex].Valid THEN
				//Capture Segment Info
				TrackDiag.Seg.SegList[SegIndex].Status.CommunicationReady 	:= SegReadInfo[SegIndex].SegmentInfo.CommunicationReady;
				TrackDiag.Seg.SegList[SegIndex].Status.ReadyForPowerOn		:= SegReadInfo[SegIndex].SegmentInfo.ReadyForPowerOn;
				TrackDiag.Seg.SegList[SegIndex].Status.PowerOn				:= SegReadInfo[SegIndex].SegmentInfo.PowerOn;
				TrackDiag.Seg.SegList[SegIndex].Status.StartupCount			:= SegReadInfo[SegIndex].SegmentInfo.StartupCount;
				TrackDiag.Seg.SegList[SegIndex].Status.CommunicationState	:= SegReadInfo[SegIndex].SegmentInfo.CommunicationState;
				
			END_IF
			
			SegReadStatus[SegIndex].Segment := ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegReadStatus[SegIndex].Enable	:= TRUE;
			SegReadStatus[SegIndex]();
			
			IF SegReadStatus[SegIndex].Valid THEN
				
				//Check for change of state to ErrorStop to command reading error data, IF communication is ready
				IF ((TrackDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop = FALSE AND SegReadStatus[SegIndex].SegmentErrorStop = TRUE))
					AND (TrackDiag.Seg.SegList[SegIndex].Status.CommunicationReady = TRUE) THEN
								
					SegErrorCheck[SegIndex].CmdCheckErrorCode := TRUE;
				
					//Check for change of state from ErrorStop to reset error number in diag structure
				ELSIF ((TrackDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop = TRUE) AND (SegReadStatus[SegIndex].SegmentErrorStop = FALSE))
					AND (TrackDiag.Seg.SegList[SegIndex].Status.CommunicationReady = TRUE) THEN
					
					TrackDiag.Seg.SegList[SegIndex].Status.ErrorCode := 0;
									
				END_IF
				//Capture Segment Status
				
				TrackDiag.Seg.SegList[SegIndex].Status.SegmentDisabled	:= SegReadStatus[SegIndex].SegmentDisabled; 
				TrackDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop	:= SegReadStatus[SegIndex].SegmentErrorStop;
				TrackDiag.Seg.SegList[SegIndex].Status.SegmentReady		:= SegReadStatus[SegIndex].SegmentReady;
				TrackDiag.Seg.SegList[SegIndex].Status.SegmentStopping	:= SegReadStatus[SegIndex].SegmentStopping;
			END_IF		
		END_IF
	END_FOR
		
	CpuSim := DiagCpuIsSimulated() OR DiagCpuIsARsim();
	
	IF CpuSim = FALSE THEN
		actCheckErrorCode;
	END_IF	
		
	fbAuditTrail(MpLink := ADR(gAuditTrail_DiagModule), Enable := TRUE, Language := ADR('en'), DeviceName := ADR('User'));
	
	(***********************************TRACKMAP******************************)
	
	paperCore();

	// compare the elementID clicked on in paper with the configured ID to find and set the array index for the list binding
	FOR SegIndex:= 0 TO NUM_SEG DO 
		
		// clickId contains a leading # which needs to be removed, 
		// the second compare checks against the text and arrow and deletes the first two letters because the SVG elements text and arrow have an added x leading the name
		IF TrackDiag.Seg.SegList[SegIndex].Name = DELETE(clickId,1,1) OR TrackDiag.Seg.SegList[SegIndex].Name = DELETE(clickId,1,2)  THEN  
			
			clickedSegment := TrackDiag.Seg.SegList[SegIndex];
			EXIT;
		END_IF	
	END_FOR	
END_PROGRAM

PROGRAM _EXIT
			(* Insert code here *)
	 
END_PROGRAM

