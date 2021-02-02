TYPE
	McAGAPhsAxAxType : STRUCT
		AxisReference : McCfgReferenceType; (*Name of the axis reference*)
	END_STRUCT;
	McAGAPhsAxType : STRUCT (*Defines the axes which a part of the axis group*)
		Axis : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGAGFType : STRUCT
		FeatureReference : McCfgUnboundedArrayType; (*Name of the axes group feature reference*)
	END_STRUCT;
	McCfgAxGrpAdminType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_ADMIN*)
		ProcessingTaskClass : McPTCEnum; (*Cyclic task class for command processing*)
		PhysicalAxes : McAGAPhsAxType; (*Defines the axes which a part of the axis group*)
		AxesGroupFeatures : McAGAGFType;
	END_STRUCT;
	McAGFHOTogGrpType : STRUCT
		AxisReference : McCfgUnboundedArrayType; (*Name of the axis reference*)
	END_STRUCT;
	McCfgAxGrpFeatHomeOrdType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_HOME_ORD*)
		TogetherGroup : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFPOOTogGrpType : STRUCT
		AxisReference : McCfgUnboundedArrayType; (*Name of the axis reference*)
	END_STRUCT;
	McCfgAxGrpFeatPwrOnOrdType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_PWR_ON_ORD*)
		TogetherGroup : McCfgUnboundedArrayType;
	END_STRUCT;
	McAGFESAGrpStopExType : STRUCT
		AxisReference : McCfgUnboundedArrayType; (*Name of the axis reference*)
	END_STRUCT;
	McAGFESAGrpOvrExType : STRUCT
		AxisReference : McCfgUnboundedArrayType; (*Name of the axis reference*)
	END_STRUCT;
	McCfgAxGrpFeatExSngAxType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_AXGRP_FEAT_EX_SNG_AX*)
		GroupStopExclusion : McAGFESAGrpStopExType;
		GroupOverrideExclusion : McAGFESAGrpOvrExType;
	END_STRUCT;
	McAGFModalDatBxEnum :
		( (*Modal data behaviour selector setting*)
		mcAGFMDB_USE_AX_GRP_SET := 0, (*Use axes group settings - The settings from the axes group are used.*)
		mcAGFMDB_RST_TO_DEF := 1, (*Reset to default - The values are reseted to the configured/default values at program end.*)
		mcAGFMDB_KEEP_CUR_VAL := 2 (*Keep current values - The values at program end are used for the next program.*)
		);
	McAGFModalDatBxType : STRUCT (*Defines the modal data behaviour of the feature.*)
		Type : McAGFModalDatBxEnum; (*Modal data behaviour selector setting*)
	END_STRUCT;
END_TYPE