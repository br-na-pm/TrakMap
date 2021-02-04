(*Track Master Core Types*)

TYPE
	tpCoreInternalTyp : 	STRUCT  (*Internal Datatype*)
		TypeID : UDINT; (*TypeID to help with handle application*)
		State : USINT; (*State of execution*)
		Axes : ARRAY[0..tpMAX_SHUTLE_ARRAY]OF tpCoreAxisLookupTyp; (*Axis Lookup table based on the current Shuttle Index*)
		Fbs : tpCoreFbTyps; (*Internal Function blocks*)
		ShCount : USINT; (*Shuttle Count*)
	END_STRUCT;
	tpCoreViewBoxCfgTyp : 	STRUCT  (*Attributes of the SVG's viewbox*)
		MinX : REAL; (*Minimum x position*)
		MinY : REAL; (*minimum y position*)
		Width : REAL; (*Width of viewbox*)
		Height : REAL; (*Height of viewbox*)
	END_STRUCT;
	tpCoreStateEnum : 
		( (*State of execution*)
		tpCORE_OFF, (*Waiting for enable command*)
		tpCORE_INIT, (*Initialization state*)
		tpCORE_GET_SH, (*Get the shuttle in the assembly*)
		tpCORE_GET_NEXT, (*Set the next command*)
		tpCORE_RUNNING, (*Running state*)
		tpCORE_RESET, (*Resetting state*)
		tpCORE_ERROR (*Error state*)
		);
	tpCoreErrorEnum : 
		( (*Error Enumeration*)
		tpCORE_ERR_OK := 0, (*No error present*)
		tpCORE_ERR_INVALID_ASSEMBLY := -61000, (*Invalid input assembly reference*)
		tpCORE_ERR_SH_COUNT_EXCEEDED := -61001, (*Maximum shuttle count exceeded. Need to increase max shuttle count constant*)
		tpCORE_ERR_STR_LEN_EXCEEDED := -61002 (*The built string is too long, need to increase the maximum size to prevent page faulting*)
		);
	tpCoreSvgLengthsTyp : 	STRUCT  (*String lengths of SVGs*)
		ContentLength : UDINT; (*String Length of SVG Content string*)
		TransformLength : UDINT; (*String Length of SVG Transform string*)
	END_STRUCT;
	tpCoreFbTyps : 	STRUCT  (*Internal Function blocks*)
		AsmGetShuttle : MC_BR_AsmGetShuttle_AcpTrak;
	END_STRUCT;
	tpCoreAxisLookupTyp : 	STRUCT  (*Lookup table datatype*)
		Present : BOOL; (*Axis is present and a valid reference exists*)
		Axis : McAxisType; (*Axis information*)
	END_STRUCT;
	tpCoreOptionsTyp : 	STRUCT  (*Options for Core Function Block*)
		Color : tpCoreColorOptionTyp; (*Shuttle Color Option*)
		Shuttle : tpCoreShuttleOptionTyp; (*Shuttle Option*)
		Segments : tpCoreSegmentsOptionTyp; (*Segment Status Option*)
	END_STRUCT;
	tpCoreShuttleOptionTyp : 	STRUCT  (*Shuttle Option*)
		Enabled : BOOL; (*Option is enabled*)
	END_STRUCT;
	tpCoreSegmentsOptionTyp : 	STRUCT  (*Segments Option*)
		Enabled : BOOL; (*Option is enabled*)
		Segments : REFERENCE TO tpCoreSegmentTyp; (*Address of the Segments Array*)
		SegmentCount : USINT; (*Count of the segments in the layout*)
		SegmentStyles : tpCoreSegmentStylesTyp;
	END_STRUCT;
	tpCoreColorOptionTyp : 	STRUCT  (*Shuttle Color Option*)
		Enabled : BOOL; (*Option is enabled*)
		Offsets : tpCoreColorOffsetsTyp; (*Userdata color offsets*)
	END_STRUCT;
	tpCoreColorOffsetsTyp : 	STRUCT  (*Userdata color offsets*)
		Red : UDINT; (*Offset for UserData address for the Red color in USINT*)
		Green : UDINT; (*Offset for UserData address for the Green color in USINT*)
		Blue : UDINT; (*Offset for UserData address for the Blue color in USINT*)
	END_STRUCT;
	tpCoreSegmentTyp : 	STRUCT 
		SegmentLink : McSegmentType; (*Global segment address*)
		SegmentId : STRING[32]; (*ID of the segment in the SVG*)
		Status : tpCoreSegmentStatusTyp; (*Status Information for the segment*)
	END_STRUCT;
	tpCoreSegmentStatusTyp : 	STRUCT 
		CommunicationReady : BOOL; (*Communication ready on the segment*)
		ReadyForPowerOn : BOOL; (*Segment is ready for power on*)
		PowerOn : BOOL; (*Segment is powered*)
		StartupCount : UDINT; (*Number of startups on the segment*)
		CommunicationState : McCommunicationStateEnum; (*Communication state of the segment*)
		SegmentDisabled : BOOL; (*Segment is disabled*)
		SegmentReady : BOOL; (*Segment is Ready*)
		SegmentStopping : BOOL; (*Segment is in the Stopping State*)
		SegmentErrorStop : BOOL; (*Segment is in an error stop state*)
		ErrorCode : UINT; (*Error code of the segment*)
		DCBus : SegStatusDCBus_typ;
		Temp : SegStatusTemp_typ;
	END_STRUCT;
	tpCoreSegmentStylesTyp : 	STRUCT  (*Sytles to use in the SVG for the segment's status*)
		SegOkay : USINT; (*Segment is okay style*)
		SegError : USINT; (*Segment is in error style*)
		SegDefault : USINT; (*Segment default style*)
		SegWarning : USINT; (*Segment is in a warning state style*)
	END_STRUCT;
END_TYPE

(*Track Master Shuttle Control Types*)

TYPE
	tpShuttleControlParsTyp : 	STRUCT  (*Input parameters for Shuttle Control*)
		Position : LREAL; (*Destination position for Absolute and Velocity commands*)
		Distance : LREAL; (*Distance for all relative commands*)
		Vel : REAL; (*Comanded Movement velocity*)
		Accel : REAL; (*Comanded Movement acceleration*)
		Decel : REAL; (*Comanded Movement deceleration*)
	END_STRUCT;
	tpShuttleControlInternalTyp : 	STRUCT  (*Internal data type*)
		State : tpShuttleControlStatesEnum; (*State of execution*)
		CoreInt : REFERENCE TO tpCoreInternalTyp; (*Internal data for the Core function block*)
		CurrentAxis : McAxisType; (*Current selected Axis*)
		Fbs : tpShuttleControlFbTyp; (*Internal function blocks*)
		Idx : USINT; (*Selected Index for the axis lookup table*)
		LastIdx : USINT; (*Last cycle selected index for the axis lookup table*)
	END_STRUCT;
	tpShuttleControlFbTyp : 	STRUCT  (*Internal Function Blocks*)
		ShGetInfo : MC_BR_ShReadInfo_AcpTrak; (*Shuttle Get info*)
		ElMoveAbs : MC_BR_ElasticMoveAbs_AcpTrak; (*Elastic move absolute command*)
		ElMoveAdd : MC_BR_ElasticMoveAdd_AcpTrak; (*Elastic move addtive command*)
	END_STRUCT;
	tpShuttleControlErrorEnum : 
		( (*Error enumeration*)
		tpSH_CONTROL_ERR_OK := 0, (*No error currently*)
		tpSH_CONTROL_WARN_SH_NOT_AVAIL := -52000, (*Shuttle Currently not listed as available*)
		tpSH_CONTROL_WARN_NO_ELEM_FND := -52001, (*Input selected element did not return a shuttle*)
		tpSH_CONTROL_ERR_INVALID_HANDLE := -62000, (*Invalid input handle*)
		tpSH_CONTROL_ERR_EL_MOVE := -62001 (*Error in an elastic movment*)
		);
	tpShuttleControlStatesEnum : 
		( (*State of execution*)
		tpSH_CONTROL_OFF, (*Off State*)
		tpSH_CONTROL_INIT, (*Init/Waiting for valid ShElement state*)
		tpSH_CONTROL_IDLE, (*Idle waiting for a command state*)
		tpSH_CONTROL_EL_MOVE_ABS, (*Move Elastic absoulte active state*)
		tpSH_CONTROL_EL_MOVE_ADD, (*Move Elastic Additive active state*)
		tpSH_CONTROL_MOVE_DONE, (*Move has completed*)
		tpSH_CONTROL_ERROR (*Error present on the FB*)
		);
END_TYPE

(*Temporary Segment information*)

TYPE
	SegStatusTemp_typ : 	STRUCT 
		TemperatureCON : REAL; (*monitor temperature CON*)
		TemperaturePROZ : REAL; (*monitor temperature PROZ*)
		TemperatureAIR : REAL; (*monitor temperature AIR*)
		TemperatureBAL : REAL; (*monitor temperature BAL*)
		TemperatureCHASSIS_1 : REAL; (*monitor temperature CHASSIS_1*)
		TemperatureCHASSIS_2 : REAL; (*monitor temperature CHASSIS_2*)
		TemperatureCHASSIS_3 : REAL; (*monitor temperature CHASSIS_3*)
		TemperaturePOWER_SENS3 : REAL; (*monitor temperature POWER_SENS3*)
		TemperaturePOWER_SENS4 : REAL; (*monitor temperature POWER_SENS4*)
		TemperaturePOWER_SENS5 : REAL; (*monitor temperature POWER_SENS5*)
		TemperaturePOWER_SENS6 : REAL; (*monitor temperature POWER_SENS6*)
		TemperaturePOWER_SENS7 : REAL; (*monitor temperature POWER_SENS7*)
		TemperaturePOWER_SENS8 : REAL; (*monitor temperature POWER_SENS8*)
		TemperaturePOWER_SENS9 : REAL; (*monitor temperature POWER_SENS9*)
		TemperaturePOWER_SENS10 : REAL; (*monitor temperature POWER_SENS10*)
		TemperaturePOWER_SENS11 : REAL; (*monitor temperature POWER_SENS11*)
	END_STRUCT;
	SegStatusDCBus_typ : 	STRUCT 
		DCBusVoltage : REAL;
		DCBusVoltageMax : REAL;
		DCBusVoltageMin : REAL;
	END_STRUCT;
END_TYPE
