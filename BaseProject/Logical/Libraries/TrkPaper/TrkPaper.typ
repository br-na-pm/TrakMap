(*Trak Master Core Types*)

TYPE
	TrkPaperCoreAxisLookupType : 	STRUCT  (*Lookup table datatype*)
		Present : BOOL; (*Axis is present and a valid reference exists*)
		Axis : McAxisType; (*Axis information*)
	END_STRUCT;
	TrkPaperCoreColorOptionType : 	STRUCT  (*Shuttle Color Option*)
		Enabled : BOOL; (*Option is enabled*)
		Offset : UDINT; (*Userdata color offsets*)
	END_STRUCT;
	TrkPaperCoreErrorEnum : 
		( (*Error Enumeration*)
		trkPAPER_CORE_ERR_OK := 0, (*No error present*)
		trkPAPER_CORE_ERR_INVALID_ASM := -61000, (*Invalid input assembly reference*)
		trkPAPER_CORE_ERR_SH_CNT_EXCD := -61001, (*Maximum shuttle count exceeded. Need to increase max shuttle count constant*)
		trkPAPER_CORE_ERR_STR_LEN_EXCD := -61002 (*The built string is too long, need to increase the maximum size to prevent page faulting*)
		);
	TrkPaperCoreInternalType : 	STRUCT  (*Internal Datatype*)
		TypeID : UDINT; (*TypeID to help with handle application*)
		State : USINT; (*State of execution*)
		Axes : ARRAY[0..trkPAPER_MAX_SHUTLE_ARRAY]OF TrkPaperCoreAxisLookupType; (*Axis Lookup table based on the current Shuttle Index*)
		Fbs : TrkPaperCoreFbTyps; (*Internal Function blocks*)
		ShCount : USINT; (*Shuttle Count*)
	END_STRUCT;
	TrkPaperCoreFbTyps : 	STRUCT  (*Internal Function blocks*)
		AsmGetShuttle : MC_BR_AsmGetShuttle_AcpTrak;
	END_STRUCT;
	TrkPaperCoreOptionsType : 	STRUCT  (*Options for Core Function Block*)
		Segment : TrkPaperCoreSegmentOptionType;
		Shuttle : TrkPaperCoreShuttleOptionType; (*Shuttle Option*)
		Color : TrkPaperCoreColorOptionType; (*Shuttle Color Option*)
	END_STRUCT;
	TrkPaperCoreSegmentOptionType : 	STRUCT  (*Shuttle Option*)
		Enabled : BOOL; (*Option is enabled*)
	END_STRUCT;
	TrkPaperCoreShuttleOptionType : 	STRUCT  (*Shuttle Option*)
		Enabled : BOOL; (*Option is enabled*)
	END_STRUCT;
	TrkPaperCoreStateEnum : 
		( (*State of execution*)
		trkPAPER_CORE_OFF, (*Waiting for enable command*)
		trkPAPER_CORE_INIT, (*Initialization state*)
		trkPAPER_CORE_GET_SH, (*Waiting for enable command*)
		trkPAPER_CORE_GET_NEXT, (*Waiting for enable command*)
		trkPAPER_CORE_RUNNING, (*Running state*)
		trkPAPER_CORE_RESET, (*Resetting state*)
		trkPAPER_CORE_ERROR (*Error state*)
		);
	TrkPaperCoreSvgLengthsType : 	STRUCT  (*String lengths of SVGs*)
		ContentLength : UDINT; (*String Length of SVG Content string*)
		TransformLength : UDINT; (*String Length of SVG Transform string*)
	END_STRUCT;
	TrkPaperCoreViewBoxCfgType : 	STRUCT  (*Attributes of the SVG's viewbox*)
		MinX : REAL; (*Minimum x position*)
		MinY : REAL; (*minimum y position*)
		Width : REAL; (*Width of viewbox*)
		Height : REAL; (*Height of viewbox*)
	END_STRUCT;
	TrkPaperSegmentStyleEnumeration : 
		( (*Style enumeration for the trak map strings*)
		trkPAPER_SEG_STYLE_DEFAULT := 0, (*Segment Default Style*)
		trkPAPER_SEG_STYLE_ERROR := 1, (*Segment is in error style*)
		trkPAPER_SEG_STYLE_OKAY := 2, (*Segment is okay style*)
		trkPAPER_SEG_STYLE_WARNING := 3 (*Segment is in a warning state style*)
		);
	TrkPaperShuttleControlErrorEnum : 
		( (*Error enumeration*)
		trkPAPER_SH_CTRL_ERR_OK := 0, (*No error currently*)
		trkPAPER_SH_CTRL_WARN_SH_NOT_AVA := -52000, (*Shuttle Currently not listed as available*)
		trkPAPER_SH_CTRL_WARN_NO_ELEM_FN := -52001, (*Input selected element did not return a shuttle*)
		trkPAPER_SH_CTRL_ERR_INVALID_HDL := -62000, (*Invalid input handle*)
		trkPAPER_SH_CTRL_ERR_EL_MOVE := -62001 (*Error in an elastic movment*)
		);
	TrkPaperShuttleControlFbType : 	STRUCT  (*Internal Function Blocks*)
		ShGetInfo : MC_BR_ShReadInfo_AcpTrak; (*Shuttle Get info*)
		ElMoveAbs : MC_BR_ElasticMoveAbs_AcpTrak; (*Elastic move absolute command*)
		ElMoveAdd : MC_BR_ElasticMoveAdd_AcpTrak; (*Elastic move addtive command*)
	END_STRUCT;
END_TYPE

(*Trak Master Shuttle Control Types*)

TYPE
	TrkPaperShuttleControlParsType : 	STRUCT  (*Input parameters for Shuttle Control*)
		Position : LREAL; (*Destination position for Absolute and Velocity commands*)
		Distance : LREAL; (*Distance for all relative commands*)
		Vel : REAL; (*Comanded Movement velocity*)
		Accel : REAL; (*Comanded Movement acceleration*)
		Decel : REAL; (*Comanded Movement deceleration*)
	END_STRUCT;
	TrkPaperShuttleControlStatesEnum : 
		( (*State of execution*)
		trkPAPER_SH_CONTROL_OFF, (*Off State*)
		trkPAPER_SH_CONTROL_INIT, (*Init/Waiting for valid ShElement state*)
		trkPAPER_SH_CONTROL_IDLE, (*Idle waiting for a command state*)
		trkPAPER_SH_CONTROL_EL_MOVE_ABS, (*Move Elastic absoulte active state*)
		trkPAPER_SH_CONTROL_EL_MOVE_ADD, (*Move Elastic Additive active state*)
		trkPAPER_SH_CONTROL_MOVE_DONE, (*Move has completed*)
		trkPAPER_SH_CONTROL_ERROR (*Error present on the FB*)
		);
	TrkPaperShuttleCtrlInternalType : 	STRUCT  (*Internal data type*)
		State : TrkPaperShuttleControlStatesEnum; (*State of execution*)
		CoreInt : REFERENCE TO TrkPaperCoreInternalType; (*Internal data for the Core function block*)
		CurrentAxis : McAxisType; (*Current selected Axis*)
		Fbs : TrkPaperShuttleControlFbType; (*Internal function blocks*)
		Idx : USINT; (*Selected Index for the axis lookup table*)
		LastIdx : USINT; (*Last cycle selected index for the axis lookup table*)
	END_STRUCT;
END_TYPE
