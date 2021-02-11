(*****************************************************************************************************************************************
- This library is not officially supported by 
- Just like IECCheck library, this library only works IF a programming error was caused in a
program written in IEC languages.
This library will NOT help TO troubleshoot pagefaults caused in C, C++ etc.
- Automation Runtime Simulation (ArSim) does NOT provide consistent backtrace with this
library.
- This library is capable OF catching many types OF IEC programming errors but NOT all.
[Example: IF a pointer is NOT a null pointer but it is just pointing TO an incorrect but
NOT invalid OR protected location in the memory. The memory copy operation using
such pointer might end up overwriting some part OF the memory.
When the processor tries TO ACCESS this corrupted memory location, it will cause a
pagefault. In such cases, the memory has already been corrupted, so there are no
ways TO tell what wrote into this memory.]
 *****************************************************************************************************************************************
 * Library: AdvIecCheck
 ****************************************************************************************************************************************
 ****************************************************************************************************************************************
 *																																		*
 * 							How	to	isolate	pagefaults	using	the	 AdvIecCheck	library?											*
 *							~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~											*
 ****************************************************************************************************************************************
 ****************************************************************************************************************************************

			1 Overview
					
					1.1 What is a pagefault (Processor Exception Error)?
					 While a system is running, if the processor is commanded TO ACCESS an invalid OR protected
					memory location, it throws an exception TO the operating system. The B&R operating system logs
					these types OF serious memory violation errors as pagefaults.
					
					1.2 What can cause a pagefault?
					 Pagefaults can be caused BY programming errors AND sometimes it can be very difficult TO
					FIND the root cause OF it. The programming errors, such as incorrect reads OR writes can be caused BY
					following reasons:
					- Null OR incorrect pointer handle
					- Division BY zero
					- Invalid range OF enumeration
					- Invalid index ACCESS OF an array
					
					1.3 What is the difference between IECcheck & AdvIecCheck library?
					The IEC check library which is provided with Automation Studio checks division BY zero, null pointer,
					invalid array index, invalid enumeration range ACCESS AND invalid subrange.
					- IF IECcheck is NOT added TO a project, the checks FOR ‘null OR incorrect pointer handle, division
					BY zero, invalid range OF enumeration, and invalid index ACCESS OF an array’ are NOT
					performed, but when pagefault is encountered, you will get a backtrace.
					This backtrace may point you TO the line OF code that might have caused the pagefault.
					- IF IECcheck is added TO a project, the checks FOR ‘null OR incorrect pointer handle, division BY
					zero, invalid range OF enumeration, and invalid index ACCESS OF an array’ are performed.
					IF the processor finds any OF those checks TO be incorrect, a logbook error entry will inform
					you what type OF error were found AND which task class caused it, but you will get NOT get a
					backtrace.
					The Advance IEC Check library performs the same basic functions as IEC Check, but it also provides
					the following additional data about the location OF the pagefault.
					- Last executed task class cyclic
					- Last executed task’s name
					- Type OF programming error
					- Variable values from the last executed line OF code
					- Backtrace pointing TO the last executed line OF code
					
			
			2 Required Software
					- Automation Studio 4 (or higher)
					- Automation Runtime Embedded OR Automation Runtime Windows
			
			
			3 **************************************Warning****************************************************
			  **************************************Warning****************************************************
					- Just like IECCheck library, this library only works IF a programming error was caused in a
					program written in IEC languages.
					This library will NOT help TO troubleshoot pagefaults caused in C, C++ etc.
					- Automation Runtime Simulation (ArSim) does NOT provide consistent backtrace with this
					library.
					- This library is capable OF catching many types OF IEC programming errors but NOT all.
					[Example: IF a pointer is NOT a null pointer but it is just pointing TO an incorrect but
					NOT invalid OR protected location in the memory. The memory copy operation using
					such pointer might end up overwriting some part OF the memory.
					When the processor tries TO ACCESS this corrupted memory location, it will cause a
					pagefault. In such cases, the memory has already been corrupted, so there are no
					ways TO tell what wrote into this memory.]
			   **************************************Warning****************************************************
			   **************************************Warning****************************************************
			
			
			4 How TO use the AdvIecCheck Library?
			  How TO FIND the cause OF a pagefault?
					1. Unzip the attached AdvIecChk library.
					2. Add this library TO the Automation Studio project that is causing a pagefault.
					 Help on adding a user library can be found at:
					 Automation Studio Help > Programming > Libraries >
					 Example: Creating a user library> Exporting AND importing libraries
					3. Make sure the newly added AdvIecChk library is inside software configuration > library objects.
					4. Re-build the project AND transfer it TO the target OR create new compact flash card.
					5. Wait FOR the pagefaults.
					6. Try TO have multiple pagefaults & a repeatable way TO reproduce them before opening the logbook
					inside the project.
					7. Sort the logbook BY TIME.
					8. Warning entry will give you the following information about the pagefault trapped BY AdvIecChk.
					- Task class cyclic OF the task (E.g. task class 4)
					- Name OF the task (E.g. PageFault was the name OF my task)
					- Type OF programming error (E.g. Unsigned Subrange was outside valid range)
					- MAX, min valid value OF the variable that caused this fault
					(The valid range FOR that USINT was [3..20] AND the element the program was trying TO ACCESS
					was at location 0.)
					- Value OF the variable that ended up causing this fault
					9. Click on the Error entry AND go TO the backtrace, double click on the ‘FUNCTION start position’ OF the
					task name that you found inside the last warning message (It is ‘Pagefault’ in my example).
					Wherever the Automation Studio takes you, it is the line OF code where the pagefault was
					encountered.
					 10. After fixing the code, repeat the steps that you used TO cause the pagefault AND make sure the
					programing error is resolved.
			
			
			
			5 How TO disable IecCheck OR AdvIecCheck library in the project?
					IF the option -D _IGNORE_CHECKLIB is enabled in the additional build options, then the functions
					in this library are NOT used otherwise even IF you DELETE this library from software configuration,
					the compiler will use it.
			
			
			
			6 Best practices TO catch a pagefault
					Check FOR the following types OF operations:
					- Memory set, move, copy, and compare
					- String set, move, copy, and compare
					- Loop, enumeration AND array ranges
					- Use OF ADR(), ACCESS, and pointer handles TO FUNCTION blocks
			
			
			
			7 Additional note
					- You can customize AdvIecChk library TO get even more customized information out OF it
					- IF a non IEC language is causing pagefault, declare a remanent variable AND increase value OF
					that variable in your program. After a pagefault, you can connect TO the target AND read the
					value OF that remanent variable. Find out, at which point you set that value in your code.
					The programming error should be after that line OF code.

 ***************************************************************************************************************************************
 ******************************************************Release Notes********************************************************************
Revision 1.00.0    - Matt Buck & Matt Adams
- Started distributing from 2013
- Better logger entries
 ******************************************************************************************************************************************
Revision 2.00.0    - Varad Darji
- Started distributing from Automation Conf. 2015
- Improvement for logger entries 
- Provides backtrace
- gIecChkSec entries does NOT need TO be part OF this code there anymore because we are getting an actual backtrace now. 
  They are there for legacy reasons. 
- Created new documentation & added it to the library as well.
 ******************************************************************************************************************************************
 ******************************************************************************************************************************************)




