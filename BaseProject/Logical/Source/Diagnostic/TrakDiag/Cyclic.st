

PROGRAM _CYCLIC
	
	MC_BR_SegCommandError_AcpTrak_0(Segment := ADR(TrakDiag.Seg.SegList[0].McType));
	
	IF MC_BR_SegCommandError_AcpTrak_0.Done THEN
		MC_BR_SegCommandError_AcpTrak_0.Execute := FALSE;
	END_IF
	

	(***********************************ASSEMBLY INFORMATION******************************	)
	(*Read Assebly Status*)

	DiagFbs.Asm.ReadStatus.Enable	:= TRUE;
	DiagFbs.Asm.ReadStatus();
	
	IF DiagFbs.Asm.ReadStatus.Valid THEN
		TrakDiag.Asm.AssemblyDisabled 	:= DiagFbs.Asm.ReadStatus.AssemblyDisabled;
		TrakDiag.Asm.AssemblyErrorStop := DiagFbs.Asm.ReadStatus.AssemblyErrorStop;
		TrakDiag.Asm.AssemblyReady		:= DiagFbs.Asm.ReadStatus.AssemblyReady;
		TrakDiag.Asm.AssemblyHoming	:= DiagFbs.Asm.ReadStatus.AssemblyHoming;
		TrakDiag.Asm.AssemblyStopping	:= DiagFbs.Asm.ReadStatus.AssemblyStopping;
	END_IF
	
	(*Read Assembly Info *)
	
	DiagFbs.Asm.ReadInfo.Enable		:= TRUE;
	DiagFbs.Asm.ReadInfo();
	
	IF DiagFbs.Asm.ReadInfo.Valid THEN
		TrakDiag.Asm.CommunicationReady 	:= DiagFbs.Asm.ReadInfo.AssemblyInfo.CommunicationReady;
		TrakDiag.Asm.PowerOn				:= DiagFbs.Asm.ReadInfo.AssemblyInfo.PowerOn;
		TrakDiag.Asm.ReadyForPowerOn		:= DiagFbs.Asm.ReadInfo.AssemblyInfo.ReadyForPowerOn;
		TrakDiag.Asm.ShuttlesCount 			:= DiagFbs.Asm.ReadInfo.AssemblyInfo.ShuttlesCount;
		TrakDiag.Asm.ShuttleInErrorStopCount := DiagFbs.Asm.ReadInfo.AssemblyInfo.ShuttlesInErrorStopCount;
		TrakDiag.Asm.StartupCount			:= DiagFbs.Asm.ReadInfo.AssemblyInfo.StartupCount;	
	END_IF
	

	(****************************** SEGMENT ERROR INFORMATION *****************************************)
		
	FOR SegIndex := 0 TO NUM_SEG DO
	
		IF TrakDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN //If the array contains a segment reference
			
			DiagFbs.Seg.ReadInfo[SegIndex].Segment 	:= ADR(TrakDiag.Seg.SegList[SegIndex].McType);
			DiagFbs.Seg.ReadInfo[SegIndex].Enable	:= TRUE;
			DiagFbs.Seg.ReadInfo[SegIndex]();
			
			IF DiagFbs.Seg.ReadInfo[SegIndex].Valid THEN
				//Capture Segment Info
				TrakDiag.Seg.SegList[SegIndex].Status.CommunicationReady 	:= DiagFbs.Seg.ReadInfo[SegIndex].SegmentInfo.CommunicationReady;
				TrakDiag.Seg.SegList[SegIndex].Status.ReadyForPowerOn		:= DiagFbs.Seg.ReadInfo[SegIndex].SegmentInfo.ReadyForPowerOn;
				TrakDiag.Seg.SegList[SegIndex].Status.PowerOn				:= DiagFbs.Seg.ReadInfo[SegIndex].SegmentInfo.PowerOn;
				TrakDiag.Seg.SegList[SegIndex].Status.StartupCount			:= DiagFbs.Seg.ReadInfo[SegIndex].SegmentInfo.StartupCount;
				TrakDiag.Seg.SegList[SegIndex].Status.CommunicationState	:= DiagFbs.Seg.ReadInfo[SegIndex].SegmentInfo.CommunicationState;
				
			END_IF
			
			DiagFbs.Seg.ReadStatus[SegIndex].Segment := ADR(TrakDiag.Seg.SegList[SegIndex].McType);
			DiagFbs.Seg.ReadStatus[SegIndex].Enable	:= TRUE;
			DiagFbs.Seg.ReadStatus[SegIndex]();
			
			IF DiagFbs.Seg.ReadStatus[SegIndex].Valid THEN
				
				//Check for change of state to ErrorStop to command reading error data, IF communication is ready
				IF ((TrakDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop = FALSE AND DiagFbs.Seg.ReadStatus[SegIndex].SegmentErrorStop = TRUE))
					AND (TrakDiag.Seg.SegList[SegIndex].Status.CommunicationReady = TRUE) THEN
								
					SegErrorCheck[SegIndex].CmdCheckErrorCode := TRUE;
				
					//Check for change of state from ErrorStop to reset error number in diag structure
				ELSIF ((TrakDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop = TRUE) AND (DiagFbs.Seg.ReadStatus[SegIndex].SegmentErrorStop = FALSE))
					AND (TrakDiag.Seg.SegList[SegIndex].Status.CommunicationReady = TRUE) THEN
					
					TrakDiag.Seg.SegList[SegIndex].Status.ErrorCode := 0;
									
				END_IF
				//Capture Segment Status
				
				TrakDiag.Seg.SegList[SegIndex].Status.SegmentDisabled	:= DiagFbs.Seg.ReadStatus[SegIndex].SegmentDisabled; 
				TrakDiag.Seg.SegList[SegIndex].Status.SegmentErrorStop	:= DiagFbs.Seg.ReadStatus[SegIndex].SegmentErrorStop;
				TrakDiag.Seg.SegList[SegIndex].Status.SegmentReady		:= DiagFbs.Seg.ReadStatus[SegIndex].SegmentReady;
				TrakDiag.Seg.SegList[SegIndex].Status.SegmentStopping	:= DiagFbs.Seg.ReadStatus[SegIndex].SegmentStopping;
			END_IF		
		END_IF
	END_FOR
		
	CpuSim := DiagCpuIsSimulated() OR DiagCpuIsARsim();
	
	IF CpuSim = FALSE THEN
		actCheckErrorCode;
	END_IF	
		
	(***********************************TRAKMAP******************************)
	
	//Fetch ShuttleUserData Example 
	
	(* This will likely change to match your project! This is just an example of how to use the
		the click to get a shuttle's user data. The inputs to the ShCopyUserData will reflect your own project
	*)
//	IF EDGEPOS(paperCore.ClickData.Shuttle.Valid) THEN
//		MC_BR_ShCopyUserData_AcpTrak_0.Axis         := ADR(paperCore.ClickData.Shuttle.Data.Axis);
//		MC_BR_ShCopyUserData_AcpTrak_0.Execute      := TRUE;
//		MC_BR_ShCopyUserData_AcpTrak_0.DataAddress  := ADR(ShuttleUserData);
//		MC_BR_ShCopyUserData_AcpTrak_0.DataSize     := SIZEOF(ShuttleUserData);
//		MC_BR_ShCopyUserData_AcpTrak_0.Mode         := mcACPTRAK_USERDATA_GET;
//	END_IF
	
	paperCore();
	
	MC_BR_ShCopyUserData_AcpTrak_0();
	MC_BR_ShCopyUserData_AcpTrak_0.Execute := FALSE;
	
END_PROGRAM

