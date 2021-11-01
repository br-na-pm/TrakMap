
ACTION actCheckErrorCode: 

	
	FOR SegIndex := 0 TO NUM_SEG DO
		
		CASE SegErrorCheck[SegIndex].CheckState OF
			
			WAIT_FOR_CHECK:
				//Wait for the command to check the error code ParID on the segment
				DiagFbs.Seg.ProcessParID[SegIndex].Execute := FALSE;
				
				IF SegErrorCheck[SegIndex].CmdCheckErrorCode THEN
					ErrorCodeIDInfo[SegIndex].DataType := mcACPTRAK_SEG_PARTYPE_UINT;
					ErrorCodeIDInfo[SegIndex].ParID := mcACPPAR_ERROR_NUMBER;
					ErrorCodeIDInfo[SegIndex].VariableAddress := ADR(SegErrorCheck[SegIndex].ErrorNumber);
					
					DiagFbs.Seg.ProcessParID[SegIndex].Execute := TRUE;
					DiagFbs.Seg.ProcessParID[SegIndex].Segment := ADR(TrakDiag.Seg.SegList[SegIndex].McType);
					DiagFbs.Seg.ProcessParID[SegIndex].ChannelIndex := 0;
					DiagFbs.Seg.ProcessParID[SegIndex].NumberOfParIDs := 1;
					DiagFbs.Seg.ProcessParID[SegIndex].Mode := mcACPTRAK_SEG_PARID_GET_NO_NCT;
					DiagFbs.Seg.ProcessParID[SegIndex].DataAddress := ADR(ErrorCodeIDInfo[SegIndex]);
					SegErrorCheck[SegIndex].CheckState := READ_DATA_SEG_ERROR;			
					SegErrorCheck[SegIndex].CmdCheckErrorCode := FALSE; //Reset check command
					
				END_IF
				
			READ_DATA_SEG_ERROR:
				//Check for completion of reading the PARID for
				
				IF DiagFbs.Seg.ProcessParID[SegIndex].Done THEN
					//If the parID was successfully read, go to check error code state
					SegErrorCheck[SegIndex].CheckState := CHECK_ERROR_CODE;
					DiagFbs.Seg.ProcessParID[SegIndex].Execute := FALSE;
					SegErrorCheck[SegIndex].DataReadExecutionError := FALSE;
				
				ELSIF DiagFbs.Seg.ProcessParID[SegIndex].Error THEN
					//If there was an error in reading, go to error start
					SegErrorCheck[SegIndex].CheckState := READ_EXEC_ERROR;
				END_IF
			CHECK_ERROR_CODE:
				
				IF (SegErrorCheck[SegIndex].ErrorNumber = 0) OR (SegErrorCheck[SegIndex].ErrorNumber = 36005) THEN
					//Segment has no new error recorded. Shows either 0 or the commanded warning (36005) used to overwrite old errors
					TrakDiag.Seg.SegList[SegIndex].Status.ErrorCode := 0;
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
					TrakDiag.Seg.SegList[SegIndex].Status.Error := FALSE;
				
				ELSE
					//Otherwise, there is a new error on this segment
					TrakDiag.Seg.SegList[SegIndex].Status.ErrorCode := SegErrorCheck[SegIndex].ErrorNumber;
					
					TrakDiag.Seg.SegList[SegIndex].Status.Error := TRUE;
					//Send to overwrite state to store a known error number (36005) in the error code parID
					SegErrorCheck[SegIndex].CheckState := WRITE_WARNING_CODE;
				
				END_IF
			WRITE_WARNING_CODE:
				//Write commanded warning code (36005) to error parid
				DiagFbs.Seg.ProcessParID[SegIndex].DataAddress := ADR(SegWarningCmdIDInfo);
				DiagFbs.Seg.ProcessParID[SegIndex].ChannelIndex := 0;
				DiagFbs.Seg.ProcessParID[SegIndex].Mode := mcACPTRAK_SEG_PARID_SET;
				DiagFbs.Seg.ProcessParID[SegIndex].NumberOfParIDs := 0;
				DiagFbs.Seg.ProcessParID[SegIndex].Execute := TRUE;
				
				IF DiagFbs.Seg.ProcessParID[SegIndex].Done THEN
					//return to wait state
					DiagFbs.Seg.ProcessParID[SegIndex].Execute := FALSE;
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
					
				ELSIF DiagFbs.Seg.ProcessParID[SegIndex].Error THEN
					SegErrorCheck[SegIndex].CheckState := READ_EXEC_ERROR;
				END_IF		
			READ_EXEC_ERROR:
				DiagFbs.Seg.ProcessParID[SegIndex].Execute := FALSE;
				SegErrorCheck[SegIndex].DataReadExecutionError := TRUE;
			
				IF DiagFbs.Seg.ProcessParID[SegIndex].Error = FALSE THEN
					SegErrorCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
				END_IF
		END_CASE
	DiagFbs.Seg.ProcessParID[SegIndex]();	
	END_FOR
END_ACTION
