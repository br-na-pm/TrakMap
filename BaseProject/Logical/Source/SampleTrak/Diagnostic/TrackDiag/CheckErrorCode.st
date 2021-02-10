
ACTION actCheckErrorCode: 

	
	FOR SegIndex := 0 TO NUM_SEG DO
		
		CASE SegErrorCheck[SegIndex].CheckState OF
			
			WAIT_FOR_CHECK:
				//Wait for the command to check the error code ParID on the segment
				SegProcessParID[SegIndex].Execute := FALSE;
				
				IF SegErrorCheck[SegIndex].CmdCheckErrorCode THEN
					SegProcessParID[SegIndex].Execute := TRUE;
//					SegProcessParID[SegIndex].DataAddress := ADR(SegStateIDInfo[SegIndex]);
					//					SegErrorCheck[SegIndex].CheckState := READ_DATA_SEG_STATE;
					SegProcessParID[SegIndex].Mode := mcACPTRAK_SEG_PARID_GET_NO_NCT;
					SegProcessParID[SegIndex].DataAddress := ADR(ErrorCodeIDInfo[SegIndex]);
					SegErrorCheck[SegIndex].CheckState := READ_DATA_SEG_ERROR;			
					SegErrorCheck[SegIndex].CmdCheckErrorCode := FALSE; //Reset check command
					
				END_IF
				
				
				
			READ_DATA_SEG_ERROR:
				//Check for completion of reading the PARID for
				
				IF SegProcessParID[SegIndex].Done THEN
					//If the parID was successfully read, go to check error code state
					SegErrorCheck[SegIndex].CheckState := CHECK_ERROR_CODE;
					SegProcessParID[SegIndex].Execute := FALSE;
					SegErrorCheck[SegIndex].DataReadExecutionError := FALSE;
				
				ELSIF SegProcessParID[SegIndex].Error THEN
					//If there was an error in reading, go to error start
					SegErrorCheck[SegIndex].CheckState := READ_EXEC_ERROR;
				END_IF
			
			
			CHECK_ERROR_CODE:
				
				IF (SegErrorCheck[SegIndex].ErrorNumber = 0) OR (SegErrorCheck[SegIndex].ErrorNumber = 36005) THEN
					//Segment has no new error recorded. Shows either 0 or the commanded warning (36005) used to overwrite old errors
					TrackDiag.Seg[SegIndex].Status.ErrorCode := 0;
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
					
					ErroredSegments[SegIndex].Error := FALSE;
				
				ELSE
					//Otherwise, there is a new error on this segment
					TrackDiag.Seg[SegIndex].Status.ErrorCode := SegErrorCheck[SegIndex].ErrorNumber;
					
					ErroredSegments[SegIndex].Error := TRUE;
					//Send to overwrite state to store a known error number (36005) in the error code parID
					SegErrorCheck[SegIndex].CheckState := WRITE_WARNING_CODE;
					
					//Send data to HMI
					IF(SegIndex > 0)THEN
						
						ErrorSegNum[ErrorCnt] 	:= SegIndex - 1;
						ErrorSegName[ErrorCnt]	:= TrackDiag.Seg[SegIndex].Name;
						ErrorNumber[ErrorCnt]	:= TrackDiag.Seg[SegIndex].Status.ErrorCode;
						ErrorCnt := ErrorCnt + 1;
						
					END_IF
					
				END_IF
				
			
			WRITE_WARNING_CODE:
				//Write commanded warning code (36005) to error parid
				SegProcessParID[SegIndex].DataAddress := ADR(SegWarningCmdIDInfo);
				SegProcessParID[SegIndex].ChannelIndex := 0;
				SegProcessParID[SegIndex].Mode := mcACPTRAK_SEG_PARID_SET;
				SegProcessParID[SegIndex].NumberOfParIDs := 0;
				SegProcessParID[SegIndex].Execute := TRUE;
				
				IF SegProcessParID[SegIndex].Done THEN
					//return to wait state
					SegProcessParID[SegIndex].Execute := FALSE;
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
					
				ELSIF SegProcessParID[SegIndex].Error THEN
					SegErrorCheck[SegIndex].CheckState := READ_EXEC_ERROR;
				END_IF
				
				
		
			
			READ_EXEC_ERROR:
				SegProcessParID[SegIndex].Execute := FALSE;
				SegErrorCheck[SegIndex].DataReadExecutionError := TRUE;
			
				IF SegProcessParID[SegIndex].Error = FALSE THEN
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
				END_IF
	
		
		END_CASE
		
	
	SegProcessParID[SegIndex]();	
	END_FOR
	
	
	
END_ACTION
