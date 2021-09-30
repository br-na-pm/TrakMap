/* Automation Studio generated header file */
/* Do not edit ! */
/* MpRobotics 5.14.2 */

#ifndef _MPROBOTICS_
#define _MPROBOTICS_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _MpRobotics_VERSION
#define _MpRobotics_VERSION 5.14.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <McAxGroup.h> 
#include <MpBase.h>
#endif
 
#ifdef _SG3
#include <McAxGroup.h> 
#include <MpBase.h>
#endif
 
#ifdef _SGC
#include <McAxGroup.h> 
#include <MpBase.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef enum MpRoboticsErrorEnum
{	mcROBOTICS_NO_ERROR = 0,
	mcROBOTICS_ERR_AXES_GROUP = -1067211008,
	mcROBOTICS_WRN_CMD_NOT_ALLOWED = -2140952831,
	mcROBOTICS_INF_NOT_ENOUGH_AXES = 1080272642,
	mcROBOTICS_WRN_OVR_OUT_OF_RANGE = -2140952829,
	mcROBOTICS_ERR_ACTIVATION = -1064239103,
	mcROBOTICS_ERR_MPLINK_NULL = -1064239102,
	mcROBOTICS_ERR_MPLINK_INVALID = -1064239101,
	mcROBOTICS_ERR_MPLINK_CHANGED = -1064239100,
	mcROBOTICS_ERR_MPLINK_CORRUPT = -1064239099,
	mcROBOTICS_ERR_MPLINK_IN_USE = -1064239098,
	mcROBOTICS_ERR_PAR_NULL = -1064239097
} MpRoboticsErrorEnum;

