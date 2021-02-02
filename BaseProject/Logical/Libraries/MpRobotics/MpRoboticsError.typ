
TYPE
	MpRoboticsErrorEnum : 
		( (* Error numbers of library MpRobotics *)
		mcROBOTICS_NO_ERROR := 0, (* No error *)
		mcROBOTICS_ERR_AXES_GROUP := -1067211008, (* Error in the axes group. (ErrorSource: {2:PLCopenFBName}, ErrorCause: {1:ErrorNumber}) [Error: 42752, 0xc063a700] *)
		mcROBOTICS_WRN_CMD_NOT_ALLOWED := -2140952831, (* {2:Command} not allowed when robot is {3:Condition} [Warning: 42753, 0x8063a701] *)
		mcROBOTICS_INF_NOT_ENOUGH_AXES := 1080272642, (* Not enough axes components found, wait until all linked axes components output Active = TRUE [Informational: 42754, 0x4063a702] *)
		mcROBOTICS_WRN_OVR_OUT_OF_RANGE := -2140952829, (* Override value {2:Value} out of expected range 0..100% [Warning: 42755, 0x8063a703] *)
		mcROBOTICS_ERR_ACTIVATION := -1064239103, (* Could not create component [Error: 1, 0xc0910001] *)
		mcROBOTICS_ERR_MPLINK_NULL := -1064239102, (* MpLink is NULL pointer [Error: 2, 0xc0910002] *)
		mcROBOTICS_ERR_MPLINK_INVALID := -1064239101, (* MpLink connection not allowed [Error: 3, 0xc0910003] *)
		mcROBOTICS_ERR_MPLINK_CHANGED := -1064239100, (* MpLink modified [Error: 4, 0xc0910004] *)
		mcROBOTICS_ERR_MPLINK_CORRUPT := -1064239099, (* Invalid MpLink contents [Error: 5, 0xc0910005] *)
		mcROBOTICS_ERR_MPLINK_IN_USE := -1064239098, (* MpLink already in use [Error: 6, 0xc0910006] *)
		mcROBOTICS_ERR_PAR_NULL := -1064239097 (* Parameters structure is a null pointer [Error: 7, 0xc0910007] *)
		);
END_TYPE
