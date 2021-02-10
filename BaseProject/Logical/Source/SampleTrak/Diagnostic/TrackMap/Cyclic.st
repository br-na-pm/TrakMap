
PROGRAM _CYCLIC
	
	paperCore();
	
	clickId;
	
	// compare the elementID clicked on in paper with the configured ID to find and set the array index for the list binding
	FOR SegIndex:= 0 TO NUM_SEG DO 
		
		IF TrackDiag.Seg.SegList[SegIndex].Name = DELETE(clickId,1,1) THEN // clickId contains a leading # which needs to be removed 
			
			clickedSegment := TrackDiag.Seg.SegList[SegIndex];
			EXIT;
		END_IF	

	END_FOR	
	
END_PROGRAM