typedef struct MpDelta3AxisJogType
{	float Velocity[3];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpDelta3AxisJogType;

typedef struct MpDelta3AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpDelta3AxisJogType Jog;
	double Position[3];
	double Distance[3];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpDelta3AxisParType;

typedef struct MpRoboticsStatusIDType
{	enum MpRoboticsErrorEnum ID;
	enum MpComSeveritiesEnum Severity;
	unsigned short Code;
} MpRoboticsStatusIDType;

typedef struct MpRoboticsDiagExtType
{	struct MpRoboticsStatusIDType StatusID;
	struct MpComInternalIDType Internal;
} MpRoboticsDiagExtType;

typedef struct MpDelta3AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[3];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpDelta3AxisInfoType;

typedef struct MpDelta4AxisJogType
{	float Velocity[4];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpDelta4AxisJogType;

typedef struct MpDelta4AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpDelta4AxisJogType Jog;
	double Position[4];
	double Distance[4];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpDelta4AxisParType;

typedef struct MpDelta4AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[4];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpDelta4AxisInfoType;

typedef struct MpRoboticsFlexJogType
{	float Velocity[15];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpRoboticsFlexJogType;

typedef struct MpRoboticsFlexParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpRoboticsFlexJogType Jog;
	double Position[15];
	double Distance[15];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpRoboticsFlexParType;

typedef struct MpRoboticsFlexInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[15];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpRoboticsFlexInfoType;

typedef struct MpRoboArm6AxisJogType
{	float Velocity[6];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpRoboArm6AxisJogType;

typedef struct MpRoboArm6AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpRoboArm6AxisJogType Jog;
	double Position[6];
	double Distance[6];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpRoboArm6AxisParType;

typedef struct MpRoboArm6AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[6];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpRoboArm6AxisInfoType;

typedef struct MpRoboArm4AxisJogType
{	float Velocity[4];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpRoboArm4AxisJogType;

typedef struct MpRoboArm4AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpRoboArm4AxisJogType Jog;
	double Position[4];
	double Distance[4];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpRoboArm4AxisParType;

typedef struct MpRoboArm4AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[4];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpRoboArm4AxisInfoType;

typedef struct MpScara4AxisJogType
{	float Velocity[4];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpScara4AxisJogType;

typedef struct MpScara4AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpScara4AxisJogType Jog;
	double Position[4];
	double Distance[4];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpScara4AxisParType;

typedef struct MpScara4AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[4];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpScara4AxisInfoType;

typedef struct MpRoboArm5AxisJogType
{	float Velocity[5];
	struct McJogPathLimitsType PathLimits;
	unsigned long CoordSystem;
} MpRoboArm5AxisJogType;

typedef struct MpRoboArm5AxisParType
{	plcstring ProgramName[261];
	struct McPrgAdvParType MoveProgramOptions;
	struct MpRoboArm5AxisJogType Jog;
	double Position[5];
	double Distance[5];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	unsigned long CoordSystem;
	enum McManualMoveTypeEnum ManualMoveType;
} MpRoboArm5AxisParType;

typedef struct MpRoboArm5AxisInfoType
{	plcbit CommunicationReady;
	plcbit ReadyToPowerOn;
	plcbit WaitForContinue;
	double JointAxisPosition[5];
	struct McPrgInfoType Program;
	struct McPathInfoType Path;
	enum McJogStatusEnum JogStatus;
	enum McGroupPLCopenStateEnum PLCopenState;
	struct MpRoboticsDiagExtType Diag;
} MpRoboArm5AxisInfoType;

typedef struct MpDelta3Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpDelta3AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	float PathVelocity;
	struct MpDelta3AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpDelta3Axis_typ;

typedef struct MpDelta4Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpDelta4AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double C;
	float PathVelocity;
	struct MpDelta4AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpDelta4Axis_typ;

typedef struct MpRoboticsFlex
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpRoboticsFlexParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double Position[15];
	float PathVelocity;
	struct MpRoboticsFlexInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpRoboticsFlex_typ;

typedef struct MpRoboArm6Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpRoboArm6AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double A;
	double B;
	double C;
	float PathVelocity;
	struct MpRoboArm6AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpRoboArm6Axis_typ;

typedef struct MpRoboArm4Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpRoboArm4AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double C;
	float PathVelocity;
	struct MpRoboArm4AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpRoboArm4Axis_typ;

typedef struct MpScara4Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpScara4AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double C;
	float PathVelocity;
	struct MpScara4AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpScara4Axis_typ;

typedef struct MpRoboArm5Axis
{
	/* VAR_INPUT (analog) */
	struct McAxesGroupType* MpLink;
	struct MpRoboArm5AxisParType* Parameters;
	float Override;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	double X;
	double Y;
	double Z;
	double B;
	double C;
	float PathVelocity;
	struct MpRoboArm5AxisInfoType Info;
	/* VAR (analog) */
	struct MpComInternalDataType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ErrorReset;
	plcbit Update;
	plcbit Power;
	plcbit Home;
	plcbit MoveProgram;
	plcbit Interrupt;
	plcbit Continue;
	plcbit Stop;
	plcbit Jog;
	plcbit MoveDirect;
	plcbit MoveLinear;
	plcbit SingleStep;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit CommandBusy;
	plcbit CommandAborted;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit MoveActive;
	plcbit MoveInterrupted;
	plcbit MoveDone;
	plcbit Stopped;
	plcbit InMotion;
	plcbit SingleStepActive;
} MpRoboArm5Axis_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MpDelta3Axis(struct MpDelta3Axis* inst);
_BUR_PUBLIC void MpDelta4Axis(struct MpDelta4Axis* inst);
_BUR_PUBLIC void MpRoboticsFlex(struct MpRoboticsFlex* inst);
_BUR_PUBLIC void MpRoboArm6Axis(struct MpRoboArm6Axis* inst);
_BUR_PUBLIC void MpRoboArm4Axis(struct MpRoboArm4Axis* inst);
_BUR_PUBLIC void MpScara4Axis(struct MpScara4Axis* inst);
_BUR_PUBLIC void MpRoboArm5Axis(struct MpRoboArm5Axis* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MPROBOTICS_ */

