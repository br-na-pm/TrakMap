(*Assembly States*)

TYPE
	TrBaseAsmStateEnum : 
		(
		ASM_STATE_OFF := 0,
		ASM_STATE_POWER,
		ASM_STATE_INIT,
		ASM_STATE_READY,
		ASM_STATE_ERROR := 255
		);
END_TYPE

(*Assembly Control*)

TYPE
	TrBaseAsmType : 	STRUCT 
		Cmd : TrBaseAsmCmdType;
		Status : TrBaseAsmStatusType;
	END_STRUCT;
END_TYPE

(*Assembly Command*)

TYPE
	TrBaseAsmCmdType : 	STRUCT 
		Power : BOOL; (*Switch on all segment controllers and identify all shuttles. Requires AssemblyDisabled.*)
		Stop : BOOL; (*Stop all shuttles and switch off all segment controllers*)
		ErrorReset : BOOL; (*Reset the assembly if Assembly FB error or AssemblyErrorStop*)
	END_STRUCT;
END_TYPE

(*Assembly Status*)

TYPE
	TrBaseAsmStatusType : 	STRUCT 
		Disabled : BOOL; (*[mapp Trak] The assembly is switched off. AsmPowerOff.Done, AsmReset.Done, or power cycle*)
		Homing : BOOL; (*[mapp Trak] Shuttle identification is active. AsmPowerOn.Execute*)
		Ready : BOOL; (*[mapp Trak] The assembly is switched on. AsmPowerOn.Done*)
		Stopping : BOOL; (*[mapp Trak] The shuttles are stopped. AsmPowerOff.Execute*)
		ErrorStop : BOOL; (*[mapp Trak] The shuttles are stopped. An error has occured in the assembly*)
		CommunicationReady : BOOL; (*[mapp Trak] The network of all segments has been initialized*)
		ReadyForPowerOn : BOOL; (*[mapp Trak] All segment controllers are ready to be switched on*)
		PowerOn : BOOL; (*[mapp Trak] All segments are switched on*)
		StartupCount : UDINT; (*[mapp Trak] Number of assembly switch-on operations*)
		ShuttlesInErrorStopCount : UINT; (*[mapp Trak] Number of shuttles in state ErrorStop*)
		Error : BOOL; (*The assembly implementation is in error*)
	END_STRUCT;
	TrBaseTrackingCmdType : 	STRUCT 
		Delete : BOOL;
	END_STRUCT;
	TrBaseTrackingStatusType : 	STRUCT 
		ShuttlesToBeDeletedCount : DINT;
	END_STRUCT;
	TrBaseTrackingType : 	STRUCT 
		Cmd : TrBaseTrackingCmdType;
		Status : TrBaseTrackingStatusType;
	END_STRUCT;
END_TYPE
