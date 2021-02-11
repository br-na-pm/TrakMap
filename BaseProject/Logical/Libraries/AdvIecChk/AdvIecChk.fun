(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: IecCheck
 * File: IecCheck.fun
 * Author: adamsm
 * Created: October 03, 2012
 ********************************************************************
 * Functions and function blocks of library IecCheck
 ********************************************************************)

FUNCTION CheckDivDWord : UDINT (* Check divisor for DINT and UDINT division *)
	VAR_INPUT
		divisor : UDINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivWord : UINT (* Check divisor for INT and UINT division *)
	VAR_INPUT
		divisor : UINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivByte : USINT (* Check divisor for SINT and USINT division *)
	VAR_INPUT
		divisor : USINT;
	END_VAR
END_FUNCTION

FUNCTION CheckDivReal : REAL (* Check divisor for REAL division *)
	VAR_INPUT
		divisor : REAL;
	END_VAR
END_FUNCTION

FUNCTION CheckDivLReal : LREAL (* Check divisor for LREAL division, not available for SG3 and SGC *)
	VAR_INPUT
		divisor : LREAL;
	END_VAR
END_FUNCTION

FUNCTION CheckBounds : DINT (* Check range for array access *)
	VAR_INPUT
		index : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
	VAR
		LowString : STRING[4];
		UpString : STRING[4];
		IndexString : STRING[4];
		text : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION CheckRange : DINT (* Check range for enumeration *)
	VAR_INPUT
		value : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
	VAR
		LowString : STRING[4];
		UpString : STRING[4];
		IndexString : STRING[4];
		text : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION CheckSignedSubrange : DINT (* Check range for subrange of signed data types *)
	VAR_INPUT
		value : DINT;
		lower : DINT;
		upper : DINT;
	END_VAR
	VAR
		text : STRING[80];
		LowString : STRING[4];
		UpString : STRING[4];
		IndexString : STRING[4];
	END_VAR
END_FUNCTION

FUNCTION CheckUnsignedSubrange : UDINT (* Check range for subrange of unsigned data types *)
	VAR_INPUT
		value : UDINT;
		lower : UDINT;
		upper : UDINT;
	END_VAR
	VAR
		LowString : STRING[4];
		UpString : STRING[4];
		IndexString : STRING[4];
		text : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION CheckReadAccess : UDINT (* Check address when reading dynamic variables *)
	VAR_INPUT
		address : UDINT;
	END_VAR
END_FUNCTION

FUNCTION CheckWriteAccess : UDINT (* Check address when writing dynamic variables *)
	VAR_INPUT
		address : UDINT;
	END_VAR
END_FUNCTION

FUNCTION MakeEntry : UDINT (* Makes an entry (log book entry) in the error log book *)
	VAR_INPUT
		number : UINT;
		index : DINT;
		text : STRING[80];
	END_VAR
	VAR
		taskname : STRING[30];
		group : USINT;
		status_name : UINT;
		out_text : STRING[190];
		pv_adr : UDINT;
		data_len : UDINT;
		SectionString : STRING[80];
		SectionData : DINT;
	END_VAR
END_FUNCTION
