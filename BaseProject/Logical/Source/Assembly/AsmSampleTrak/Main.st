(*******************************************************************************
 * Copyright: B&R Industrial Automation
 * Author:    Tyler Matijevich
 * Created:   November 5, 2020/12:35 
********************************************************************************
 * Description: Control program to handle assembly power commands and error 
 statuses
********************************************************************************)

PROGRAM _INIT
	fbSecAddShuttle.Sector := ADR(TrakInterface.SectorTrakA);
	fbSecAddShuttle.Position := 1000;

END_PROGRAM

PROGRAM _CYCLIC

	fbTrakModule(MpLink := ADR(TrakInterface.ModulePml), 
					Enable := TRUE, 
					Parameters := ADR(parTrakModule));
	
	// Reset command if no error
	IF gTrakSystem.Asm.Status.Error = FALSE THEN
		gTrakSystem.Asm.Cmd.ErrorReset := FALSE; // Force this command to reset
	END_IF
	
	(****************************************************************************************************
	****************************************************************************************************)
	(*
		Interrupts:
		1. Error status
		2. Stop command
		3. Read error
		4. ErrorStop state
	*)
	
	// 1. Skip remaining interrupt checks when an error exists
	IF gTrakSystem.Asm.Status.Error OR ShInit.Status.Error THEN
		// Go to ERROR
		AssemblyState := ASM_STATE_ERROR;
		
	// 2. Accept stop command
	ELSIF EDGENEG(gTrakSystem.Asm.Cmd.Power) THEN
		// Power off if powering or powered on
		IF gTrakSystem.Asm.Status.Homing OR gTrakSystem.Asm.Status.Ready THEN
			// Execute the power off command. Execute should not be true in either of these states
			fbAsmPowerOff.Execute := TRUE;
		END_IF
		
		// Go to OFF
		AssemblyState := ASM_STATE_OFF;
		
	// 3. The assembly read function blocks are in error
	ELSIF fbAsmReadStatus.Error OR fbAsmReadInfo.Error THEN
		// Log event
		// Set error status and go to ERROR
		gTrakSystem.Asm.Status.Error	:= TRUE;
		AssemblyState 				:= ASM_STATE_ERROR;
		
	// 4. Assembly in ErrorStop
	ELSIF gTrakSystem.Asm.Status.ErrorStop AND fbAsmReset.Busy = FALSE THEN
		// Log event
		// Set error status and go to ERROR
		gTrakSystem.Asm.Status.Error	:= TRUE;
		AssemblyState 				:= ASM_STATE_ERROR;
		
	END_IF
	
	(****************************************************************************************************
	****************************************************************************************************)
	// Main assembly state machine
	CASE AssemblyState OF
		// ----------------------------------------------------------------------------------------------------
		// OFF
		ASM_STATE_OFF:
			// Accept AsmPowerOff command
			IF fbAsmPowerOff.Done THEN
				// Reset execution
				fbAsmPowerOff.Execute := FALSE;
				
			ELSIF fbAsmPowerOff.Error THEN
				// Log event
				// Set error status and go to ERROR
				gTrakSystem.Asm.Status.Error	:= TRUE;
				AssemblyState 				:= ASM_STATE_ERROR;
				
			// Accept AsmReset command
			ELSIF fbAsmReset.Done THEN
				// Reset execution
				fbAsmReset.Execute := FALSE;
				
			ELSIF fbAsmReset.Error THEN
				// Log event
				// Set error status and go to ERROR
				gTrakSystem.Asm.Status.Error	:= TRUE;
				AssemblyState 				:= ASM_STATE_ERROR;
				
			// Wait for power command and assembly conditions
			ELSIF gTrakSystem.Asm.Cmd.Power AND gTrakSystem.Asm.Cmd.Stop = FALSE // Read input commands
			  AND gTrakSystem.Asm.Status.Disabled AND gTrakSystem.Asm.Status.ReadyForPowerOn // Check assembly statuses
			  AND fbAsmPowerOff.Execute = FALSE AND fbAsmReset.Execute = FALSE 
			  (*AND MpPackMLStateIsActive(TrakInterface.ModulePml,mpPACKML_STATE_EXECUTE,1)*)
			  	THEN // Check other function block execution
				// Power on the assembly
				fbAsmPowerOn.Execute := TRUE;
				
				// Go to POWER
				AssemblyState := ASM_STATE_POWER;
		
			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// POWER
		ASM_STATE_POWER:
			// Wait for the power on command to complete, ensure correct statuses
			IF fbAsmPowerOn.Done AND gTrakSystem.Asm.Status.Ready AND gTrakSystem.Asm.Status.PowerOn THEN
				// Reset execution
				fbAsmPowerOn.Execute := FALSE;
				
				// Go to READY
				AssemblyState := ASM_STATE_READY;
				
//				// Check shuttle initialization for ready status
//				IF ShInit.Status.Ready THEN
//					// Start the shuttle initialization
//					ShInit.Cmd.Start := TRUE;
//				
//					// Go to INIT
//					AssemblyState := ASM_STATE_INIT;
//					
//				ELSE
//					// Log event
//					// Set error status and go to ERROR
//					gTrakSystem.Asm.Status.Error	:= TRUE;
//					AssemblyState 				:= ASM_STATE_ERROR;
//					
//				END_IF
				
			ELSIF fbAsmPowerOn.Error THEN
				// Log event
				// Set error status and go to ERROR
				gTrakSystem.Asm.Status.Error	:= TRUE;
				AssemblyState 				:= ASM_STATE_ERROR;
				
			// Check if the assembly suddenly loses power
			ELSIF (gTrakSystem.Asm.Status.Disabled OR gTrakSystem.Asm.Status.PowerOn = FALSE)
			  AND fbAsmPowerOn.Execute = FALSE THEN
				// Log event
				// Set error status and go to ERROR
				gTrakSystem.Asm.Status.Error	:= TRUE;
				AssemblyState 				:= ASM_STATE_ERROR;
				
			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// INIT
		ASM_STATE_INIT:
		// Go to READY
				AssemblyState := ASM_STATE_READY;
		
			// Wait for the shuttle initialization to complete
