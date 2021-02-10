
PROGRAM _CYCLIC
	
	paperCore();
	
	clickId;
	
	// compare the elementID clicked on in paper with the configured ID to find and set the array index for the list binding
	FOR i:= 0 TO NUM_SEG DO 
		
		IF TrackDiag.Seg[i].Name = DELETE(clickId,1,1) THEN // clickId contains a leading # which needs to be removed 
			
			clickedSegmentStatus := TrackDiag.Seg[i].Status;
			EXIT;
		END_IF	

	END_FOR	
	
END_PROGRAM
