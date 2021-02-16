
TYPE
	CheckStateEnum : 
		(
		WAIT_FOR_CHECK,
		READ_DATA,
		READ_DATA_SEG_STATE,
		CHECK_SEG_STATE,
		READ_DATA_SEG_ERROR_STAT,
		CHECK_ERROR_STAT,
		READ_DATA_SEG_ERROR,
		CHECK_ERROR_CODE,
		WRITE_WARNING_CODE,
		READ_DATA_SEG_LAG,
		CHECK_SEG_LAG,
		READ_DATA_SEG_VEL,
		CHECK_SEG_VEL,
		READ_DATA_SEG_TEMP,
		CHECK_DATA_SEG_TEMP,
		WRITE_SPEED_FILTER,
		WRITE_SPEED_FILTER_WAIT,
		WRITE_ZERO_PITCH,
		READ_EXEC_ERROR,
		READ_SEG_STATUS,
		WRITE_SEG_RESET,
		WAIT_FOR_DONE
		);
	SegErrorCheckType : 	STRUCT 
		CheckState : CheckStateEnum;
		CmdCheckErrorCode : BOOL;
		DataReadExecutionError : BOOL;
		ErrorNumber : UINT;
		SegStatusBits : UDINT;
		ErrorStatusBit : BOOL;
		ErrorStatus : UDINT;
	END_STRUCT;
	SegShuttleMonitorType : 	STRUCT 
		CheckState_enum : BOOL;
		CmdMonitorLag : BOOL;
		CmdMonitorVelocity : BOOL;
		Lag : ARRAY[0..2]OF LREAL;
		Velocity : ARRAY[0..2]OF LREAL;
		LagLimitExceeded : BOOL;
		VelLimitExceeded : BOOL;
	END_STRUCT;
	SegTempCheckType : 	STRUCT 
		CheckState : CheckStateEnum;
		CmdCheckTemp : BOOL;
		DataReadExecutionError : BOOL;
	END_STRUCT;
	SegPitchSetType : 	STRUCT 
		CheckState : CheckStateEnum;
		CmdSetPitch : BOOL;
		CmdWriteFilter : BOOL;
		PitchSetComplete : BOOL;
		FilterWriteComplete : BOOL;
		DataReadExecutionError : BOOL;
		ErrorID : UDINT;
	END_STRUCT;
END_TYPE