(* Check divisor for DINT and UDINT division *)
FUNCTION CheckDivDWord
	IF divisor=0 THEN
		CheckDivDWord:=1;
		MakeEntry(55555,divisor,'Divide by Zero - Double Word');
	
		//Note: DarjiV, creating a pagefault on purpose to get the backtrace data
		//				This function does not provide consistant back
		memcpy(1,1,1);

	ELSE
		CheckDivDWord:=divisor;
	END_IF
END_FUNCTION

(* Check divisor for INT and UINT division *)
FUNCTION CheckDivWord
	IF divisor=0 THEN
		CheckDivWord:=1;
		MakeEntry(55555,divisor,'Divide by Zero - Word');
		
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckDivWord:=divisor;
	END_IF
END_FUNCTION

(* Check divisor for SINT and USINT division *)
FUNCTION CheckDivByte
	IF divisor=0 THEN
		CheckDivByte:=1;
		MakeEntry(55555,divisor,'Divide by Zero - Byte');
		
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckDivByte:=divisor;
	END_IF
END_FUNCTION

(* Check divisor for REAL division *)
FUNCTION CheckDivReal
	IF divisor=0 THEN
		CheckDivReal:=1;
		MakeEntry(55555,0,'Divide by Zero - Real');
		
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckDivReal:=divisor;
	END_IF
