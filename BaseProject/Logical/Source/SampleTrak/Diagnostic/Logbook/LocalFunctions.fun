
FUNCTION GetSeverity : USINT
	VAR_INPUT
		EventID : DINT;
	END_VAR
END_FUNCTION

FUNCTION GetFacility : UINT
	VAR_INPUT
		EventID : DINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION GetCode : UINT (*create mappView string data provider*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		EventID : DINT;
	END_VAR
END_FUNCTION

FUNCTION InsertEntry : UINT
	VAR_INPUT
		DAT : REFERENCE TO LogBookDataType;
		DTsec : UDINT;
		DTmsec : UINT;
		Sorting : LogBookSortingEnum;
	END_VAR
	VAR
		idx : UINT;
		idy : UINT;
	END_VAR
END_FUNCTION

FUNCTION NormalizeDateTime : UDINT
	VAR_INPUT
		target : UDINT;
		value : UDINT;
		addSTR : STRING[5];
	END_VAR
	VAR
		tmpSTR1 : STRING[10];
		tmpSTR2 : STRING[10];
	END_VAR
END_FUNCTION

FUNCTION WorkingStatus : USINT
	VAR_INPUT
		target : UDINT;
		text : UDINT;
		animation : USINT;
	END_VAR
END_FUNCTION

FUNCTION IsInstr : BOOL
	VAR_INPUT
		string1 : UDINT;
		string2 : UDINT;
	END_VAR
	VAR
		idx : UDINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION SetTrakSegAlarm : BOOL (*Trigger MpAlarmXSet based on EventIDCode*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		AlarmMpLink : MpComIdentType;
		EventIDCode : UDINT;
		AlarmCount : REFERENCE TO ARRAY[0..119] OF UDINT;
	END_VAR
END_FUNCTION
