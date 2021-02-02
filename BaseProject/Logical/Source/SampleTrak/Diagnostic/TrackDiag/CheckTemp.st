
ACTION actCheckTemp: 

	
	FOR SegIndex := 0 TO NUM_SEG DO
		
		CASE SegTempCheck[SegIndex].CheckState OF
						
			WAIT_FOR_CHECK:
				//Wait for the command to check the the temperature data on the motor segment
				SegProcessParID_Temp[SegIndex].Execute := FALSE;
				
				IF SegTempCheck[SegIndex].CmdCheckTemp THEN
					SegTempCheck[SegIndex].CheckState := READ_DATA_SEG_TEMP;
					SegProcessParID_Temp[SegIndex].Execute := TRUE;
					SegTempCheck[SegIndex].CmdCheckTemp := FALSE; //Reset check command
				END_IF
				
			READ_DATA_SEG_TEMP:
				//Check for completion of reading Segment Status Bits
				IF SegProcessParID_Temp[SegIndex].Done THEN

					//If the parID was successfully read, go to check seg state
					SegTempCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
					SegProcessParID_Temp[SegIndex].Execute := FALSE;
					SegTempCheck[SegIndex].DataReadExecutionError := FALSE;
				
				ELSIF SegProcessParID_Temp[SegIndex].Error THEN
					//If there was an error in reading, go to error start
					SegTempCheck[SegIndex].CheckState := READ_EXEC_ERROR;
				END_IF
				
				
			CHECK_DATA_SEG_TEMP:
				

			READ_EXEC_ERROR:
				SegProcessParID_Temp[SegIndex].Execute := FALSE;
				SegTempCheck[SegIndex].DataReadExecutionError := TRUE;
			
				IF SegProcessParID_Temp[SegIndex].Error = FALSE THEN
					SegTempCheck[SegIndex].CheckState := WAIT_FOR_CHECK;
				END_IF
			
		
		END_CASE
		
	
		SegProcessParID_Temp[SegIndex]();	
	END_FOR
	
	
	
END_ACTION
