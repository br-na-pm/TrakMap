
FUNCTION_BLOCK TrkPaperCore (*Core Trak Paper Function Block*)
	VAR_INPUT
		Enable : BOOL; (*Enables the core functionality*)
		ErrorRest : BOOL; (*Reset any present errors*)
		Segments : REFERENCE TO TrkDiagSegmentType; (*Address of the segment list for the system*)
		SegmentCount : USINT; (*Count of the segments in the system*)
		ViewBoxCfg : TrkPaperCoreViewBoxCfgType; (*View box configuration for the SVG*)
		Options : REFERENCE TO TrkPaperCoreOptionsType; (*Options for the core fb*)
	END_VAR
	VAR_OUTPUT
		Error : BOOL; (*Error present on FB*)
		ErrorID : TrkPaperCoreErrorEnum; (*Error ID of current error*)
		Active : BOOL; (*Function block is active*)
		SvgTransform : STRING[trkPAPER_CORE_MAX_STR_LEN]; (*SVG Transform string to tie to a paper widget*)
		SvgContent : STRING[trkPAPER_CORE_MAX_STR_LEN]; (*SVG Content string to tie to a Paper widget*)
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

FUNCTION_BLOCK TrkPaperShuttleFeature (*Shuttle Feature Function Block*)
END_FUNCTION_BLOCK
