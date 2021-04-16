
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
	DiagFbsType : 	STRUCT 
		Asm : DiagAsmFbsTyp;
		Seg : DiagSegFbsTyp;
	END_STRUCT;
	DiagAsmFbsTyp : 	STRUCT 
		ReadInfo : MC_BR_AsmReadInfo_AcpTrak;
		ReadStatus : MC_BR_AsmReadStatus_AcpTrak;
	END_STRUCT;
	DiagSegFbsTyp : 	STRUCT 
		ReadInfo : ARRAY[0..NUM_SEG]OF MC_BR_SegReadInfo_AcpTrak;
		ReadStatus : ARRAY[0..NUM_SEG]OF MC_BR_SegReadStatus_AcpTrak;
		ProcessParID : ARRAY[0..NUM_SEG]OF MC_BR_SegProcessParID_AcpTrak;
	END_STRUCT;
END_TYPE
