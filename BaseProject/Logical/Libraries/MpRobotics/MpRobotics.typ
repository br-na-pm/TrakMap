
TYPE
	MpDelta3AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpDelta3AxisJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..2]OF LREAL; (*Array[0..2] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..2]OF LREAL; (*Array[0..2] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpDelta3AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..2]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpDelta3AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..2]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT := 0; (*Coordinate system*)
	END_STRUCT;
	MpDelta4AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpDelta4AxisJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..3]OF LREAL; (*Array[0..3] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..3]OF LREAL; (*Array[0..3] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpDelta4AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..3]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpDelta4AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..3]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
	MpRoboticsDiagExtType : 	STRUCT 
		StatusID : MpRoboticsStatusIDType; (*StatusID information*)
		Internal : MpComInternalIDType; (*Internal data*)
	END_STRUCT;
	MpRoboticsStatusIDType : 	STRUCT 
		ID : MpRoboticsErrorEnum; (*Error number*)
		Severity : MpComSeveritiesEnum; (*Error severity*)
		Code : UINT; (*Error code*)
	END_STRUCT;
	MpRoboticsFlexParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpRoboticsFlexJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..14]OF LREAL; (*Array[0..14] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..14]OF LREAL; (*Array[0..14] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpRoboticsFlexInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..14]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpRoboticsFlexJogType : 	STRUCT 
		Velocity : ARRAY[0..14]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
	MpRoboArm6AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpRoboArm6AxisJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..5]OF LREAL; (*Array[0..5] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..5]OF LREAL; (*Array[0..5] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpRoboArm6AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..5]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpRoboArm6AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..5]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
	MpRoboArm4AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpRoboArm4AxisJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..3]OF LREAL; (*Array[0..3] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..3]OF LREAL; (*Array[0..3] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpRoboArm4AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..3]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpRoboArm4AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..3]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
	MpScara4AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpScara4AxisJogType := (PathLimits:=(Velocity:=1000,Acceleration:=10000,Deceleration:=10000,Jerk:=0)); (*Jog parameter*)
		Position : ARRAY[0..3]OF LREAL; (*Array[0..3] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..3]OF LREAL; (*Array[0..3] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpScara4AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if MpDelta3Axis is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if MpDelta3Axis is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..3]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpScara4AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..3]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
	MpRoboArm5AxisParType : 	STRUCT 
		ProgramName : STRING[260]; (*Name of the primary program that should be executed*)
		MoveProgramOptions : McPrgAdvParType; (*Additional MoveProgram options*)
		Jog : MpRoboArm5AxisJogType := (0); (*Jog parameter*)
		Position : ARRAY[0..4]OF LREAL; (*Array[0..5] of absolute end positions in every dimension of the selected coordinate system [application units]*)
		Distance : ARRAY[0..4]OF LREAL; (*Array[0..5] of relative distances in every dimension of the selected coordinate system [application units]*)
		Velocity : REAL := 100; (*Maximum path velocity [application units/s]*)
		Acceleration : REAL := 1000; (*Maximum path acceleration [application units/s]*)
		Deceleration : REAL := 1000; (* Maximum path deceleration [application units/s]*)
		Jerk : REAL := 0; (* Maximum path jerk [application units/s設 *)
		CoordSystem : UDINT; (*Coordinate system*)
		ManualMoveType : McManualMoveTypeEnum; (*ManualMoveType*)
	END_STRUCT;
	MpRoboArm5AxisInfoType : 	STRUCT 
		CommunicationReady : BOOL; (*TRUE if robot is ready to communicate*)
		ReadyToPowerOn : BOOL; (*TRUE if robot is ready for operation*)
		WaitForContinue : BOOL; (*Command "Continue" is expected (currently not implemented)*)
		JointAxisPosition : ARRAY[0..4]OF LREAL; (*Joint axis positions*)
		Program : McPrgInfoType; (*Program information*)
		Path : McPathInfoType; (*Path information*)
		JogStatus : McJogStatusEnum; (*Jog state*)
		PLCopenState : McGroupPLCopenStateEnum; (*PLCopen state for axis group*)
		Diag : MpRoboticsDiagExtType; (*Information about internal error*)
	END_STRUCT;
	MpRoboArm5AxisJogType : 	STRUCT 
		Velocity : ARRAY[0..4]OF REAL; (*Jog velocities [application units / s]*)
		PathLimits : McJogPathLimitsType; (*Path limits*)
		CoordSystem : UDINT; (*Coordinate system*)
	END_STRUCT;
END_TYPE
