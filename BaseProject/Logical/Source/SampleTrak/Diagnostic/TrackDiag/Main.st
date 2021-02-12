
PROGRAM _INIT

    Current;
    Voltage;
	
	AsmReadStatus.Assembly := ADR(DiagInterface.SampleTrak);
	AsmReadInfo.Assembly 	:= ADR(DiagInterface.SampleTrak);
	
	TempRefreshTime := T#120s;
	TempRefreshTON.PT := TempRefreshTime;
	
	ZeroPitchDisableMode := 3;
	SpeedFilterTime := 0.0008;
		
	(*Initialize Error ParId Info*)
	FOR SegIndex := 0 TO NUM_SEG DO
		
		IF TrackDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN
		
			ErrorCodeIDInfo[SegIndex].DataType 	:= mcACPTRAK_SEG_PARTYPE_UINT;
			ErrorCodeIDInfo[SegIndex].ParID		:= mcACPPAR_ERROR_NUMBER;
			ErrorCodeIDInfo[SegIndex].VariableAddress := ADR(SegErrorCheck[SegIndex].ErrorNumber);
		
		
			SegProcessParID[SegIndex].Segment			:= ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegProcessParID[SegIndex].ChannelIndex 		:= 0;
			SegProcessParID[SegIndex].NumberOfParIDs 	:= 1;
			SegProcessParID[SegIndex].Mode				:= mcACPTRAK_SEG_PARID_GET_NO_NCT;
			
			//
			SegTempIDInfo[SegIndex, 0].ParID			:= mcACPPAR_TEMP_AIRIN;
			SegTempIDInfo[SegIndex, 0].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 0].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureCON);
			SegTempIDInfo[SegIndex, 1].ParID			:= mcACPPAR_TEMP_MODUL5;
			SegTempIDInfo[SegIndex, 1].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 1].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePROZ);
			SegTempIDInfo[SegIndex, 2].ParID			:= mcACPPAR_TEMP_POWERSTAGE_AIR;
			SegTempIDInfo[SegIndex, 2].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 2].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureAIR);
			SegTempIDInfo[SegIndex, 3].ParID			:= mcACPPAR_TEMP_POWERSTAGE_BAL;
			SegTempIDInfo[SegIndex, 3].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 3].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureBAL);
			SegTempIDInfo[SegIndex, 4].ParID			:= mcACPPAR_TEMP_AIROUT;
			SegTempIDInfo[SegIndex, 4].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 4].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureCHASSIS_1);
			SegTempIDInfo[SegIndex, 5].ParID			:= mcACPPAR_TEMP_MODUL3;
			SegTempIDInfo[SegIndex, 5].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 5].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureCHASSIS_2);
			SegTempIDInfo[SegIndex, 6].ParID			:= mcACPPAR_TEMP_MODUL4;
			SegTempIDInfo[SegIndex, 6].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 6].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperatureCHASSIS_3);
			SegTempIDInfo[SegIndex, 7].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS3;
			SegTempIDInfo[SegIndex, 7].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 7].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS3);
			SegTempIDInfo[SegIndex, 8].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS4;
			SegTempIDInfo[SegIndex, 8].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 8].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS4);
			SegTempIDInfo[SegIndex, 9].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS5;
			SegTempIDInfo[SegIndex, 9].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 9].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS5);
			SegTempIDInfo[SegIndex, 10].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS6;
			SegTempIDInfo[SegIndex, 10].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 10].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS6);
			SegTempIDInfo[SegIndex, 11].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS7;
			SegTempIDInfo[SegIndex, 11].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 11].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS7);
			SegTempIDInfo[SegIndex, 12].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS8;
			SegTempIDInfo[SegIndex, 12].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 12].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS8);
			SegTempIDInfo[SegIndex, 13].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS9;
			SegTempIDInfo[SegIndex, 13].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 13].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS9);
			SegTempIDInfo[SegIndex, 14].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS10;
			SegTempIDInfo[SegIndex, 14].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 14].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS10);
			SegTempIDInfo[SegIndex, 15].ParID			:= mcACPPAR_TEMP_POWERSTAGE_SENS11;
			SegTempIDInfo[SegIndex, 15].DataType		:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegTempIDInfo[SegIndex, 15].VariableAddress	:= ADR(TrackDiag.Seg.SegList[SegIndex].Status.Temp.TemperaturePOWER_SENS11);

			SegProcessParID_Temp[SegIndex].Segment := ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegProcessParID_Temp[SegIndex].ChannelIndex := 0;
			SegProcessParID_Temp[SegIndex].NumberOfParIDs := 16;
			SegProcessParID_Temp[SegIndex].Mode := mcACPTRAK_SEG_PARID_GET_NO_NCT;
			SegProcessParID_Temp[SegIndex].DataAddress := ADR(SegTempIDInfo[SegIndex,0]);
			
			
			SegPitchIDInfo[SegIndex].ParID				:= 1280; //Identification mode
			SegPitchIDInfo[SegIndex].DataType			:= mcACPTRAK_SEG_PARTYPE_UDINT;
			SegPitchIDInfo[SegIndex].VariableAddress	:= ADR(ZeroPitchDisableMode);
			
			SegFilterIDInfo[SegIndex].ParID				:= mcACPPAR_SCTRL_TI_FIL;
			SegFilterIDInfo[SegIndex].DataType			:= mcACPTRAK_SEG_PARTYPE_REAL;
			SegFilterIDInfo[SegIndex].VariableAddress	:= ADR(SpeedFilterTime);
			
			SegProcessParID_Pitch[SegIndex].Segment			:= ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegProcessParID_Pitch[SegIndex].ChannelIndex	:= 0;
			SegProcessParID_Pitch[SegIndex].NumberOfParIDs 	:= 1;
			SegProcessParID_Pitch[SegIndex].Mode			:= mcACPTRAK_SEG_PARID_SET;
			
			SegStatusIDInfo[SegIndex].DataType 		:= mcACPTRAK_SEG_PARTYPE_UDINT;
			SegStatusIDInfo[SegIndex].ParID			:= mcACPPAR_LLM_CYC_SEG_STATUS_BITS;
			SegStatusIDInfo[SegIndex].VariableAddress := ADR(SegmentReset[SegIndex].SegStatusBits);
			
			SegResetIDInfo[SegIndex].DataType 		:= mcACPTRAK_SEG_PARTYPE_UDINT;
			SegResetIDInfo[SegIndex].ParID			:= 1050;
			SegResetIDInfo[SegIndex].VariableAddress := ADR(SegmentReset[SegIndex].SegResetCmd);
				
			SegProcessParID_Reset[SegIndex].Segment			:= ADR(TrackDiag.Seg.SegList[SegIndex].McType);
			SegProcessParID_Reset[SegIndex].ChannelIndex 	:= 0;
			SegProcessParID_Reset[SegIndex].NumberOfParIDs 	:= 1;
			SegProcessParID_Reset[SegIndex].Mode			:= mcACPTRAK_SEG_PARID_GET_NO_NCT;
			
		END_IF
		
		
	END_FOR
	
	
	SegWarningCmdIDInfo.DataType 			:= mcACPTRAK_SEG_PARTYPE_UINT;
	SegWarningCmdIDInfo.VariableAddress 	:= ADR(CmdWarning);
	SegWarningCmdIDInfo.ParID 				:= mcACPPAR_CMD_ERROR;
	 
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
			
			//Command an update of the segment temperature data on the output of the refresh timer
			IF TempRefreshTON.Q THEN
				SegTempCheck[SegIndex].CmdCheckTemp := TRUE;
			END_IF
			//IF (*lag error monitoring is active*) THEN
				
				
			//END_IF
			
			
			
		END_IF
			
			
		
	END_FOR
		
	//
	IF(gSegResetActive)THEN
			
		SegDoneChk := TRUE;
			
		FOR SegIndex := 0 TO NUM_SEG DO
				
			IF NOT(SegmentReset[SegIndex].StsResetDone)THEN //Wait for all segments to be reset
				
				IF TrackDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN //If the array contains a segment reference
					SegDoneChk := FALSE;
				END_IF
					
			END_IF
				
		END_FOR
		
		IF(SegDoneChk)THEN
			gSegResetActive := FALSE;
				
			brsmemset(ADR(ErrorSegNum),0,SIZEOF(ErrorSegNum));
			brsmemset(ADR(ErrorSegName),0,SIZEOF(ErrorSegName));
			brsmemset(ADR(ErrorNumber),0,SIZEOF(ErrorNumber));
			
			ErrorCnt := 0;
			
		END_IF
			
		//Reset segment error
		IF(gTrakSystem.Asm.Cmd.ErrorReset) AND (ErrorCnt > 0)THEN
			
			FOR SegIndex := 0 TO NUM_SEG DO
				
				IF TrackDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN //If the array contains a segment reference
						
					IF(SegmentReset[SegIndex].State = WAIT_FOR_DONE) AND NOT(SegmentReset[SegIndex].StsResetDone)THEN //Try to reset segment again
						
						SegmentReset[SegIndex].CmdResetSeg 	:= TRUE; //Check to see if segments need to be reset (Undervoltage error)
						SegmentReset[SegIndex].State		:= WAIT_FOR_CHECK;
							
					END_IF
						
				END_IF
				
			END_FOR
				
		END_IF
			
	ELSE
			
		//Reset segment error
		IF(gTrakSystem.Asm.Cmd.ErrorReset) AND NOT(gSegResetActive) AND (ErrorCnt > 0)THEN
			
			gSegResetActive := TRUE;
			
			FOR SegIndex := 0 TO NUM_SEG DO
				
				IF TrackDiag.Seg.SegList[SegIndex].McType.controlif <> 0 THEN //If the array contains a segment reference
					SegmentReset[SegIndex].CmdResetSeg := TRUE; //Check to see if segments need to be reset (Undervoltage error)
				END_IF
				
			END_FOR
				
		END_IF
			
	END_IF
	
	TempRefreshTON.PT := TempRefreshTime;
	TempRefreshTON();
		
	CpuSim := DiagCpuIsSimulated() OR DiagCpuIsARsim();
	
	IF CpuSim = FALSE THEN
		actCheckErrorCode;
		actCheckTemp;
	END_IF	
		
	fbAuditTrail(MpLink := ADR(gAuditTrail_DiagModule), Enable := TRUE, Language := ADR('en'), DeviceName := ADR('User'));
	
END_PROGRAM

PROGRAM _EXIT
			(* Insert code here *)
	 
END_PROGRAM

