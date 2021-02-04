
PROGRAM _CYCLIC
	
	CASE state OF
		SEG_TRACE_IDLE:	//********************************************************************************************************* Trace Idle State
			IF gSegTraceIf.Cmds.Capture THEN
				gSegTraceIf.Status.Active := TRUE;
				gSegTraceIf.Status.Result := segTracePass;
				
				FOR i:=0 TO gSegTraceIf.Pars.SegmentCount - 1 DO
					brsmemset(ADR(segTraceResults[i].Values),0,SIZEOF(segTraceResults[i].Values));				
					segTraceResults[i].BalancerPass := FALSE;
					segTraceResults[i].UDCActPass := FALSE;
					segTraceResults[i].UDCMiddlePass := FALSE;
					segTraceResults[i].BalancerSum := FALSE;
				END_FOR;
				brsmemset(ADR(gSegTraceIf.Status.Failures),0,SIZEOF(gSegTraceIf.Status.Failures));
				gSegTraceIf.Status.FailCount := 0;
				
				segIdx := 0;
				ProcessParId.Segment := gSegTraceIf.Pars.Segments[segIdx];
				ProcessParId.Mode := mcACPTRAK_SEG_PARID_GET_NO_NCT;
				ProcessParId.NumberOfParIDs := 5;
				gSegTraceIf.Pars.ParIds[0].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_1);
				gSegTraceIf.Pars.ParIds[1].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_2);
				gSegTraceIf.Pars.ParIds[2].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_3);
				gSegTraceIf.Pars.ParIds[3].VariableAddress := ADR(segTraceResults[segIdx].Values.UdcAct);
				gSegTraceIf.Pars.ParIds[4].VariableAddress := ADR(segTraceResults[segIdx].Values.UdcMiddleAct);
				ProcessParId.DataAddress := ADR(gSegTraceIf.Pars.ParIds);
				ProcessParId.Execute := TRUE;
				
				//TODO: Validate that the gSegTraceIf.Pars.SegmentCount is < MAX_SEGMENTS 
				
				state := SEG_TRACE_READ_SEG;
			ELSIF gSegTraceIf.Cmds.Export THEN
				RecipeXml.FileName := ADR(gSegTraceIf.Pars.Export.FileName);
				RecipeXml.Save := TRUE;
				
				state := SEG_TRACE_EXPORT;
			END_IF
			
		SEG_TRACE_READ_SEG://********************************************************************************************************* Trace Read Segment State
			IF ProcessParId.Error THEN
				gSegTraceIf.Status.Error := TRUE;
				gSegTraceIf.Status.Result := segTraceFail;
				state := SEG_TRACE_ERROR;
			ELSIF ProcessParId.Done THEN
				ProcessParId.Execute := FALSE;
				
				state := SEG_TRACE_CALC_RESULTS;
			END_IF
		SEG_TRACE_CALC_RESULTS://********************************************************************************************************* Trace Calculate Results State
			//Check the balancer sum
			segTraceResults[segIdx].BalancerSum := ABS(segTraceResults[segIdx].Values.BalCurrent_Act_1 + segTraceResults[segIdx].Values.BalCurrent_Act_2 + segTraceResults[segIdx].Values.BalCurrent_Act_3);
			IF segTraceResults[segIdx].BalancerSum > gSegTraceIf.Pars.BalancerCurrentLimit THEN
				gSegTraceIf.Status.Result := segTraceFail;
				segTraceResults[segIdx].BalancerPass := FALSE;
			ELSE
				segTraceResults[segIdx].BalancerPass := TRUE;
			END_IF
			//Check the UDC ACT vs power supply configured
			//TODO: Ideally the PS_UDC and POWERFAIL_DETECT_RATIO would be auto detected
			IF segTraceResults[segIdx].Values.UdcAct < gSegTraceIf.Pars.PS_UDC_Value * gSegTraceIf.Pars.PowerFailDetectRatio THEN
				gSegTraceIf.Status.Result := segTraceFail;
				segTraceResults[segIdx].UDCActPass := FALSE;
			ELSE
				segTraceResults[segIdx].UDCActPass := TRUE;
			END_IF
			
			//Check to verify UDC Middle is no more than +/- 7V around 1/2 UDC_ACT
			IF segTraceResults[segIdx].Values.UdcMiddleAct > segTraceResults[segIdx].Values.UdcAct / 2.0 + 7.0 OR segTraceResults[segIdx].Values.UdcMiddleAct < segTraceResults[segIdx].Values.UdcAct / 2.0 - 7.0 THEN
				gSegTraceIf.Status.Result := segTraceFail;
				segTraceResults[segIdx].UDCMiddlePass := FALSE;
			ELSE
				segTraceResults[segIdx].UDCMiddlePass := TRUE;
			END_IF
			
			
			segIdx := segIdx + 1;
			IF segIdx < gSegTraceIf.Pars.SegmentCount THEN
				ProcessParId.Segment := gSegTraceIf.Pars.Segments[segIdx];
				gSegTraceIf.Pars.ParIds[0].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_1);
				gSegTraceIf.Pars.ParIds[1].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_2);
				gSegTraceIf.Pars.ParIds[2].VariableAddress := ADR(segTraceResults[segIdx].Values.BalCurrent_Act_3);
				gSegTraceIf.Pars.ParIds[3].VariableAddress := ADR(segTraceResults[segIdx].Values.UdcAct);
				gSegTraceIf.Pars.ParIds[4].VariableAddress := ADR(segTraceResults[segIdx].Values.UdcMiddleAct);
				ProcessParId.Execute := TRUE;
				
				state := SEG_TRACE_READ_SEG;
				
			ELSE
				state := SEG_TRACE_ADD_FAILS;
			END_IF
		SEG_TRACE_ADD_FAILS: //********************************************************************************************************* Trace Add Up Failures State
			FOR i := 0 TO gSegTraceIf.Pars.SegmentCount - 1 DO
				IF NOT segTraceResults[i].BalancerPass OR NOT segTraceResults[i].UDCActPass OR NOT segTraceResults[i].UDCMiddlePass THEN
					gSegTraceIf.Status.Failures[gSegTraceIf.Status.FailCount].SegName := segTraceResults[i].SegmentName;
					gSegTraceIf.Status.Failures[gSegTraceIf.Status.FailCount].WarningActive := TRUE;
					gSegTraceIf.Status.Failures[gSegTraceIf.Status.FailCount].BalancerFail := NOT segTraceResults[i].BalancerPass;
					gSegTraceIf.Status.Failures[gSegTraceIf.Status.FailCount].UDCActFail := NOT segTraceResults[i].UDCActPass;
					gSegTraceIf.Status.Failures[gSegTraceIf.Status.FailCount].UDCMiddleActFail := NOT segTraceResults[i].UDCMiddlePass;
					
					gSegTraceIf.Status.FailCount := gSegTraceIf.Status.FailCount + 1;
				END_IF
			END_FOR;
			
			IF gSegTraceIf.Status.FailCount > 0 THEN
				RecipeXml.FileName := ADR(gSegTraceIf.Pars.Export.FileName);
				RecipeXml.Save := TRUE;
				
				state := SEG_TRACE_EXPORT;
			ELSE
				gSegTraceIf.Status.Done := TRUE;
				
				state := SEG_TRACE_DONE;
			END_IF
		SEG_TRACE_DONE://********************************************************************************************************* Trace Done State
			IF NOT gSegTraceIf.Cmds.Capture THEN
				ProcessParId.Execute := FALSE;
				
				segIdx := 0;
				gSegTraceIf.Status.Active := FALSE;
				gSegTraceIf.Status.Done := FALSE;
				gSegTraceIf.Status.Error := FALSE;
				
				state := SEG_TRACE_IDLE;
			END_IF
		SEG_TRACE_EXPORT://********************************************************************************************************* Trace Export State
			IF RecipeXml.CommandDone THEN
				RecipeXml.Save := FALSE;
				IF gSegTraceIf.Cmds.Capture THEN
					gSegTraceIf.Status.Done := TRUE;
					state := SEG_TRACE_DONE;
				ELSE
					gSegTraceIf.Cmds.Export := FALSE;
					state := SEG_TRACE_IDLE;
				END_IF
				
			ELSIF RecipeXml.Error THEN
				state := SEG_TRACE_ERROR;
			END_IF
		SEG_TRACE_ERROR://********************************************************************************************************* Trace Error State
			IF gSegTraceIf.Cmds.ErrorReset THEN
				ProcessParId.Execute := FALSE;
				
				segIdx := 0;
				FOR i:=0 TO gSegTraceIf.Pars.SegmentCount - 1 DO
					brsmemset(ADR(segTraceResults[i].Values),0,SIZEOF(segTraceResults[i].Values));				
					segTraceResults[i].BalancerPass := FALSE;
					segTraceResults[i].UDCActPass := FALSE;
					segTraceResults[i].UDCMiddlePass := FALSE;
					segTraceResults[i].BalancerSum := FALSE;
				END_FOR;
				brsmemset(ADR(gSegTraceIf.Status.Failures),0,SIZEOF(gSegTraceIf.Status.Failures));
				gSegTraceIf.Status.FailCount := 0;
				gSegTraceIf.Status.Active := FALSE;
				gSegTraceIf.Status.Done := FALSE;
				gSegTraceIf.Status.Error := FALSE;
				gSegTraceIf.Status.Result := segTraceUnknown;
				
				state := SEG_TRACE_IDLE;
			END_IF
		
	END_CASE;
	
	//FB Call 
	ProcessParId();
	
	RecipeXml();
	RegPar[0]();
	RegPar[1]();
END_PROGRAM

