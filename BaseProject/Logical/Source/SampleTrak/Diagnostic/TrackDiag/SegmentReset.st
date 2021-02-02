
ACTION actSegmentReset: 

	
	FOR SegIndex := 0 TO NUM_SEG DO
		
		CASE SegmentReset[SegIndex].State OF
			
			WAIT_FOR_CHECK:
				
				//Wait for the command to check the segment status
				SegProcessParID_Reset[SegIndex].Execute := FALSE;
				
				IF SegmentReset[SegIndex].CmdResetSeg THEN
					
					SegmentReset[SegIndex].CmdResetSeg 		:= FALSE; //Reset check command
					SegmentReset[SegIndex].StsResetDone 	:= FALSE; //Reset done status
					
					//Check segment status
					IF NOT(SegReadInfo[SegIndex].SegmentInfo.ReadyForPowerOn)THEN
						
						IF(TrackDiag.Seg[SegIndex].Status.ErrorCode = 6020)THEN  		//Undervoltage error
							SegmentReset[SegIndex].State := WRITE_SEG_RESET;
						ELSE
							SegmentReset[SegIndex].State := WAIT_FOR_DONE;
						END_IF
						
					ELSE
						
						SegmentReset[SegIndex].State 	:= WAIT_FOR_DONE; 
						
					END_IF
					
				END_IF
						
			
			WRITE_SEG_RESET:
				
				//Wait for the command to check the error code ParID on the segment			
				SegProcessParID_Reset[SegIndex].Execute := TRUE;
				SegProcessParID_Reset[SegIndex].Mode 	:= mcACPTRAK_SEG_PARID_SET;
				SegProcessParID_Reset[SegIndex].DataAddress := ADR(SegResetIDInfo[SegIndex]);
					
				//Check for completion of reading the PARID for
				IF SegProcessParID_Reset[SegIndex].Done THEN
					//If the parID was successfully read, go to check error code state
					SegProcessParID_Reset[SegIndex].Execute 		:= FALSE;
					SegmentReset[SegIndex].DataReadExecutionError 	:= FALSE;
					
					SegmentReset[SegIndex].State 			:= WAIT_FOR_DONE;
				
				ELSIF SegProcessParID_Reset[SegIndex].Error THEN
					//If there was an error in reading, go to error start
					SegmentReset[SegIndex].State := READ_EXEC_ERROR;
				END_IF	
				
			WAIT_FOR_DONE:
				
				IF (SegReadInfo[SegIndex].SegmentInfo.ReadyForPowerOn)THEN
		
					SegmentReset[SegIndex].StsResetDone 	:= TRUE; //Set done status
					SegmentReset[SegIndex].State 			:= WAIT_FOR_CHECK;
					
				ELSIF SegReadInfo[SegIndex].Error THEN
					//If there was an error in reading, go to error start
					SegmentReset[SegIndex].State := READ_EXEC_ERROR;
					
				END_IF
				
			
			READ_EXEC_ERROR:
				SegProcessParID_Reset[SegIndex].Execute := FALSE;
				SegmentReset[SegIndex].DataReadExecutionError := TRUE;
			
				IF SegProcessParID_Reset[SegIndex].Error = FALSE THEN
					SegmentReset[SegIndex].State := WAIT_FOR_CHECK;
				END_IF
	
		
		END_CASE
		
	
		SegProcessParID_Reset[SegIndex]();	
	END_FOR
	
	
	
END_ACTION
