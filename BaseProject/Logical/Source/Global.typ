(*==================================================
ACOPOStrak Global Structure Hierarchy
==================================================*)

TYPE
	TrakType : 	STRUCT  (*Global structure definition*)
		Asm : TrBaseAsmType; (*Assembly substructure*)
		Par : TrakParametersType; (*ACOPOStrak application parameters*)
		Buffer : ARRAY[0..149]OF BOOL;
		Tracking : TrBaseTrackingType;
	END_STRUCT;
END_TYPE

(*Application parameters*)

TYPE
	TrakParametersType : 	STRUCT 
		Velocity : REAL;
		Acceleration : REAL;
		CriticalVelocity : REAL;
		RecoveryVelocity : REAL;
	END_STRUCT;
END_TYPE

(*Interface for variable mapping*)

TYPE
	ModuleInterfaceType : 	STRUCT 
		ShuttleMon : McAcpTrakAssemblyMonData;
		SampleTrak : McAssemblyType;
		MainPml : MpComIdentType;
		ModulePml : MpComIdentType;
		AlarmCore : MpComIdentType;
		AuditCore : MpComIdentType;
		RecipeCore : MpComIdentType;
		TrakInterface : TrakType;
		SectorTrakAll : McSectorType;
		SectorTrakB : McSectorType;
		SectorTrakA : McSectorType;
	END_STRUCT;
END_TYPE
