
PROGRAM _INIT
	(* Insert code here *)
	 TrackInterface;
END_PROGRAM

PROGRAM _CYCLIC
	// Reset status variables, they will be set in the respective state
	ShInit.Status.Ready 	:= FALSE;
	ShInit.Status.Complete	:= FALSE;
	
	(*
		Interrupts:
		1. Error status
		2. Stop command
	*)
	// 1. Check error status
	IF ShInit.Status.Error THEN
		// Go to ERROR, skip remaining interrupts
		ShInitState := 255;
		
	// 2. Accept stop commands
	ELSIF ShInit.Cmd.Stop THEN
		// Reset FB execution
		fbAsmGetShuttle.Enable		:= FALSE;
		fbShCopyUserData.Execute 	:= FALSE;
		
		// Go to INIT
		ShInitState := 0;
		
	END_IF
	
	// Shuttle initialization main state machine
	CASE ShInitState OF
		// ----------------------------------------------------------------------------------------------------
		// INIT
		0:
			// Set the status
			ShInit.Status.Ready := TRUE;
			
			// Wait to start
			IF ShInit.Cmd.Start AND ShInit.Cmd.Stop = FALSE THEN
				// Clear the shuttle buffer
				BufferReturnIndex := TrBaseClearShBuffer(ADR(gTrakSystem.Buffer), SIZEOF(gTrakSystem.Buffer));
				IF BufferReturnIndex = trBASE_NO_ERROR THEN
					// Enable the assembly get shuttle function block
					fbAsmGetShuttle.Assembly 	:= ADR(TrackInterface.SampleTrak);
					fbAsmGetShuttle.Enable 		:= TRUE;
					
					// Go to READ
					ShInitState := 10;
					
				ELSE
					// Log event
					// Set error status and go to ERROR
					ShInit.Status.Error := TRUE;
					ShInitState 		:= 255;
				
				END_IF
			END_IF // Start
		
		// ----------------------------------------------------------------------------------------------------
		// READ
		10:
			// Wait for a valid read, then read the shuttle
			IF fbAsmGetShuttle.Valid AND fbAsmGetShuttle.TotalCount > 0 THEN
				// Add the shuttle to the buffer
				BufferReturnIndex := TrBaseAddShToBuffer(fbAsmGetShuttle.Axis, ADR(gTrakSystem.Buffer), SIZEOF(gTrakSystem.Buffer));
				IF BufferReturnIndex = trBASE_NO_ERROR THEN
					// Shuttle added successfully, read the shuttle user data
					fbShCopyUserData.Axis 			:= ADR(fbAsmGetShuttle.Axis);
					fbShCopyUserData.DataAddress	:= ADR(ShuttleUserData);
					fbShCopyUserData.DataSize		:= SIZEOF(ShuttleUserData);
					fbShCopyUserData.Mode			:= mcACPTRAK_USERDATA_GET;
					fbShCopyUserData.Execute		:= TRUE;
					
					// Go to DATA
					ShInitState := 20;
				
				ELSE
					// Log event
					// Set error status and go to ERROR
					ShInit.Status.Error := TRUE;
					ShInitState 		:= 255;
				
				END_IF
			
			ELSIF fbAsmGetShuttle.Valid AND fbAsmGetShuttle.TotalCount = 0 THEN // No shuttles on the assembly
				// Go straight to the complete state
				ShInitState := 60;
			
			ELSIF fbAsmGetShuttle.Error THEN
				// Log event
				// Set error status and go to ERROR
				ShInit.Status.Error := TRUE;
				ShInitState 		:= 255;
			
			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// DATA
		20:
			IF fbShCopyUserData.Done THEN
				// Reset the command
				fbShCopyUserData.Execute := FALSE;
				
				// Go to WRITE
				ShInitState := 30;
				
			ELSIF fbShCopyUserData.Error THEN
				// Log event
				// Set error status and go to ERROR
				ShInit.Status.Error := TRUE;
				ShInitState 		:= 255;
				
			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// WRITE
		30:
			IF fbShCopyUserData.Done THEN
				// Shuttle user data write complete, shuttle ID set, reset the execution
				fbShCopyUserData.Execute := FALSE;
				
				// Reset the assembly get shuttle next command
				fbAsmGetShuttle.Next := FALSE;
				
				// Go to MOVE
				ShInitState := 35;
			
			ELSIF fbShCopyUserData.Error THEN
				// Log event
				// Set error status and go to ERROR
				ShInit.Status.Error := TRUE;
				ShInitState 		:= 255;
			
			ELSE
				// Execute the write command 
				fbShCopyUserData.Mode		:= mcACPTRAK_USERDATA_SET;
				fbShCopyUserData.Execute 	:= TRUE;
				
				// Set the shuttle ID (if not already set)
				ShuttleUserData.ID := fbAsmGetShuttle.AdditionalInfo.ShuttleID;
				
			END_IF
			
		// ----------------------------------------------------------------------------------------------------
		// MOVE
		35:
			fbRoutedMoveVel_AcpTrak.Axis			:= ADR(fbAsmGetShuttle.Axis);
			fbRoutedMoveVel_AcpTrak.Execute			:= TRUE;
			fbRoutedMoveVel_AcpTrak.Sector			:= ADR(TrackInterface.SectorTrackA);
			fbRoutedMoveVel_AcpTrak.Position		:= 1;
			fbRoutedMoveVel_AcpTrak.Acceleration	:= 10.0;
			fbRoutedMoveVel_AcpTrak.Deceleration	:= 10.0;
			fbRoutedMoveVel_AcpTrak.Jerk			:= 0.0;
			fbRoutedMoveVel_AcpTrak.BufferMode		:= mcABORTING;
			fbRoutedMoveVel_AcpTrak.RouteVelocity	:= 2;
			fbRoutedMoveVel_AcpTrak.Velocity		:= 2;
			fbRoutedMoveVel_AcpTrak.AdvancedParameters.StartDirection := mcDIR_POSITIVE;
			ShInitState := 40;
		
		// ----------------------------------------------------------------------------------------------------
		// UPDATE
		40:
			// Check for the next shuttle
			IF fbAsmGetShuttle.Valid AND fbAsmGetShuttle.RemainingCount > 0 THEN
				// Issue next command and go back to the READ state
				fbAsmGetShuttle.Next 	:= TRUE;
				ShInitState				:= 10;
				
			// Check when no shuttles remain
			ELSIF fbAsmGetShuttle.Valid AND fbAsmGetShuttle.RemainingCount = 0 THEN
				// All shuttles have been captured, reset the FB
				fbAsmGetShuttle.Enable := FALSE;
				
				// Go to DELETE
				ShInitState := 50;
				
			ELSIF fbAsmGetShuttle.Error THEN
				// Log event
				// Set error status and go to ERROR
				ShInit.Status.Error := TRUE;
				ShInitState 		:= 255;
			
			END_IF
			
		// ----------------------------------------------------------------------------------------------------
		// DELETE
		50:
			// Shuttle detection complete, now delete marked shuttles
			gTrakSystem.Tracking.Cmd.Delete := gTrakSystem.Tracking.Status.ShuttlesToBeDeletedCount <> 0;
			
			// Leave when no shuttles need to be deleted
			IF gTrakSystem.Tracking.Status.ShuttlesToBeDeletedCount = 0 THEN
				// Go to COMPLETE
				ShInitState := 60;
			END_IF
			
		// ----------------------------------------------------------------------------------------------------
		// COMPLETE
		60:
			// Set the status
			ShInit.Status.Complete := TRUE;
			
			// Return to INIT when the state command is reset
			IF ShInit.Cmd.Start = FALSE THEN
				// Go to INIT
				ShInitState := 0;
			END_IF
		
		// ----------------------------------------------------------------------------------------------------
		// ERROR
		255:
			// Wait for error reset command
			IF ShInit.Cmd.ErrorReset THEN
				// Reset the function blocks
				fbAsmGetShuttle.Enable 		:= FALSE;
				fbShCopyUserData.Execute 	:= FALSE;
				
				// Reset the error bit and go to INIT
				ShInit.Status.Error := FALSE;
				ShInitState 		:= 0;
				
			END_IF
	
	END_CASE
	
	// Call mapp Trak function blocks
	fbAsmGetShuttle();
	fbShCopyUserData();
	fbShCopyUserData();
	fbRoutedMoveVel_AcpTrak();
	fbRoutedMoveVel_AcpTrak.Execute := FALSE;
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

