//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
// Copyright B&R Industrial Automation GmbH
// Author    B&R
// Created   Feb 1, 2018
// 
// trak motion logger filter task (optional)
// TC#8 => mandatory to be attached to idle task class!
// 
// * filters the "Motion" logger to display the newest 10 entries with severity "Error" or "Warning" entered by segments
// 
// "TrakLogger" - local interface structure
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



PROGRAM _INIT

	TrakLogger.AssemblyRef			:= ADR(gSampleTrak);
	TrakLogger.CmdRefresh			:= FALSE;
	TrakLogger.ParaShowSegError		:= TRUE;
	TrakLogger.ParaShowSegWarning	:= TRUE;
	TrakLogger.ParaSegFilter		:= 'SEG_';

	Step := TRAK_COMMAND;
	
END_PROGRAM
