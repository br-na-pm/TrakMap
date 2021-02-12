
TYPE
	TrkDiagSegStatusDCBusType : 	STRUCT 
		DCBusVoltage : REAL;
		DCBusVoltageMax : REAL;
		DCBusVoltageMin : REAL;
	END_STRUCT;
END_TYPE

(*Temporary Segment information*)

TYPE
	TrkDiagSegStatusTempType : 	STRUCT 
		TemperatureCON : REAL; (*monitor temperature CON*)
		TemperaturePROZ : REAL; (*monitor temperature PROZ*)
		TemperatureAIR : REAL; (*monitor temperature AIR*)
		TemperatureBAL : REAL; (*monitor temperature BAL*)
		TemperatureCHASSIS_1 : REAL; (*monitor temperature CHASSIS_1*)
		TemperatureCHASSIS_2 : REAL; (*monitor temperature CHASSIS_2*)
		TemperatureCHASSIS_3 : REAL; (*monitor temperature CHASSIS_3*)
		TemperaturePOWER_SENS3 : REAL; (*monitor temperature POWER_SENS3*)
		TemperaturePOWER_SENS4 : REAL; (*monitor temperature POWER_SENS4*)
		TemperaturePOWER_SENS5 : REAL; (*monitor temperature POWER_SENS5*)
		TemperaturePOWER_SENS6 : REAL; (*monitor temperature POWER_SENS6*)
		TemperaturePOWER_SENS7 : REAL; (*monitor temperature POWER_SENS7*)
		TemperaturePOWER_SENS8 : REAL; (*monitor temperature POWER_SENS8*)
		TemperaturePOWER_SENS9 : REAL; (*monitor temperature POWER_SENS9*)
		TemperaturePOWER_SENS10 : REAL; (*monitor temperature POWER_SENS10*)
		TemperaturePOWER_SENS11 : REAL; (*monitor temperature POWER_SENS11*)
	END_STRUCT;
END_TYPE
