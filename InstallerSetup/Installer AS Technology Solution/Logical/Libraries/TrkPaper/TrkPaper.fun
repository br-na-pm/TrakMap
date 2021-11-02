
FUNCTION_BLOCK TrkPaperShuttleClickInfo
	VAR_INPUT
		Enable : BOOL; (*Enables the Function Block*)
		Handle : UDINT; (*Handle of the Core Trak Master Function Block*)
		ErrorReset : BOOL; (*Resets Error on FB*)
		Update : BOOL; (*Triggers FUB to update based on current Ident*)
		Ident : {REDUND_UNREPLICABLE} STRING[80]; (*Ident of clicked segment*)
	END_VAR
	VAR_OUTPUT
		ErrorID : TrkPaperShClickInfoErrorEnum; (*Error ID of current error*)
		Error : BOOL; (*Error present on FB*)
		Data : TrkPaperShClickInfoDataType; (*Data of Clicked Shuttle*)
		Valid : BOOL; (*Output data is valid*)
		Active : BOOL; (*Function Block is active*)
	END_VAR
	VAR
		Internal : TrkPaperShClickInfoInternalType; (*Internal Data Type*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TrkPaperSegClickInfo
	VAR_INPUT
		Enable : BOOL; (*Enables the Function Block*)
		Handle : UDINT; (*Handle of the Core Trak Master Function Block*)
		ErrorReset : BOOL; (*Resets Error on FB*)
		Update : BOOL; (*Triggers FUB to update based on current Ident*)
		Ident : {REDUND_UNREPLICABLE} STRING[80]; (*Ident of clicked segment*)
	END_VAR
	VAR_OUTPUT
		ErrorID : TrkPaperSegClickInfoErrorEnum; (*Error ID of current error*)
		Error : BOOL; (*Error present on FB*)
		Data : TrkDiagSegmentType; (*Data of Clicked Segment*)
		Valid : BOOL; (*Output data is valid*)
		Active : BOOL; (*Function Block is active*)
	END_VAR
	VAR
		Internal : TrkPaperSegClickInfoInternalType; (*Internal Data Type*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TrkPaperCore (*Core Trak Paper Function Block*)
	VAR_INPUT
		Enable : BOOL; (*Enables the core functionality*)
		ErrorRest : BOOL; (*Reset any present errors*)
		Assembly : REFERENCE TO McAssemblyType; (*Assembly reference to monitor*)
		ShuttleMon : REFERENCE TO McAcpTrakAssemblyMonData; (*Shuttle Monitor structure for the assembly*)
		Segments : REFERENCE TO TrkDiagSegmentType; (*Address of the segment list for the system*)
		SegmentCount : USINT; (*Count of the segments in the system*)
		ViewBoxCfg : TrkPaperCoreViewBoxCfgType; (*View box configuration for the SVG*)
		ReadClickID : {REDUND_UNREPLICABLE} BOOL; (*Triggers Paper Core to read current ClickID*)
		ClickID : {REDUND_UNREPLICABLE} STRING[100]; (*ClickID from Paper Widget*)
		TrakStatus : REFERENCE TO TrkDiagStatusType; (*Status of Trak*)
		Options : REFERENCE TO TrkPaperCoreOptionsType; (*Options for the core fb*)
	END_VAR
	VAR_OUTPUT
		Error : BOOL; (*Error present on FB*)
		ErrorID : TrkPaperCoreErrorEnum; (*Error ID of current error*)
		Active : BOOL; (*Function block is active*)
		SvgTransform : STRING[trkPAPER_CORE_MAX_STR_LEN]; (*SVG Transform string to tie to a paper widget*)
		SvgContent : STRING[trkPAPER_CORE_MAX_STR_LEN]; (*SVG Content string to tie to a Paper widget*)
		ClickData : TrkPaperCoreClickDataType;
		StrLengths : TrkPaperCoreSvgLengthsType; (*Diagnostic viewer to see current lengths of SVG Content/Transform*)
		Handle : UDINT; (*Handle used for other Trak Master Function Blocks*)
	END_VAR
	VAR
		Internal : TrkPaperCoreInternalType; (*Internal data type*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK TrkPaperShuttleControl (*Shuttle Control Function Block*)
	VAR_INPUT
		Enable : BOOL; (*Enables the shuttle controller*)
		Handle : UDINT; (*Handle of the Core Trak Master Function Block*)
		SelectedElem : STRING[80]; (*Selected Element String that is populated from a Paper Widget*)
		ElasticMoveAbs : BOOL; (*Command to send shuttle on Elastic Move Absolute*)
		ElasticMoveAdd : BOOL; (*Command to send shuttle on Elastic Move Additive*)
		Parameters : REFERENCE TO TrkPaperShuttleControlParsType; (*Parameters for movement commands*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Function block is currently Active*)
		MovementActive : BOOL; (*Controlled Shuttle is currently moving*)
		MovementDone : BOOL; (*Controlled Shuttle has completed movement*)
		Valid : BOOL; (*Input Selected Element is a valid controllable shuttle*)
		ShInfo : McAcpTrakShInfoType; (*Selected shuttle's current info. Only is Valid when Valid flag is set*)
		Error : BOOL; (*Error Present on FB*)
		ErrorID : DINT; (*Error ID of current Error*)
	END_VAR
	VAR
		Internal : TrkPaperShuttleCtrlInternalType; (*Internal data type*)
	END_VAR
END_FUNCTION_BLOCK
