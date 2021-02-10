
TYPE
	ShuttleUserDataType : 	STRUCT  (*Shuttle data type definition - application specific*)
		ID : UINT; (*Shuttle ID assigned during homing*)
	END_STRUCT;
	SubroutineSequenceType : 	STRUCT  (*Subroutine sequence structure for a module*)
		Cmd : SubroutineSequenceCommandType; (*Subroutine commands (inputs)*)
		Status : SubroutineSequenceStatusType; (*Subroutine statuses (outputs)*)
	END_STRUCT;
	SubroutineSequenceCommandType : 	STRUCT  (*Subroutine seguence command variables*)
		Start : BOOL; (*Initiate the subroutine execution when the status reports ready*)
		Stop : BOOL; (*If the main routine is no longer in a proper state to execute the subroutine, stop the subroutine*)
		ErrorReset : BOOL; (*Command to reset the subroutine if in error*)
	END_STRUCT;
	SubroutineSequenceStatusType : 	STRUCT  (*Subroutine segeuqnce status variables*)
		Ready : BOOL; (*The subroutine is ready to start*)
		Complete : BOOL; (*The subroutine has complete and will wait for the reset of the start command*)
		Error : BOOL; (*The subroutine is in error and needs to be reset*)
	END_STRUCT;
	CyclicSubroutineType : 	STRUCT  (*Cyclic subroutine structure definition for a module*)
		Cmd : CyclicSubroutineCommandType; (*Cyclic subroutine command structure*)
		Status : CyclicSubroutineStatusType; (*Cyclic subroutine status structure*)
	END_STRUCT;
	CyclicSubroutineCommandType : 	STRUCT  (*Cyclic subroutine command structure definition*)
		Activate : BOOL; (*Activate the subroutine cyclic operation*)
		ErrorReset : BOOL; (*Reset the subroutine when in error*)
	END_STRUCT;
	CyclicSubroutineStatusType : 	STRUCT  (*Cyclic subroutine status structure definition*)
		Ready : BOOL; (*The subroutine cyclic operation is ready to begin*)
		Active : BOOL; (*The subroutine is activated and running*)
		Error : BOOL; (*The subroutine is in error*)
	END_STRUCT;
END_TYPE

(*Track Data Datatypes*)

TYPE
	TrackDataTyp : 	STRUCT 
		Segments : SegmentDataTyp;
	END_STRUCT;
	SegmentDataTyp : 	STRUCT 
		SegListAdr : UDINT;
		SegList : ARRAY[0..NUM_SEG]OF tpCoreSegmentTyp;
		SegCount : USINT;
	END_STRUCT;
END_TYPE
