TYPE
	McASMTrkSegType : STRUCT (*Segments which define the track*)
		SegmentReference : McCfgUnboundedArrayType; (*Name of the referenced segment component*)
	END_STRUCT;
	McASMTrkPosEnum :
		( (*Position selector setting*)
		mcASMTP_ABS := 0, (*Absolute - Absolute position in the workspace*)
		mcASMTP_REL_TO_ONE_SEG := 1, (*Relative to one segment - Position relative to one segment*)
		mcASMTP_REL_TO_TWO_SEG := 2 (*Relative to two segments - Position relative to two segments*)
		);
	McASMTrkPosAbsSegCntDirEnum :
		( (*Count direction of the track in the workspace*)
		mcASMTPASCD_RIGHT_TO_LFT := 0, (*Right to left - Positive count direction is from the right to the left side*)
		mcASMTPASCD_LFT_TO_RIGHT := 1 (*Left to right - Positive count direction is from the left to the right side*)
		);
	McASMSegPosRelToEnum :
		( (*Absolute position from which the position is counted*)
		mcASMSPRT_ST_OF_SEG := 0, (*Start of segment - Positive from start of segment*)
		mcASMSPRT_END_OF_SEG := 1 (*End of segment - Negative from end of segment*)
		);
	McASMTrkPosAbsType : STRUCT (*Type mcASMTP_ABS settings*)
		SegmentReference : STRING[250]; (*Name of the referenced segment component*)
		SegmentCountDirection : McASMTrkPosAbsSegCntDirEnum; (*Count direction of the track in the workspace*)
		Position : LREAL; (*Position on the segment [Measurement units]*)
		PositionRelativeTo : McASMSegPosRelToEnum; (*Absolute position from which the position is counted*)
		Translation : McCfgTransXYZType; (*Translation parameters*)
		Orientation : McCfgOrientType; (*Orientation parameters*)
	END_STRUCT;
	McASMSegType : STRUCT (*Segment of the new track*)
		SegmentReference : STRING[250]; (*Name of the referenced segment component*)
		Position : LREAL; (*Position on the segment [Measurement units]*)
		PositionRelativeTo : McASMSegPosRelToEnum; (*Absolute position from which the position is counted*)
	END_STRUCT;
	McASMTrkPosRelOneType : STRUCT (*Type mcASMTP_REL_TO_ONE_SEG settings*)
		SegmentTrack : McASMSegType; (*Segment of the new track*)
		SegmentExistingTrack : McASMSegType; (*The new track is relative to this segment*)
	END_STRUCT;
	McASMTrkPosRelTwoAlignType : STRUCT (*Alignment of the new track to the first segment*)
		SegmentRefTrack : STRING[250]; (*Name of the referenced segment component*)
		SegmentRefExistingTrack : STRING[250]; (*Name of the referenced segment component*)
	END_STRUCT;
	McASMTrkPosRelTwoType : STRUCT (*Type mcASMTP_REL_TO_TWO_SEG settings*)
		AlignmentFirst : McASMTrkPosRelTwoAlignType; (*Alignment of the new track to the first segment*)
		AlignmentSecond : McASMTrkPosRelTwoAlignType; (*Alignment of the new track to the second segment*)
	END_STRUCT;
	McASMTrkPosType : STRUCT (*Position of the track in the workspace*)
		Type : McASMTrkPosEnum; (*Position selector setting*)
		Absolute : McASMTrkPosAbsType; (*Type mcASMTP_ABS settings*)
		RelativeToOneSegment : McASMTrkPosRelOneType; (*Type mcASMTP_REL_TO_ONE_SEG settings*)
		RelativeToTwoSegments : McASMTrkPosRelTwoType; (*Type mcASMTP_REL_TO_TWO_SEG settings*)
	END_STRUCT;
	McASMTrkType : STRUCT (*Track definition*)
		Segments : McASMTrkSegType; (*Segments which define the track*)
		Position : McASMTrkPosType; (*Position of the track in the workspace*)
	END_STRUCT;
	McASMTrksType : STRUCT (*Settings for all tracks that define the assembly*)
		TrackSeparation : LREAL; (*Gap between the stator surfaces of opposite tracks [Measurement units]*)
		Track : McCfgUnboundedArrayType; (*Track definition*)
	END_STRUCT;
	McASMCSSActSegSimOnPLCEnum :
		( (*All segments of the assembly are simulated on the PLC*)
		mcASMCSSASSOP_OFF := 0, (*Off - The segments are not simulated on the PLC*)
		mcASMCSSASSOP_ON := 1 (*On - The segments are simulated on the PLC*)
		);
	McASMCSSStopReacEnum :
		( (*Stop reaction selector setting*)
		mcASMCSSSR_INDUCT_HALT := 0, (*Induction halt - Shuttle stop by setting current in all segment coils*)
		mcASMCSSSR_COAST_TO_STANDSTILL := 1 (*Coast to standstill - Shuttle stop by reseting current in all segment coils - stop by friction*)
		);
	McASMCSSStopReacType : STRUCT (*Reaction in case of certain stop conditions*)
		Type : McASMCSSStopReacEnum; (*Stop reaction selector setting*)
	END_STRUCT;
	McASMCSSSpdFltrEnum :
		( (*Speed filter selector setting*)
		mcASMCSSSF_NOT_USE := 0, (*Not used - Speed filter disabled*)
		mcASMCSSSF_LP_1ST_ORD := 1 (*Lowpass 1st order - Lowpass 1st order speed filter*)
		);
	McASMCSSSpdFltrLP1stOrdType : STRUCT (*Type mcASMCSSSF_LP_1ST_ORD settings*)
		FilterTime : REAL; (*Filter time constant [s]*)
	END_STRUCT;
	McASMCSSSpdFltrType : STRUCT (*Filter for actual speed calculation*)
		Type : McASMCSSSpdFltrEnum; (*Speed filter selector setting*)
		Lowpass1stOrder : McASMCSSSpdFltrLP1stOrdType; (*Type mcASMCSSSF_LP_1ST_ORD settings*)
	END_STRUCT;
	McASMCSSCtrlSetPosType : STRUCT (*Position controller parameters*)
		ProportionalGain : REAL; (*Proportional amplification [1/s]*)
	END_STRUCT;
	McASMCSSCtrlSetSpdType : STRUCT (*Speed controller parameters*)
		ProportionalGain : REAL; (*Proportional amplification [N s/m]*)
		IntegrationTime : REAL; (*Integral action time [s]*)
	END_STRUCT;
	McASMCSSCtrlSetFFwdType : STRUCT (*Force feed forward controller parameters*)
		TotalMass : REAL; (*Total mass [kg]*)
		ForcePositive : REAL; (*Force in positive direction [N]*)
		ForceNegative : REAL; (*Force in negative direction [N]*)
		SpeedForceFactor : REAL; (*Speed force factor [N s/m]*)
		ForceLoad : REAL; (*External load [N]*)
	END_STRUCT;
	McASMCSSCtrlSetType : STRUCT (*Axis controller parameters*)
		Position : McASMCSSCtrlSetPosType; (*Position controller parameters*)
		Speed : McASMCSSCtrlSetSpdType; (*Speed controller parameters*)
		FeedForward : McASMCSSCtrlSetFFwdType; (*Force feed forward controller parameters*)
	END_STRUCT;
	McASMCSSMoveErrLimType : STRUCT (*Limit values which lead to a stop reaction in case they are exceeded*)
		PositionError : LREAL; (*Lag error limit for stop of a movement [Measurement units]*)
		VelocityError : LREAL; (*Velocity lag error limit for stop of a movement [Measurement units/s]*)
	END_STRUCT;
	McASMCSSCPDPSType : STRUCT (*Parameter set 0*)
		Controller : McASMCSSCtrlSetType; (*Axis controller parameters*)
		MovementErrorLimits : McASMCSSMoveErrLimType; (*Limit values which lead to a stop reaction in case they are exceeded*)
	END_STRUCT;
	McASMCSSCPAPSEnum :
		( (*Additional parameter sets selector setting*)
		mcASMCSSCPAPS_NOT_USE := 0, (*Not used - Additional parameter sets are not used*)
		mcASMCSSCPAPS_USE := 1 (*Used - Additional parameter sets are used*)
		);
	McASMCSSCPAPSUseParSetCtrlEnum :
		( (*Controller selector setting*)
		mcASMCSSCPAPSUPSC_USE_DEF_VAL := 0, (*Use default values - Use the values from the default parameter set*)
		mcASMCSSCPAPSUPSC_USE_EXP_VAL := 1 (*Use explicit values - Define values for this parameter set*)
		);
	McASMCSSCPAPSUseParSetCtrlType : STRUCT (*Axis controller parameters*)
		Type : McASMCSSCPAPSUseParSetCtrlEnum; (*Controller selector setting*)
		UseExplicitValues : McASMCSSCtrlSetType; (*Type mcASMCSSCPAPSUPSC_USE_EXP_VAL settings*)
	END_STRUCT;
	McASMCSSCPAPSUPSMoveErrLimEnum :
		( (*Movement error limits selector setting*)
		mcASMCSSCPAPSUPSMEL_USE_DEF_VAL := 0, (*Use default values - Use the values from the default parameter set*)
		mcASMCSSCPAPSUPSMEL_USE_EXP_VAL := 1 (*Use explicit values - Define values for this parameter set*)
		);
	McASMCSSCPAPSUPSMoveErrLimType : STRUCT (*Limit values which lead to a stop reaction in case they are exceeded*)
		Type : McASMCSSCPAPSUPSMoveErrLimEnum; (*Movement error limits selector setting*)
		UseExplicitValues : McASMCSSMoveErrLimType; (*Type mcASMCSSCPAPSUPSMEL_USE_EXP_VAL settings*)
	END_STRUCT;
	McASMCSSCPAPSUseParSetType : STRUCT (*Additional parameter set*)
		Controller : McASMCSSCPAPSUseParSetCtrlType; (*Axis controller parameters*)
		MovementErrorLimits : McASMCSSCPAPSUPSMoveErrLimType; (*Limit values which lead to a stop reaction in case they are exceeded*)
	END_STRUCT;
	McASMCSSCPAPSUseType : STRUCT (*Type mcASMCSSCPAPS_USE settings*)
		ParameterSet : McCfgUnboundedArrayType; (*Additional parameter set*)
	END_STRUCT;
	McASMCSSCPAPSType : STRUCT (*Enable additional parameter sets that can be switched during runtime*)
		Type : McASMCSSCPAPSEnum; (*Additional parameter sets selector setting*)
		Used : McASMCSSCPAPSUseType; (*Type mcASMCSSCPAPS_USE settings*)
	END_STRUCT;
	McASMCSSCtrlParType : STRUCT (*Segment controller parameters*)
		DefaultParameterSet : McASMCSSCPDPSType; (*Parameter set 0*)
		AdditionalParameterSets : McASMCSSCPAPSType; (*Enable additional parameter sets that can be switched during runtime*)
	END_STRUCT;
	McASMCSSScpErrReacEnum :
		( (*Setting for the minimal error reaction scope with segment errors*)
		mcASMCSSSER_ASM := 0, (*Assembly - Error reaction triggered for the whole assembly*)
		mcASMCSSSER_SEG := 1 (*Segment - Error reaction triggered for the faulty segment, if type of error permits that*)
		);
	McASMCSSType : STRUCT (*Common settings for all segments in the assembly*)
		ActivateSegmentSimulationOnPLC : McASMCSSActSegSimOnPLCEnum; (*All segments of the assembly are simulated on the PLC*)
		StopReaction : McASMCSSStopReacType; (*Reaction in case of certain stop conditions*)
		SpeedFilter : McASMCSSSpdFltrType; (*Filter for actual speed calculation*)
		ControllerParameters : McASMCSSCtrlParType; (*Segment controller parameters*)
		ScopeErrorReaction : McASMCSSScpErrReacEnum; (*Setting for the minimal error reaction scope with segment errors*)
		ShuttleIdentificationTime : UINT; (*Time period in which the identification of the shuttles must take place during power-on [s]*)
	END_STRUCT;
	McASMShDistResType : STRUCT (*Parameter setting for shuttle distance reserves*)
		CollisionAvoidance : LREAL; (*Safety distance which is added to the distance a shuttle has to keep to obstacles [Measurement units]*)
		ErrorStopAvoidance : LREAL; (*Additional safety distance between shuttles in order to avoid error stops [Measurement units]*)
	END_STRUCT;
	McASMShShSttType : STRUCT (*Parameter settings for the shuttles*)
		ShuttleStereotypeReference : McCfgUnboundedArrayType; (*Name of the shuttle stereotype reference*)
	END_STRUCT;
	McASMShMagnPltCfgShTypEnum :
		( (*Shuttle type 1-1 selector setting*)
		mcASMSMPCST_ST8F1SA100 := 0, (*ST8F1SA100 - 5 magnet poles on both sides of the shuttle*)
		mcASMSMPCST_ST8F1SA102 := 1, (*ST8F1SA102 - 5 magnet poles on one side of the shuttle*)
		mcASMSMPCST_ST8F1SA104 := 2, (*ST8F1SA104 - 5 magnet poles skewed on both sides of the shuttle*)
		mcASMSMPCST_ST8F1SA106 := 3, (*ST8F1SA106 - 5 magnet poles skewed on one side of the shuttle*)
		mcASMSMPCST_ST8F1SA201 := 4, (*ST8F1SA201 - 10 magnet poles on both sides of the shuttle*)
		mcASMSMPCST_ST8F1SA203 := 5, (*ST8F1SA203 - 10 magnet poles on one side of the shuttle*)
		mcASMSMPCST_ST8F1SB308 := 6 (*ST8F1SB308 - 21 magnet poles on one side of the shuttle*)
		);
	McASMShMagnPltCfgShTypType : STRUCT (*Parameters of the magnet plate*)
		Type : McASMShMagnPltCfgShTypEnum; (*Shuttle type 1-1 selector setting*)
	END_STRUCT;
	McASMShMagnPltCfgType : STRUCT (*Parameter settings for the magnet plates*)
		ShuttleType : McCfgUnboundedArrayType; (*Parameters of the magnet plate*)
	END_STRUCT;
	McASMShColAvStratEnum :
		( (*Strategy selector setting*)
		mcASMSCAS_CONST := 0, (*Constant - Constant minimal distance between shuttles*)
		mcASMSCAS_VAR := 1, (*Variable - Variable minimal distance between shuttles*)
		mcASMSCAS_ADV_CONST := 2, (*Advanced constant - Optimized constant minimal distance between shuttles*)
		mcASMSCAS_ADV_VAR := 3 (*Advanced variable - Optimized variable minimal distance between shuttles*)
		);
	McASMShColAvStratType : STRUCT (*Type of active collision avoidance*)
		Type : McASMShColAvStratEnum; (*Strategy selector setting*)
	END_STRUCT;
	McASMShColAvMaxMdlDimLenType : STRUCT (*Length of the shuttle model*)
		ExtentToFront : LREAL; (*Extent from the center point of the magnet plate to the front of the shuttle [Measurement units]*)
		ExtentToBack : LREAL; (*Extent from the center point of the magnet plate to the back of the shuttle [Measurement units]*)
	END_STRUCT;
	McASMShColAvMaxMdlDimWidType : STRUCT (*Width of the shuttle model*)
		Width : LREAL; (*Total symmetric width of shuttle and product relative to shuttle center point [Measurement units]*)
	END_STRUCT;
	McASMShColAvMaxMdlDimType : STRUCT (*Maximum model dimensions for calculating the diverters*)
		Length : McASMShColAvMaxMdlDimLenType; (*Length of the shuttle model*)
		Width : McASMShColAvMaxMdlDimWidType; (*Width of the shuttle model*)
	END_STRUCT;
	McASMShColAvType : STRUCT (*Parameter settings for the collision avoidance*)
		Strategy : McASMShColAvStratType; (*Type of active collision avoidance*)
		MaximumModelDimensions : McASMShColAvMaxMdlDimType; (*Maximum model dimensions for calculating the diverters*)
	END_STRUCT;
	McASMShType : STRUCT (*Settings for the shuttles*)
		MaximumCount : UINT; (*Maximum count of shuttles in the assembly*)
		DistanceReserves : McASMShDistResType; (*Parameter setting for shuttle distance reserves*)
		ShuttleStereotypes : McASMShShSttType; (*Parameter settings for the shuttles*)
		MagnetPlateConfigurations : McASMShMagnPltCfgType; (*Parameter settings for the magnet plates*)
		CollisionAvoidance : McASMShColAvType; (*Parameter settings for the collision avoidance*)
	END_STRUCT;
	McASMAsmFeatType : STRUCT (*Features for an assembly*)
		AssemblyFeatureReference : McCfgUnboundedArrayType; (*Name of the assembly feature reference*)
	END_STRUCT;
	McASMVisProcTskCEnum :
		( (*Cyclic task class for command processing*)
		mcASMVPTC_CYC_1 := 1, (*Cyclic #1 - Task class 1*)
		mcASMVPTC_CYC_2 := 2, (*Cyclic #2 - Task class 2*)
		mcASMVPTC_CYC_3 := 3, (*Cyclic #3 - Task class 3*)
		mcASMVPTC_CYC_4 := 4, (*Cyclic #4 - Task class 4*)
		mcASMVPTC_CYC_5 := 5, (*Cyclic #5 - Task class 5*)
		mcASMVPTC_CYC_6 := 6, (*Cyclic #6 - Task class 6*)
		mcASMVPTC_CYC_7 := 7, (*Cyclic #7 - Task class 7*)
		mcASMVPTC_CYC_8 := 8 (*Cyclic #8 - Task class 8*)
		);
	McASMVisType : STRUCT (*Defines for connecting to visualization*)
		MonitoringPV : STRING[250]; (*Name of the process variable of type McAcpTrakAssemblyMonData*)
		ProcessingTaskClass : McASMVisProcTskCEnum; (*Cyclic task class for command processing*)
	END_STRUCT;
	McCfgAsmType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM*)
		Tracks : McASMTrksType; (*Settings for all tracks that define the assembly*)
		CommonSegmentSettings : McASMCSSType; (*Common settings for all segments in the assembly*)
		Shuttles : McASMShType; (*Settings for the shuttles*)
		AssemblyFeatures : McASMAsmFeatType; (*Features for an assembly*)
		Visualization : McASMVisType; (*Defines for connecting to visualization*)
	END_STRUCT;
	McAFCCplgObjType : STRUCT (*Coupling object*)
		Name : STRING[250]; (*Name of the coupling object*)
		ShuttleCount : UINT; (*Maximum number of simultaneously coupled shuttles*)
		CamAutomatReference : McCfgReferenceType; (*Name of the axis feature reference*)
		CamListReference : McCfgReferenceType; (*Name of the cam list reference*)
	END_STRUCT;
	McCfgAsmFeatCplgType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_CPLG*)
		CouplingObject : McCfgUnboundedArrayType; (*Coupling object*)
	END_STRUCT;
	McAFSSDShOnSecOrientEnum :
		( (*Orientation of the shuttle*)
		mcAFSSDSOSO_POS := 0, (*Positive - Same orientation as sector*)
		mcAFSSDSOSO_NEG := 1 (*Negative - Opposite orientation to the sector*)
		);
	McAFSSDShOnSecDefEnum :
		( (*Definition selector setting*)
		mcAFSSDSOSD_SNG_SH := 0, (*Single shuttle - Definition of shuttles separately*)
		mcAFSSDSOSD_SET_OF_SH := 1 (*Set of shuttles - Definition of the whole shuttle set*)
		);
	McAFSSDShOnSecDefSngShType : STRUCT (*Type mcAFSSDSOSD_SNG_SH settings*)
		Position : McCfgUnboundedArrayType; (*Position on the sector [Measurement units]*)
	END_STRUCT;
	McAFSSDShOnSecDefSetOfShType : STRUCT (*Type mcAFSSDSOSD_SET_OF_SH settings*)
		StartPosition : LREAL; (*Position of the first shuttle on the sector [Measurement units]*)
		NumberOfShuttles : USINT; (*Number of shuttles on the sector [Measurement units]*)
		DistanceBetweenShuttles : LREAL; (*Distance between consecutive shuttles [Measurement units]*)
	END_STRUCT;
	McAFSSDShOnSecDefType : STRUCT (*Type of shuttle definition*)
		Type : McAFSSDShOnSecDefEnum; (*Definition selector setting*)
		SingleShuttle : McAFSSDShOnSecDefSngShType; (*Type mcAFSSDSOSD_SNG_SH settings*)
		SetOfShuttles : McAFSSDShOnSecDefSetOfShType; (*Type mcAFSSDSOSD_SET_OF_SH settings*)
	END_STRUCT;
	McAFSSDShOnSecType : STRUCT (*Shuttle to be initialized*)
		SectorReference : McCfgReferenceType; (*Name of the referenced sector component*)
		Orientation : McAFSSDShOnSecOrientEnum; (*Orientation of the shuttle*)
		Definition : McAFSSDShOnSecDefType; (*Type of shuttle definition*)
	END_STRUCT;
	McCfgAsmFeatSimShDefType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_SIM_SH_DEF*)
		ShuttleOnSector : McCfgUnboundedArrayType; (*Shuttle to be initialized*)
	END_STRUCT;
	McAFSTShTrcCfgSecRstEnum :
		( (*Sector restricted*)
		mcAFSTSTCSR_ON := 0, (*On - Sector restricted on*)
		mcAFSTSTCSR_OFF := 1 (*Off - Sector restricted off*)
		);
	McAFSTShTrcCfgType : STRUCT (*Shuttle trace configuration*)
		ShuttleCount : UINT; (*Maximum number of simultaneously traced shuttles*)
		SectorReference : McCfgReferenceType; (*Name of the sector reference*)
		SectorRestricted : McAFSTShTrcCfgSecRstEnum; (*Sector restricted*)
	END_STRUCT;
	McCfgAsmFeatShTraceType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_SH_TRACE*)
		ShuttleTraceConfiguration : McAFSTShTrcCfgType; (*Shuttle trace configuration*)
	END_STRUCT;
	McAFSAAPrioOrientEnum :
		( (*Orientation of the shuttle*)
		mcAFSAAPO_KEEP_SEG_ORIENT := 0, (*Keep segment orientation - Keep currently assigned orientation*)
		mcAFSAAPO_POS := 1, (*Positive - Same orientation as sector*)
		mcAFSAAPO_NEG := 2 (*Negative - Opposite orientation to the sector*)
		);
	McAFSAAPrioType : STRUCT (*Sector priority definition for the shuttle auto attachment*)
		SectorReference : McCfgReferenceType; (*Name of the referenced sector component*)
		Orientation : McAFSAAPrioOrientEnum; (*Orientation of the shuttle*)
	END_STRUCT;
	McCfgAsmFeatShAutAttType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_SH_AUT_ATT*)
		Priority : McCfgUnboundedArrayType; (*Sector priority definition for the shuttle auto attachment*)
	END_STRUCT;
	McAFLLScpEnum :
		( (*Scope selector setting*)
		mcAFLLS_ALL_SH := 0, (*All shuttles - Applies to all shuttles, not changeable*)
		mcAFLLS_SNG_SH := 1 (*Single shuttles - Applies only to shuttles which are defined*)
		);
	McAFLLScpSngShType : STRUCT (*Type mcAFLLS_SNG_SH settings*)
		LocalLimitName : STRING[250]; (*Local limit name to use for MC_BR_ShLocalLimitCmd_AcpTrak*)
	END_STRUCT;
	McAFLLScpType : STRUCT (*Defines for which shuttles the local limit applies*)
		Type : McAFLLScpEnum; (*Scope selector setting*)
		SingleShuttles : McAFLLScpSngShType; (*Type mcAFLLS_SNG_SH settings*)
	END_STRUCT;
	McAFLLLocEnum :
		( (*Location selector setting*)
		mcAFLLL_SEC := 0, (*Sector - Location defined by a sector*)
		mcAFLLL_CRV_AREA := 1, (*Curved area - Local limit in all curved areas*)
		mcAFLLL_DUALTRK_AREA := 2 (*Dual-track area - Local limit in all dual-track areas*)
		);
	McAFLLLocSecType : STRUCT (*Type mcAFLLL_SEC settings*)
		SectorReference : McCfgReferenceType; (*Name of the referenced sector component*)
	END_STRUCT;
	McAFLLLocCrvAreaType : STRUCT (*Type mcAFLLL_CRV_AREA settings*)
		CurvatureThreshold : REAL; (*Curvature from which the local limit is valid. Value given in the reciprocal of the radius of curvature. [1/m]*)
	END_STRUCT;
	McAFLLLocType : STRUCT (*Defines the location of the local limit*)
		Type : McAFLLLocEnum; (*Location selector setting*)
		Sector : McAFLLLocSecType; (*Type mcAFLLL_SEC settings*)
		CurvedArea : McAFLLLocCrvAreaType; (*Type mcAFLLL_CRV_AREA settings*)
	END_STRUCT;
	McAFLLMotLimVelEnum :
		( (*Velocity selector setting*)
		mcAFLLMLV_NOT_USE := 0, (*Not used - Velocity limit not used*)
		mcAFLLMLV_BASIC := 1, (*Basic -*)
		mcAFLLMLV_ADV := 2 (*Advanced -*)
		);
	McAFLLMotLimVelBasicType : STRUCT (*Type mcAFLLMLV_BASIC settings*)
		Velocity : REAL; (*Velocity limit in any movement direction [Measurement units/s]*)
	END_STRUCT;
	McAFLLMotLimVelType : STRUCT (*Limit the velocity*)
		Type : McAFLLMotLimVelEnum; (*Velocity selector setting*)
		Basic : McAFLLMotLimVelBasicType; (*Type mcAFLLMLV_BASIC settings*)
	END_STRUCT;
	McAFLLMotLimAccEnum :
		( (*Acceleration selector setting*)
		mcAFLLMLA_NOT_USE := 0, (*Not used - Acceleration limit not used*)
		mcAFLLMLA_BASIC := 1, (*Basic -*)
		mcAFLLMLA_ADV := 2 (*Advanced -*)
		);
	McAFLLMotLimAccBasicType : STRUCT (*Type mcAFLLMLA_BASIC settings*)
		Acceleration : REAL; (*Acceleration limit in any movement direction [Measurement units/s²]*)
	END_STRUCT;
	McAFLLMotLimAccType : STRUCT (*Limit the acceleration*)
		Type : McAFLLMotLimAccEnum; (*Acceleration selector setting*)
		Basic : McAFLLMotLimAccBasicType; (*Type mcAFLLMLA_BASIC settings*)
	END_STRUCT;
	McAFLLMotLimType : STRUCT (*Limits which are effective*)
		Velocity : McAFLLMotLimVelType; (*Limit the velocity*)
		Acceleration : McAFLLMotLimAccType; (*Limit the acceleration*)
	END_STRUCT;
	McAFLLType : STRUCT (*Local limit definition*)
		Scope : McAFLLScpType; (*Defines for which shuttles the local limit applies*)
		Location : McAFLLLocType; (*Defines the location of the local limit*)
		MotionLimits : McAFLLMotLimType; (*Limits which are effective*)
	END_STRUCT;
	McCfgAsmFeatLocLimType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_LOC_LIM*)
		LocalLimit : McCfgUnboundedArrayType; (*Local limit definition*)
	END_STRUCT;
	McAFESExFromEnum :
		( (*Exclusion from selector setting*)
		mcAFESEF_ASM_PWR_ON := 0 (*Assembly power on - Exclude segments from assembly power on*)
		);
	McAFESExFromAsmPwrOnType : STRUCT (*Type mcAFESEF_ASM_PWR_ON settings*)
		SegmentReference : McCfgUnboundedArrayType; (*Name of the referenced segment component*)
	END_STRUCT;
	McAFESExFromType : STRUCT (*Scope of exclusion*)
		Type : McAFESExFromEnum; (*Exclusion from selector setting*)
		AssemblyPowerOn : McAFESExFromAsmPwrOnType; (*Type mcAFESEF_ASM_PWR_ON settings*)
	END_STRUCT;
	McCfgAsmFeatExSegType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_EX_SEG*)
		ExclusionFrom : McAFESExFromType; (*Scope of exclusion*)
	END_STRUCT;
	McAFSSRSetLenType : STRUCT (*Length of the shuttle model*)
		ExtentToFront : LREAL; (*Extent from the center point of the magnet plate to the front of the shuttle [Measurement units]*)
		ExtentToBack : LREAL; (*Extent from the center point of the magnet plate to the back of the shuttle [Measurement units]*)
	END_STRUCT;
	McAFSSRSetWidType : STRUCT (*Width of the shuttle model*)
		Width : LREAL; (*Total symmetric width of shuttle and product relative to shuttle center point [Measurement units]*)
	END_STRUCT;
	McAFSSRSetType : STRUCT (*Model dimensions set*)
		Length : McAFSSRSetLenType; (*Length of the shuttle model*)
		Width : McAFSSRSetWidType; (*Width of the shuttle model*)
	END_STRUCT;
	McCfgAsmFeatShShpRegType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_ASM_FEAT_SH_SHP_REG*)
		Set : McCfgUnboundedArrayType; (*Model dimensions set*)
	END_STRUCT;
	McSCSegPosRelToEnum :
		( (*Absolute position from which the position is counted*)
		mcSCSPRT_ST_OF_SEG := 0, (*Start of segment - Positive from start of segment*)
		mcSCSPRT_END_OF_SEG := 1 (*End of segment - Negative from end of segment*)
		);
	McSCSegType : STRUCT (*Begin of the sector*)
		SegmentReference : STRING[250]; (*Name of the referenced segment component*)
		Position : LREAL; (*Position on the segment [Measurement units]*)
		PositionRelativeTo : McSCSegPosRelToEnum; (*Absolute position from which the position is counted*)
	END_STRUCT;
	McSCIntmSegType : STRUCT (*Segments between the start and the end segment*)
		SegmentReference : McCfgUnboundedArrayType; (*Name of the referenced segment component*)
	END_STRUCT;
	McCfgSecCompType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SEC_COMP*)
		StartSegment : McSCSegType; (*Begin of the sector*)
		IntermediateSegments : McSCIntmSegType; (*Segments between the start and the end segment*)
		EndSegment : McSCSegType; (*End of the sector*)
	END_STRUCT;
	McSSStPosRelToEnum :
		( (*Absolute position from which the position is counted*)
		mcSSSPRT_ST_OF_SEC := 0, (*Start of sector - Tail of the sector*)
		mcSSSPRT_END_OF_SEC := 1 (*End of sector - Head of the sector*)
		);
	McSSStType : STRUCT (*Begin of the sector*)
		Position : LREAL; (*Position on the sector [Measurement units]*)
		PositionRelativeTo : McSSStPosRelToEnum; (*Absolute position from which the position is counted*)
	END_STRUCT;
	McSSDirEnum :
		( (*Direction of the sub sector*)
		mcSSD_POS := 0, (*Positive - Same direction as sector*)
		mcSSD_NEG := 1 (*Negative - Opposite direction of sector*)
		);
	McCfgSecSubType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SEC_SUB*)
		SectorReference : McCfgReferenceType; (*Name of the referenced sector component*)
		Start : McSSStType; (*Begin of the sector*)
		Length : LREAL; (*Length of the sub sector [Measurement units]*)
		Direction : McSSDirEnum; (*Direction of the sub sector*)
	END_STRUCT;
	McSSTMeasUnitEnum :
		( (*Measurement unit for the axis*)
		mcSSTMU_M := 5067858 (*Meters*)
		);
	McSSTMoveLimEnum :
		( (*Movement limits selector setting*)
		mcSSTML_INT := 0 (*Internal - Internal definition of limits*)
		);
	McSSTMoveLimIntVelEnum :
		( (*Velocity selector setting*)
		mcSSTMLIV_BASIC := 0 (*Basic -*)
		);
	McSSTMoveLimIntVelBasicType : STRUCT (*Type mcSSTMLIV_BASIC settings*)
		Velocity : REAL; (*Velocity limit in any movement direction [Measurement units/s]*)
	END_STRUCT;
	McSSTMoveLimIntVelType : STRUCT (*Limits for the velocity of the axis*)
		Type : McSSTMoveLimIntVelEnum; (*Velocity selector setting*)
		Basic : McSSTMoveLimIntVelBasicType; (*Type mcSSTMLIV_BASIC settings*)
	END_STRUCT;
	McSSTMoveLimIntAccEnum :
		( (*Acceleration selector setting*)
		mcSSTMLIA_BASIC := 0 (*Basic -*)
		);
	McSSTMoveLimIntAccBasicType : STRUCT (*Type mcSSTMLIA_BASIC settings*)
		Acceleration : REAL; (*Acceleration limit in any movement direction [Measurement units/s²]*)
	END_STRUCT;
	McSSTMoveLimIntAccType : STRUCT (*Limits for the acceleration of the axis*)
		Type : McSSTMoveLimIntAccEnum; (*Acceleration selector setting*)
		Basic : McSSTMoveLimIntAccBasicType; (*Type mcSSTMLIA_BASIC settings*)
	END_STRUCT;
	McSSTMoveLimIntDecEnum :
		( (*Deceleration selector setting*)
		mcSSTMLID_BASIC := 0 (*Basic -*)
		);
	McSSTMoveLimIntDecBasicType : STRUCT (*Type mcSSTMLID_BASIC settings*)
		Deceleration : REAL; (*Deceleration limit in any movement direction [Measurement units/s²]*)
	END_STRUCT;
	McSSTMoveLimIntDecType : STRUCT (*Limits for the deceleration of the axis*)
		Type : McSSTMoveLimIntDecEnum; (*Deceleration selector setting*)
		Basic : McSSTMoveLimIntDecBasicType; (*Type mcSSTMLID_BASIC settings*)
	END_STRUCT;
	McSSTMoveLimIntUpdModEnum :
		( (*Setting for the mode of motion limit (acceleration and deceleration) updates*)
		mcSSTMLIUM_IMMED := 0, (*Immediately - Accept motion limits immediately*)
		mcSSTMLIUM_AVOID_ERR_STOP := 1 (*Avoid error stops - Accept motion limits as soon as error stops can be avoided*)
		);
	McSSTMoveLimIntType : STRUCT (*Type mcSSTML_INT settings*)
		Velocity : McSSTMoveLimIntVelType; (*Limits for the velocity of the axis*)
		Acceleration : McSSTMoveLimIntAccType; (*Limits for the acceleration of the axis*)
		Deceleration : McSSTMoveLimIntDecType; (*Limits for the deceleration of the axis*)
		UpdateMode : McSSTMoveLimIntUpdModEnum; (*Setting for the mode of motion limit (acceleration and deceleration) updates*)
	END_STRUCT;
	McSSTMoveLimType : STRUCT (*Various limit values that will be considered for axis movements*)
		Type : McSSTMoveLimEnum; (*Movement limits selector setting*)
		Internal : McSSTMoveLimIntType; (*Type mcSSTML_INT settings*)
	END_STRUCT;
	McSSTJerkFltrEnum :
		( (*Jerk filter selector setting*)
		mcSSTJF_USE := 0, (*Used - Jerk filter is applied*)
		mcSSTJF_NOT_USE := 1 (*Not used - No jerk filter is applied*)
		);
	McSSTJerkFltrUseType : STRUCT (*Type mcSSTJF_USE settings*)
		JerkTime : REAL; (*Jerk filter time [s]*)
	END_STRUCT;
	McSSTJerkFltrType : STRUCT (*Jerk filter*)
		Type : McSSTJerkFltrEnum; (*Jerk filter selector setting*)
		Used : McSSTJerkFltrUseType; (*Type mcSSTJF_USE settings*)
	END_STRUCT;
	McSSTUsrDatType : STRUCT (*Defines the user data*)
		Size : UINT; (*Size of the user data for one shuttle [Byte]*)
	END_STRUCT;
	McSSTCAIMDEnum :
		( (*Initial model dimensions selector setting*)
		mcSSTCAIMD_USE_MAX_DIM := 0, (*Use maximum dimensions -*)
		mcSSTCAIMD_USE_EXP_VAL := 1 (*Use explicit values -*)
		);
	McSSTCAIMDUseExpValLenType : STRUCT (*Length of the shuttle model*)
		ExtentToFront : LREAL; (*Extent from the center point of the magnet plate to the front of the shuttle [Measurement units]*)
		ExtentToBack : LREAL; (*Extent from the center point of the magnet plate to the back of the shuttle [Measurement units]*)
	END_STRUCT;
	McSSTCAIMDUseExpValWidType : STRUCT (*Width of the shuttle model*)
		Width : LREAL; (*Symmetric width relative to the shuttle center point [Measurement units]*)
	END_STRUCT;
	McSSTCAIMDUseExpValType : STRUCT (*Type mcSSTCAIMD_USE_EXP_VAL settings*)
		Length : McSSTCAIMDUseExpValLenType; (*Length of the shuttle model*)
		Width : McSSTCAIMDUseExpValWidType; (*Width of the shuttle model*)
	END_STRUCT;
	McSSTCAIMDType : STRUCT (*Initial model dimensions for a shuttle*)
		Type : McSSTCAIMDEnum; (*Initial model dimensions selector setting*)
		UseExplicitValues : McSSTCAIMDUseExpValType; (*Type mcSSTCAIMD_USE_EXP_VAL settings*)
	END_STRUCT;
	McSSTColAvType : STRUCT (*Parameter settings for the collision avoidance*)
		InitialModelDimensions : McSSTCAIMDType; (*Initial model dimensions for a shuttle*)
	END_STRUCT;
	McCfgShStereoTypType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SH_STEREO_TYP*)
		MeasurementUnit : McSSTMeasUnitEnum; (*Measurement unit for the axis*)
		MeasurementResolution : LREAL; (*Possible resolution of measurement unit that can be achieved [Measurement units]*)
		MovementLimits : McSSTMoveLimType; (*Various limit values that will be considered for axis movements*)
		JerkFilter : McSSTJerkFltrType; (*Jerk filter*)
		UserData : McSSTUsrDatType; (*Defines the user data*)
		CollisionAvoidance : McSSTColAvType; (*Parameter settings for the collision avoidance*)
	END_STRUCT;
	McSEGSegSecDirEnum :
		( (*Direction of the referenced sector component*)
		mcSEGSSD_POS := 0, (*Positive - Create the segment sector with positive direction*)
		mcSEGSSD_NEG := 1 (*Negative - Create the semgent sector with negative direction*)
		);
	McSEGElongationCompEnum :
		( (*Compensation of segment elongation due to change of temperature*)
		mcSEGEC_USE_ASM_SET := 0, (*Use assembly setting - Use the defined setting from the assembly configuration*)
		mcSEGEC_INACT := 1, (*Inactive - No compensation of segment elongation*)
		mcSEGEC_ACT := 2 (*Active - Compensation of segment elongation*)
		);
	McSEGStopReacEnum :
		( (*Stop reaction selector setting*)
		mcSEGSR_USE_ASM_SET := 0, (*Use assembly setting - Use the defined setting from the assembly configuration*)
		mcSEGSR_INDUCT_HALT := 1, (*Induction halt - Shuttle stop by setting current in all segment coils*)
		mcSEGSR_COAST_TO_STANDSTILL := 2 (*Coast to standstill - Shuttle stop by reseting current in all segment coils - stop by friction*)
		);
	McSEGStopReacType : STRUCT (*Reaction in case of certain stop conditions*)
		Type : McSEGStopReacEnum; (*Stop reaction selector setting*)
	END_STRUCT;
	McSEGSpdFltrEnum :
		( (*Speed filter selector setting*)
		mcSEGSF_USE_ASM_SET := 0, (*Use assembly setting - Use the defined setting from the assembly configuration*)
		mcSEGSF_NOT_USE := 1, (*Not used - Speed filter disabled*)
		mcSEGSF_LP_1ST_ORD := 2 (*Lowpass 1st order - Lowpass 1st order speed filter*)
		);
	McSEGSpdFltrLP1stOrdType : STRUCT (*Type mcSEGSF_LP_1ST_ORD settings*)
		FilterTime : REAL; (*Filter time constant [s]*)
	END_STRUCT;
	McSEGSpdFltrType : STRUCT (*Filter for actual speed calculation*)
		Type : McSEGSpdFltrEnum; (*Speed filter selector setting*)
		Lowpass1stOrder : McSEGSpdFltrLP1stOrdType; (*Type mcSEGSF_LP_1ST_ORD settings*)
	END_STRUCT;
	McCfgSegType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SEG*)
		SegmentReference : STRING[250]; (*Name of the referenced segment component*)
		SegmentSectorReference : STRING[250]; (*Name of the referenced sector component*)
		SegmentSectorDirection : McSEGSegSecDirEnum; (*Direction of the referenced sector component*)
		ElongationCompensation : McSEGElongationCompEnum; (*Compensation of segment elongation due to change of temperature*)
		StopReaction : McSEGStopReacType; (*Reaction in case of certain stop conditions*)
		SpeedFilter : McSEGSpdFltrType; (*Filter for actual speed calculation*)
	END_STRUCT;
END_TYPE