//			IF ShInit.Status.Complete THEN
//				// Reset command
//				ShInit.Cmd.Start := FALSE;
//				
//				// Go to READY
//				AssemblyState := ASM_STATE_READY;
//				
//			ELSIF ShInit.Status.Error THEN
//				// Log event
//				// Set error status and go to ERROR
//				gTrakSystem.Asm.Status.Error	:= TRUE;
//				AssemblyState 				:= ASM_STATE_ERROR;
//			
//			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// READY
		ASM_STATE_READY:
			// Check if the assembly suddenly becomes disabled
			IF gTrakSystem.Asm.Status.Disabled THEN
				// Log event
				// Set error status and go to ERROR
				gTrakSystem.Asm.Status.Error	:= TRUE;
				AssemblyState 				:= ASM_STATE_ERROR;
				
			END_IF
		
		
		// ----------------------------------------------------------------------------------------------------
		// ERROR
		ASM_STATE_ERROR:
			// Wait for an error reset command
			IF gTrakSystem.Asm.Cmd.ErrorReset THEN
				// If ErrorStop, reset the assembly
				IF gTrakSystem.Asm.Status.ErrorStop AND fbAsmReset.Error = FALSE THEN
					// Execute an assembly reset
					fbAsmReset.Execute := TRUE;
					
					// Reset other function block's execution
					fbAsmPowerOn.Execute 	:= FALSE;
					fbAsmPowerOff.Execute	:= FALSE;
					
				// If powered
				ELSIF (gTrakSystem.Asm.Status.Homing OR gTrakSystem.Asm.Status.Ready) AND fbAsmPowerOff.Error = FALSE THEN
					// Power off the assembly
					fbAsmPowerOff.Execute := TRUE;
					
					// Reset other function block's execution
					fbAsmPowerOn.Execute 	:= FALSE;
					fbAsmReset.Execute		:= FALSE;
					
				ELSE
					// Reset all function block's execution
					fbAsmPowerOn.Execute 	:= FALSE;
					fbAsmPowerOff.Execute	:= FALSE;
					fbAsmReset.Execute		:= FALSE;
					
				END_IF // Check assembly state
				
				// Reset the error bit and go back to OFF
				gTrakSystem.Asm.Status.Error	:= FALSE;
				AssemblyState				:= ASM_STATE_OFF;
			
			END_IF
	
	END_CASE // Assembly state machine
	
	// Call all mapp Trak function blocks
	fbAsmReadStatus(Assembly := ADR(gSampleTrak), Enable := TRUE); // Always enable to reduce logger entries
	fbAsmReadInfo(Assembly := ADR(gSampleTrak), Enable := TRUE); // Always enable to reduce logger entries
	fbAsmPowerOn(Assembly := ADR(gSampleTrak));
	fbAsmPowerOff(Assembly := ADR(gSampleTrak));
	fbAsmReset(Assembly := ADR(gSampleTrak));
	fbSecAddShuttle();
	fbSecAddShuttle.Execute := FALSE;
	
	// Update the global status information
	gTrakSystem.Asm.Status.Disabled					:= fbAsmReadStatus.Valid AND fbAsmReadStatus.AssemblyDisabled;
	gTrakSystem.Asm.Status.Homing					:= fbAsmReadStatus.Valid AND fbAsmReadStatus.AssemblyHoming;
	gTrakSystem.Asm.Status.Ready					:= fbAsmReadStatus.Valid AND fbAsmReadStatus.AssemblyReady;
	gTrakSystem.Asm.Status.Stopping					:= fbAsmReadStatus.Valid AND fbAsmReadStatus.AssemblyStopping;
	gTrakSystem.Asm.Status.ErrorStop				:= fbAsmReadStatus.Valid AND fbAsmReadStatus.AssemblyErrorStop;
	gTrakSystem.Asm.Status.CommunicationReady		:= fbAsmReadInfo.Valid AND fbAsmReadInfo.AssemblyInfo.CommunicationReady;
	gTrakSystem.Asm.Status.ReadyForPowerOn			:= fbAsmReadInfo.Valid AND fbAsmReadInfo.AssemblyInfo.ReadyForPowerOn;
	gTrakSystem.Asm.Status.PowerOn					:= fbAsmReadInfo.Valid AND fbAsmReadInfo.AssemblyInfo.PowerOn;
	gTrakSystem.Asm.Status.ShuttlesInErrorStopCount	:= fbAsmReadInfo.AssemblyInfo.ShuttlesInErrorStopCount; // If not valid, assuming these are zero
	gTrakSystem.Asm.Status.StartupCount				:= fbAsmReadInfo.AssemblyInfo.StartupCount;
	
	// Call all subroutine actions
	ShInit.Cmd.Stop := gTrakSystem.Asm.Status.Ready = FALSE;
//	ShuttleInitialization;
	
END_PROGRAM

PROGRAM _EXIT
	
END_PROGRAM