END_FUNCTION

(* Check divisor for LREAL division *)
FUNCTION CheckDivLReal
	IF divisor=0 THEN
		CheckDivLReal:=1;
		MakeEntry(55555,0,'Divide by Zero - Long Real');
		
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckDivLReal:=divisor;
	END_IF
END_FUNCTION

(* Check range for enumeration *)
FUNCTION CheckRange
	IF value < lower THEN
		CheckRange := lower;
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('ENUM-Check Low. Value '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
		
	ELSIF value > upper THEN
		CheckRange := upper;
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('ENUM-Check High. Value '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckRange := value;
	END_IF
END_FUNCTION

(* Check range for subrange of signed data types *)
FUNCTION CheckSignedSubrange
	IF value < lower THEN
		CheckSignedSubrange := lower;
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('Signed Subrange Index '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);		
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
		
	ELSIF value > upper THEN
		CheckSignedSubrange := upper;		
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('Signed Subrange Index '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckSignedSubrange := value;
	END_IF
END_FUNCTION

(* Check range for subrange of unsigned data types *)
FUNCTION CheckUnsignedSubrange
	IF value < lower THEN
		CheckUnsignedSubrange := lower;		
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('Unsigned Subrange Index '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
		
	ELSIF value > upper THEN
		CheckUnsignedSubrange := upper;
		
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(value, ADR(IndexString));
		strcpy(ADR(text),ADR('Unsigned Subrange Index '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,value,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckUnsignedSubrange := value;
	END_IF
END_FUNCTION

(* Check address when reading dynamic variables *)
FUNCTION CheckReadAccess
	IF address=0 THEN
		(* TODO: Insert an appropriate code, see AutomationStudio help for further information *)
		MakeEntry(55555,address,'Attempt to read from address of zero / NULL');
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);

	END_IF

	CheckReadAccess:=0;
END_FUNCTION

(* Check address when writing dynamic variables *)
FUNCTION CheckWriteAccess
	IF address=0 THEN
		(* TODO: Insert an appropriate code, see AutomationStudio help for further information *)
		MakeEntry(55555,address,'Attempt to write to address of zero / NULL');
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	END_IF

	CheckWriteAccess:=0;
END_FUNCTION



FUNCTION CheckBounds (* Check range for array access *)
	IF index < lower OR index > upper THEN
		itoa(lower, ADR(LowString));
		itoa(upper, ADR(UpString));
		itoa(index, ADR(IndexString));
		CheckBounds := upper;
		strcpy(ADR(text),ADR('Array Index '));
		strcat(ADR(text),ADR(IndexString));
		strcat(ADR(text),ADR(' is outside ['));
		strcat(ADR(text),ADR(LowString));
		strcat(ADR(text),ADR('..'));
		strcat(ADR(text),ADR(UpString));
		strcat(ADR(text),ADR(']'));
		MakeEntry(55555,index,text);
		//creating a pagefault on purpose to get the backtrace data
		memcpy(1,1,1);
	ELSE
		CheckBounds := index;
	END_IF
END_FUNCTION

FUNCTION MakeEntry (* Makes a log book entry. Note that gIecChkSec must be a global DINT! *)
	status_name := ST_name(0,ADR(taskname),ADR(group));
	PV_xgetadr(ADR('gIecChkSec'), ADR(pv_adr), ADR(data_len));
	IF pv_adr > 0 AND data_len > 0 THEN
		memcpy(ADR(SectionData),pv_adr,data_len);
		itoa(SectionData,ADR(SectionString));
	END_IF
		
	strcpy(ADR(out_text),ADR(text));
	strcat(ADR(out_text),ADR(' in task "'));
	strcat(ADR(out_text),ADR(taskname));
	strcat(ADR(out_text),ADR('" Section:'));
	strcat(ADR(out_text),ADR(SectionString));
	MakeEntry := ADR(out_text);	
	
	// Making Logger entry & restarting
	ERRxwarning(number,index,ADR(out_text));	
	// Change Note DarjiV: Change ERRxfatel_FB to ERRxwarning_FB because to get additional data.
	// 						Because I want TO finish this function and go back TO whichever function started this function and cause a pagefault there to get backtrace to the CODE.
	//						Now the AdvanceIEC Check library will give a pagefault location in CODE & the values of those variable when the pagefault happened.
	
END_FUNCTION