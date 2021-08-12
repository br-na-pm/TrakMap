
TYPE
	TrkDiagSegmentDataType : 	STRUCT 
		SegCount : USINT;
		SegListAdr : UDINT;
		SegList : ARRAY[0..NUM_SEG]OF TrkDiagSegmentType;
	END_STRUCT;
	TrkDiagSegmentType : 	STRUCT 
		Name : STRING[32]; (*Name of the segment in the SVG*)
		McType : McSegmentType; (*Segment Reference*)
		Status : TrkDiagSegmentStatusType; (*Status Information for the segment*)
	END_STRUCT;
	TrkDiagStatusType : 	STRUCT 
		Asm : TrkDiagAsmStatusType;
		Seg : TrkDiagSegmentDataType;
	END_STRUCT;
	TrkDiagAsmStatusType : 	STRUCT 
		AssemblyDisabled : BOOL;
		AssemblyReady : BOOL;
		AssemblyHoming : BOOL;
		AssemblyStopping : BOOL;
		AssemblyErrorStop : BOOL;
		CommunicationReady : BOOL;
		ReadyForPowerOn : BOOL;
		PowerOn : BOOL;
		StartupCount : UDINT;
		ShuttlesCount : UINT;
		ShuttleInErrorStopCount : UINT;
	END_STRUCT;
	TrkDiagSegmentStatusType : 	STRUCT 
		CommunicationReady : BOOL; (*Communication ready on the segment*)
		ReadyForPowerOn : BOOL; (*Segment is ready for power on*)
		PowerOn : BOOL; (*Segment is powered*)
		StartupCount : UDINT; (*Number of startups on the segment*)
		CommunicationState : McCommunicationStateEnum; (*Communication state of the segment*)
		SegmentDisabled : BOOL; (*Segment is disabled*)
		SegmentReady : BOOL; (*Segment is Ready*)
		SegmentStopping : BOOL; (*Segment is in the Stopping State*)
		SegmentErrorStop : BOOL; (*Segment is in an error stop state*)
		Error : BOOL;
		ErrorCode : UINT; (*Error code of the segment*)
	END_STRUCT;
END_TYPE
