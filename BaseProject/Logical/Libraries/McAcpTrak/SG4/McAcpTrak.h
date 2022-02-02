/* Automation Studio generated header file */
/* Do not edit ! */
/* McAcpTrak 5.16.2 */

#ifndef _MCACPTRAK_
#define _MCACPTRAK_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _McAcpTrak_VERSION
#define _McAcpTrak_VERSION 5.16.2
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <McBase.h> 
#include <McAxis.h>
#endif
 
#ifdef _SG3
#include <McBase.h> 
#include <McAxis.h>
#endif
 
#ifdef _SGC
#include <McBase.h> 
#include <McAxis.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef enum McAcpTrakSegProcessParIDModeEnum
{	mcACPTRAK_SEG_PARID_GET = 0,
	mcACPTRAK_SEG_PARID_SET,
	mcACPTRAK_SEG_PARID_GET_NO_NCT
} McAcpTrakSegProcessParIDModeEnum;

typedef enum McAcpTrakSegDataTypeEnum
{	mcACPTRAK_SEG_PARTYPE_BOOL = 1,
	mcACPTRAK_SEG_PARTYPE_SINT,
	mcACPTRAK_SEG_PARTYPE_INT,
	mcACPTRAK_SEG_PARTYPE_DINT,
	mcACPTRAK_SEG_PARTYPE_USINT,
	mcACPTRAK_SEG_PARTYPE_UINT,
	mcACPTRAK_SEG_PARTYPE_UDINT,
	mcACPTRAK_SEG_PARTYPE_REAL,
	mcACPTRAK_SEG_PARTYPE_LREAL = 17,
	mcACPTRAK_SEG_PARTYPE_VOID = 65535
} McAcpTrakSegDataTypeEnum;

typedef enum McAcpTrakTrgPointEventEnum
{	mcACPTRAK_TP_PASSED_NEGATIVE,
	mcACPTRAK_TP_PASSED_POSITIVE
} McAcpTrakTrgPointEventEnum;

typedef enum McAcpTrakSearchModeEnum
{	mcACPTRAK_SEARCH_FORWARD,
	mcACPTRAK_SEARCH_BACKWARD
} McAcpTrakSearchModeEnum;

typedef enum McAcpTrakCopyUserDataModeEnum
{	mcACPTRAK_USERDATA_GET,
	mcACPTRAK_USERDATA_SET
} McAcpTrakCopyUserDataModeEnum;

typedef enum McAcpTrakShManeuverTypeEnum
{	mcACPTRAK_MANEUVER_NONE = 0,
	mcACPTRAK_MANEUVER_ADJUSTMENT = 1,
	mcACPTRAK_MANEUVER_STANDSTILL = 2,
	mcACPTRAK_MANEUVER_EMERGENCY = 3
} McAcpTrakShManeuverTypeEnum;

typedef enum McAcpTrakShManeuverReasonEnum
{	mcACPTRAK_REASON_UNSPECIFIED = 0,
	mcACPTRAK_REASON_SHUTTLE = 1,
	mcACPTRAK_REASON_LOCAL_VEL_LIMIT = 2,
	mcACPTRAK_REASON_BARRIER = 3,
	mcACPTRAK_REASON_SECTOREND = 4,
	mcACPTRAK_REASON_SECTORSWITCH = 5,
	mcACPTRAK_REASON_LOGISTICS = 6,
	mcACPTRAK_REASON_NONE = 7,
	mcACPTRAK_REASON_LOCAL_ACC_LIMIT = 8,
	mcACPTRAK_REASON_UNCONTROLLED = 9,
	mcACPTRAK_REASON_RECONTROLLED = 10,
	mcACPTRAK_REASON_CONVOY = 11,
	mcACPTRAK_REASON_CON_DIFF_SECTOR = 12,
	mcACPTRAK_REASON_CON_INV_REF = 13,
	mcACPTRAK_REASON_CON_SECSWITCH = 14,
	mcACPTRAK_REASON_CON_UNCONTR = 15
} McAcpTrakShManeuverReasonEnum;

typedef enum McAcpTrakBarrierTypeEnum
{	mcACPTRAK_BARRIER_USER = 0,
	mcACPTRAK_BARRIER_CONFLICTZONE = 1,
	mcACPTRAK_BARRIER_SEGMENT = 2
} McAcpTrakBarrierTypeEnum;

typedef enum McAcpTrakSelectShSideEnum
{	mcACPTRAK_SIDE_BOTH = 0
} McAcpTrakSelectShSideEnum;

typedef enum McAcpTrakSecTypeEnum
{	mcACPTRAK_SEC_USER_DEFINED,
	mcACPTRAK_SEC_SEGMENT,
	mcACPTRAK_SEC_INTERNAL
} McAcpTrakSecTypeEnum;

typedef enum McAcpTrakRoutePosRelToEnum
{	mcACPTRAK_SEC_START,
	mcACPTRAK_SEC_END
} McAcpTrakRoutePosRelToEnum;

typedef enum McAcpTrakShMovementTypeEnum
{	mcACPTRAK_MOVEMENT_STANDSTILL,
	mcACPTRAK_MOVEMENT_ELASTIC,
	mcACPTRAK_MOVEMENT_RIGID
} McAcpTrakShMovementTypeEnum;

typedef enum McAcpTrakMoveCmdEnum
{	mcACPTRAK_MOV_CMD_HALT,
	mcACPTRAK_MOV_CMD_MOVEABS,
	mcACPTRAK_MOV_CMD_ELASTICMOVEABS,
	mcACPTRAK_MOV_CMD_MOVEVEL,
	mcACPTRAK_MOV_CMD_ELASTICMOVEVEL
} McAcpTrakMoveCmdEnum;

typedef enum McAcpTrakBarrierCmdEnum
{	mcACPTRAK_BARRIER_OPEN,
	mcACPTRAK_BARRIER_CLOSE,
	mcACPTRAK_BARRIER_ADD_TICKETS
} McAcpTrakBarrierCmdEnum;

typedef enum McAcpTrakBarrierStatusEnum
{	mcACPTRAK_BARRIER_OPENED,
	mcACPTRAK_BARRIER_CLOSED,
	mcACPTRAK_BARRIER_TICKETING
} McAcpTrakBarrierStatusEnum;

typedef enum McAcpTrakCouplingObjCmdEnum
{	mcACPTRAK_COUPLE_OBJ_SET,
	mcACPTRAK_COUPLE_OBJ_REMOVE
} McAcpTrakCouplingObjCmdEnum;

typedef enum McAcpTrakSimulationOnPlcEnum
{	mcACPTRAK_SIM_STATE_OFF,
	mcACPTRAK_SIM_STATE_ON
} McAcpTrakSimulationOnPlcEnum;

typedef enum McAcpTrakFieldModeEnum
{	mcACPTRAK_FIELD_NORMAL,
	mcACPTRAK_FIELD_WEAKENING,
	mcACPTRAK_FIELD_STRENGTHENING
} McAcpTrakFieldModeEnum;

typedef enum McAcpTrakShResizeCmdEnum
{	mcACPTRAK_RESIZE_DIMENSIONS
} McAcpTrakShResizeCmdEnum;

typedef enum McAcpTrakShResizeModeEnum
{	mcACPTRAK_RESIZE_IMMEDIATE,
	mcACPTRAK_RESIZE_AVOID_ERRORSTOP
} McAcpTrakShResizeModeEnum;

typedef enum McAcpTrakAsmDeleteShCmdEnum
{	mcACPTRAK_SH_DELETE_SPECIFIC,
	mcACPTRAK_SH_DELETE_ALL
} McAcpTrakAsmDeleteShCmdEnum;

typedef enum McAcpTrakPLCopenStateEnum
{	mcACPTRAK_DISABLED,
	mcACPTRAK_HOMING,
	mcACPTRAK_READY,
	mcACPTRAK_STOPPING,
	mcACPTRAK_ERRORSTOP,
	mcACPTRAK_STARTUP,
	mcACPTRAK_INVALID_CONFIGURATION
} McAcpTrakPLCopenStateEnum;

typedef enum McAcpTrakShRelativeAlignmentEnum
{	mcACPTRAK_ALIGNED_FRONT_TO_BACK,
	mcACPTRAK_ALIGNED_BACK_TO_FRONT,
	mcACPTRAK_ALIGNED_FRONT_TO_FRONT,
	mcACPTRAK_ALIGNED_BACK_TO_BACK
} McAcpTrakShRelativeAlignmentEnum;

typedef enum McAcpTrakShRelativeRefPointEnum
{	mcACPTRAK_DIST_CENTER_TO_CENTER,
	mcACPTRAK_DIST_CENTER_TO_EXTENT,
	mcACPTRAK_DIST_EXTENT_TO_CENTER,
	mcACPTRAK_DIST_EXTENT_TO_EXTENT
} McAcpTrakShRelativeRefPointEnum;

typedef enum McAcpTrakShLocalLimitCmdEnum
{	mcACPTRAK_LL_ADD_SHUTTLE,
	mcACPTRAK_LL_REMOVE_SHUTTLE
} McAcpTrakShLocalLimitCmdEnum;

typedef enum McAcpTrakShShuttleCmdEnum
{	mcACPTRAK_SH_ACT_COLLAVOID,
	mcACPTRAK_SH_DEACT_COLLAVOID
} McAcpTrakShShuttleCmdEnum;

typedef enum McAcpTrakShErrorReasonEnum
{	mcACPTRAK_SH_ERROR_NONE,
	mcACPTRAK_SH_ERROR_UNSPECIFIED,
	mcACPTRAK_SH_ERROR_MANEUVER,
	mcACPTRAK_SH_ERROR_ENCDIFF,
	mcACPTRAK_SH_ERROR_NOGRIPPER,
	mcACPTRAK_SH_ERROR_COMMAND,
	mcACPTRAK_SH_ERROR_SEGMENT,
	mcACPTRAK_SH_ERROR_ASSEMBLY,
	mcACPTRAK_SH_ERROR_INVALIDMOVE,
	mcACPTRAK_SH_ERROR_COUPLING
} McAcpTrakShErrorReasonEnum;

typedef enum McAcpTrakSegTypeEnum
{	mcACPTRAK_SEG_CIRC,
	mcACPTRAK_SEG_STR_630,
	mcACPTRAK_SEG_STR_90_TO_CIRC,
	mcACPTRAK_SEG_CIRC_TO_STR_90,
	mcACPTRAK_SEG_STR_660,
	mcACPTRAK_SEG_STR_105_TO_CIRC,
	mcACPTRAK_SEG_CIRC_TO_STR_105,
	mcACPTRAK_SEG_COMPACT_CURVE_180
} McAcpTrakSegTypeEnum;

typedef enum McAcpTrakSegErrorReasonEnum
{	mcACPTRAK_SEG_ERROR_NONE,
	mcACPTRAK_SEG_ERROR_UNSPECIFIED,
	mcACPTRAK_SEG_ERROR_NOGRIPPER,
	mcACPTRAK_SEG_ERROR_COMMAND,
	mcACPTRAK_SEG_ERROR_SEGMENT,
	mcACPTRAK_SEG_ERROR_ASSEMBLY
} McAcpTrakSegErrorReasonEnum;

typedef enum McAcpTrakAsmErrorReasonEnum
{	mcACPTRAK_ASM_ERROR_NONE,
	mcACPTRAK_ASM_ERROR_UNSPECIFIED,
	mcACPTRAK_ASM_ERROR_ENCDIFF,
	mcACPTRAK_ASM_ERROR_NOGRIPPER,
	mcACPTRAK_ASM_ERROR_COMMAND,
	mcACPTRAK_ASM_ERROR_SEGMENT,
	mcACPTRAK_ASM_ERROR_UNOBSERVABLE
} McAcpTrakAsmErrorReasonEnum;

typedef enum McAcpTrakGetShuttleModeEnum
{	mcACPTRAK_GET_SH_ALL = 0,
	mcACPTRAK_GET_SH_STANDSTILL,
	mcACPTRAK_GET_SH_DISABLED,
	mcACPTRAK_GET_SH_STOPPING,
	mcACPTRAK_GET_SH_ERRORSTOP,
	mcACPTRAK_GET_SH_ERROR_MANEUVER,
	mcACPTRAK_GET_SH_ERROR_ENCDIFF,
	mcACPTRAK_GET_SH_ERROR_NOGRIPPER,
	mcACPTRAK_GET_SH_ERROR_COMMAND,
	mcACPTRAK_GET_SH_ERROR_SEGMENT,
	mcACPTRAK_GET_SH_ERROR_ASSEMBLY,
	mcACPTRAK_GET_SH_ERROR_INVMOV,
	mcACPTRAK_GET_SH_ERROR_COUPLING,
	mcACPTRAK_GET_SH_CONVOYMASTER
} McAcpTrakGetShuttleModeEnum;

typedef enum McAcpTrakGetSegmentModeEnum
{	mcACPTRAK_GET_SEG_ALL = 0,
	mcACPTRAK_GET_SEG_DISABLED,
	mcACPTRAK_GET_SEG_STOPPING,
	mcACPTRAK_GET_SEG_ERRORSTOP
} McAcpTrakGetSegmentModeEnum;

typedef enum McAcpTrakGetSectorModeEnum
{	mcACPTRAK_GET_SEC_ALL = 0,
	mcACPTRAK_GET_SEC_CLOSED,
	mcACPTRAK_GET_SEC_NONCLOSED
} McAcpTrakGetSectorModeEnum;

typedef enum McAcpTrakBarrierGetShModeEnum
{	mcACPTRAK_BARR_GET_SH_ALL = 0,
	mcACPTRAK_BARR_GET_SH_STANDSTILL
} McAcpTrakBarrierGetShModeEnum;

typedef enum McAcpTrakCouplingModeEnum
{	mcACPTRAK_COUPL_DIST
} McAcpTrakCouplingModeEnum;

typedef enum McAcpTrakConDeleteModeEnum
{	mcACPTRAK_CON_DELETE_ANY_CASE,
	mcACPTRAK_CON_DELETE_EMPTY
} McAcpTrakConDeleteModeEnum;

typedef enum McAcpTrakConGetShuttleModeEnum
{	mcACPTRAK_CON_GET_SH_SECPOS_ASC,
	mcACPTRAK_CON_GET_SH_SECPOS_DESC
} McAcpTrakConGetShuttleModeEnum;

typedef enum McASMTrkPosEnum
{	mcASMTP_ABS = 0,
	mcASMTP_REL_TO_ONE_SEG = 1,
	mcASMTP_REL_TO_TWO_SEG = 2
} McASMTrkPosEnum;

typedef enum McASMTrkPosAbsSegCntDirEnum
{	mcASMTPASCD_RIGHT_TO_LFT = 0,
	mcASMTPASCD_LFT_TO_RIGHT = 1
} McASMTrkPosAbsSegCntDirEnum;

typedef enum McASMSegPosRelToEnum
{	mcASMSPRT_ST_OF_SEG = 0,
	mcASMSPRT_END_OF_SEG = 1
} McASMSegPosRelToEnum;

typedef enum McASMCSSActSegSimOnPLCEnum
{	mcASMCSSASSOP_OFF = 0,
	mcASMCSSASSOP_ON = 1
} McASMCSSActSegSimOnPLCEnum;

typedef enum McASMCSSStopReacEnum
{	mcASMCSSSR_INDUCT_HALT = 0,
	mcASMCSSSR_COAST_TO_STANDSTILL = 1
} McASMCSSStopReacEnum;

typedef enum McASMCSSSpdFltrEnum
{	mcASMCSSSF_NOT_USE = 0,
	mcASMCSSSF_LP_1ST_ORD = 1
} McASMCSSSpdFltrEnum;

typedef enum McASMCSSCPAPSEnum
{	mcASMCSSCPAPS_NOT_USE = 0,
	mcASMCSSCPAPS_USE = 1
} McASMCSSCPAPSEnum;

typedef enum McASMCSSCPAPSUseParSetCtrlEnum
{	mcASMCSSCPAPSUPSC_USE_DEF_VAL = 0,
	mcASMCSSCPAPSUPSC_USE_EXP_VAL = 1
} McASMCSSCPAPSUseParSetCtrlEnum;

typedef enum McASMCSSCPAPSUPSMoveErrLimEnum
{	mcASMCSSCPAPSUPSMEL_USE_DEF_VAL = 0,
	mcASMCSSCPAPSUPSMEL_USE_EXP_VAL = 1
} McASMCSSCPAPSUPSMoveErrLimEnum;

typedef enum McASMCSSScpErrReacEnum
{	mcASMCSSSER_ASM = 0,
	mcASMCSSSER_SEG = 1
} McASMCSSScpErrReacEnum;

typedef enum McASMShMagnPltCfgShTypEnum
{	mcASMSMPCST_ST8F1SA100 = 0,
	mcASMSMPCST_ST8F1SA102 = 1,
	mcASMSMPCST_ST8F1SA104 = 2,
	mcASMSMPCST_ST8F1SA106 = 3,
	mcASMSMPCST_ST8F1SA201 = 4,
	mcASMSMPCST_ST8F1SA203 = 5,
	mcASMSMPCST_ST8F1SB308 = 6
} McASMShMagnPltCfgShTypEnum;

typedef enum McASMShColAvStratEnum
{	mcASMSCAS_CONST = 0,
	mcASMSCAS_VAR = 1,
	mcASMSCAS_ADV_CONST = 2,
	mcASMSCAS_ADV_VAR = 3
} McASMShColAvStratEnum;

typedef enum McASMVisProcTskCEnum
{	mcASMVPTC_CYC_1 = 1,
	mcASMVPTC_CYC_2 = 2,
	mcASMVPTC_CYC_3 = 3,
	mcASMVPTC_CYC_4 = 4,
	mcASMVPTC_CYC_5 = 5,
	mcASMVPTC_CYC_6 = 6,
	mcASMVPTC_CYC_7 = 7,
	mcASMVPTC_CYC_8 = 8
} McASMVisProcTskCEnum;

typedef enum McAFSSDShOnSecOrientEnum
{	mcAFSSDSOSO_POS = 0,
	mcAFSSDSOSO_NEG = 1
} McAFSSDShOnSecOrientEnum;

typedef enum McAFSSDShOnSecDefEnum
{	mcAFSSDSOSD_SNG_SH = 0,
	mcAFSSDSOSD_SET_OF_SH = 1
} McAFSSDShOnSecDefEnum;

typedef enum McAFSTShTrcCfgSecRstEnum
{	mcAFSTSTCSR_ON = 0,
	mcAFSTSTCSR_OFF = 1
} McAFSTShTrcCfgSecRstEnum;

typedef enum McAFSAAPrioOrientEnum
{	mcAFSAAPO_KEEP_SEG_ORIENT = 0,
	mcAFSAAPO_POS = 1,
	mcAFSAAPO_NEG = 2
} McAFSAAPrioOrientEnum;

typedef enum McAFLLScpEnum
{	mcAFLLS_ALL_SH = 0,
	mcAFLLS_SNG_SH = 1
} McAFLLScpEnum;

typedef enum McAFLLLocEnum
{	mcAFLLL_SEC = 0,
	mcAFLLL_CRV_AREA = 1,
	mcAFLLL_DUALTRK_AREA = 2
} McAFLLLocEnum;

typedef enum McAFLLMotLimVelEnum
{	mcAFLLMLV_NOT_USE = 0,
	mcAFLLMLV_BASIC = 1,
	mcAFLLMLV_ADV = 2
} McAFLLMotLimVelEnum;

typedef enum McAFLLMotLimAccEnum
{	mcAFLLMLA_NOT_USE = 0,
	mcAFLLMLA_BASIC = 1,
	mcAFLLMLA_ADV = 2
} McAFLLMotLimAccEnum;

typedef enum McAFESExFromEnum
{	mcAFESEF_ASM_PWR_ON = 0
} McAFESExFromEnum;

typedef enum McSCSegPosRelToEnum
{	mcSCSPRT_ST_OF_SEG = 0,
	mcSCSPRT_END_OF_SEG = 1
} McSCSegPosRelToEnum;

typedef enum McSSStPosRelToEnum
{	mcSSSPRT_ST_OF_SEC = 0,
	mcSSSPRT_END_OF_SEC = 1
} McSSStPosRelToEnum;

typedef enum McSSDirEnum
{	mcSSD_POS = 0,
	mcSSD_NEG = 1
} McSSDirEnum;

typedef enum McSSTMeasUnitEnum
{	mcSSTMU_M = 5067858
} McSSTMeasUnitEnum;

typedef enum McSSTMoveLimEnum
{	mcSSTML_INT = 0
} McSSTMoveLimEnum;

typedef enum McSSTMoveLimIntVelEnum
{	mcSSTMLIV_BASIC = 0
} McSSTMoveLimIntVelEnum;

typedef enum McSSTMoveLimIntAccEnum
{	mcSSTMLIA_BASIC = 0
} McSSTMoveLimIntAccEnum;

typedef enum McSSTMoveLimIntDecEnum
{	mcSSTMLID_BASIC = 0
} McSSTMoveLimIntDecEnum;

typedef enum McSSTMoveLimIntUpdModEnum
{	mcSSTMLIUM_IMMED = 0,
	mcSSTMLIUM_AVOID_ERR_STOP = 1
} McSSTMoveLimIntUpdModEnum;

typedef enum McSSTJerkFltrEnum
{	mcSSTJF_USE = 0,
	mcSSTJF_NOT_USE = 1
} McSSTJerkFltrEnum;

typedef enum McSSTCAIMDEnum
{	mcSSTCAIMD_USE_MAX_DIM = 0,
	mcSSTCAIMD_USE_EXP_VAL = 1
} McSSTCAIMDEnum;

typedef enum McSEGSegSecDirEnum
{	mcSEGSSD_POS = 0,
	mcSEGSSD_NEG = 1
} McSEGSegSecDirEnum;

typedef enum McSEGElongationCompEnum
{	mcSEGEC_USE_ASM_SET = 0,
	mcSEGEC_INACT = 1,
	mcSEGEC_ACT = 2
} McSEGElongationCompEnum;

typedef enum McSEGStopReacEnum
{	mcSEGSR_USE_ASM_SET = 0,
	mcSEGSR_INDUCT_HALT = 1,
	mcSEGSR_COAST_TO_STANDSTILL = 2
} McSEGStopReacEnum;

typedef enum McSEGSpdFltrEnum
{	mcSEGSF_USE_ASM_SET = 0,
	mcSEGSF_NOT_USE = 1,
	mcSEGSF_LP_1ST_ORD = 2
} McSEGSpdFltrEnum;

typedef struct McInternalAssemblyIfType
{	plcdword vtable;
} McInternalAssemblyIfType;

typedef struct McAssemblyType
{	struct McInternalAssemblyIfType* controlif;
} McAssemblyType;

typedef struct McInternalSegmentIfType
{	plcdword vtable;
} McInternalSegmentIfType;

typedef struct McSegmentType
{	struct McInternalSegmentIfType* controlif;
} McSegmentType;

typedef struct McInternalSectorIfType
{	plcdword vtable;
} McInternalSectorIfType;

typedef struct McSectorType
{	struct McInternalSectorIfType* controlif;
} McSectorType;

typedef struct McInternalProcessPointIfType
{	plcdword vtable;
} McInternalProcessPointIfType;

typedef struct McProcessPointType
{	struct McInternalProcessPointIfType* controlif;
} McProcessPointType;

typedef struct McAcpTrakSegProcessParIDType
{	unsigned short ParID;
	unsigned long VariableAddress;
	enum McAcpTrakSegDataTypeEnum DataType;
} McAcpTrakSegProcessParIDType;

typedef struct McAcpTrakRouteTransitPointsType
{	struct McSectorType* Sector;
	double Position;
	enum McDirectionEnum TransitDirection;
} McAcpTrakRouteTransitPointsType;

typedef struct McAcpTrakAdvRouteParType
{	enum McDirectionEnum StartDirection;
	enum McDirectionEnum EndDirection;
	enum McDirectionEnum ShuttleOrientation;
	struct McAcpTrakRouteTransitPointsType* TransitPoints;
	unsigned short NumberOfTransitPoints;
	enum McAcpTrakRoutePosRelToEnum PosRelativeTo;
} McAcpTrakAdvRouteParType;

typedef struct McAcpTrakShManeuverInfoType
{	enum McAcpTrakShManeuverTypeEnum Type;
	enum McAcpTrakShManeuverReasonEnum Reason;
} McAcpTrakShManeuverInfoType;

typedef struct McAcpTrakSegPositionType
{	struct McSegmentType Segment;
	plcstring Name[33];
	double Position;
} McAcpTrakSegPositionType;

typedef struct McAcpTrakShCurrentValuesType
{	double Position;
	double ActualPosition;
	double ModuloPosition;
	double ActualModuloPosition;
	struct McSectorType Sector;
	plcstring SectorName[33];
	enum McAcpTrakSecTypeEnum SectorType;
	double SectorLength;
	enum McDirectionEnum Orientation;
	float Velocity;
	float Acceleration;
	struct McAcpTrakSegPositionType SegmentPosition;
	enum McAcpTrakShMovementTypeEnum MovementType;
	unsigned char CtrlParSetLeft;
	unsigned char CtrlParSetRight;
} McAcpTrakShCurrentValuesType;

typedef struct McAcpTrakShRouteDestInfoType
{	double Position;
	struct McSectorType Sector;
	plcstring SectorName[33];
	enum McAcpTrakSecTypeEnum SectorType;
	float VelocityAtDestination;
	double TotalDistance;
	double RemainingDistance;
} McAcpTrakShRouteDestInfoType;

typedef struct McAcpTrakShLifeCycleInfoType
{	double AbsoluteMovementDistance;
} McAcpTrakShLifeCycleInfoType;

typedef struct McAcpTrakShSegSetValuesType
{	plcbit Valid;
	plcstring SegmentName[33];
	double Position;
	unsigned char Channel;
	enum McAcpTrakFieldModeEnum FieldMode;
	unsigned short SegmentID;
} McAcpTrakShSegSetValuesType;

typedef struct McAcpTrakShSegCurrentValuesType
{	plcbit Valid;
	plcstring SegmentName[33];
	double Position;
} McAcpTrakShSegCurrentValuesType;

typedef struct McAcpTrakShConvoyInfoType
{	struct McAxisType ConvoyMaster;
	struct McAxisType ReferenceShuttle;
} McAcpTrakShConvoyInfoType;

typedef struct McAcpTrakShAddInfoType
{	unsigned short ID;
	enum McAxisPLCopenStateEnum PLCopenState;
	plcbit Controllable;
	enum McAcpTrakShErrorReasonEnum ErrorReason;
} McAcpTrakShAddInfoType;

typedef struct McAcpTrakShInfoType
{	struct McAcpTrakShCurrentValuesType CurrentValues;
	struct McAcpTrakShRouteDestInfoType RouteDestinationInfo;
	struct McAcpTrakShManeuverInfoType ManeuverInfo;
	struct McAcpTrakShLifeCycleInfoType LifeCycleInfo;
	struct McAcpTrakShConvoyInfoType ConvoyInfo;
	struct McAcpTrakShAddInfoType AdditionalInfo;
} McAcpTrakShInfoType;

typedef struct McAcpTrakShSegmentInfoType
{	struct McAcpTrakShSegSetValuesType SegmentSetValues[4];
	struct McAcpTrakShSegCurrentValuesType SegmentCurrentValues[4];
} McAcpTrakShSegmentInfoType;

typedef struct McAcpTrakSecPositionType
{	struct McSectorType Sector;
	plcstring Name[33];
	double Position;
} McAcpTrakSecPositionType;

typedef struct McAcpTrakShRecoveryInfoType
{	struct McAcpTrakSecPositionType SectorPosition;
	plcbit OnSector;
	struct McAcpTrakSecPositionType Destination;
	struct McAcpTrakSegPositionType SegmentPosition;
} McAcpTrakShRecoveryInfoType;

typedef struct McAcpTrakShErrorShuttleInfoType
{	struct McAxisType Shuttle;
	struct McAcpTrakSegPositionType SegmentPosition;
} McAcpTrakShErrorShuttleInfoType;

typedef struct McAcpTrakShErrorBarrierInfoType
{	enum McAcpTrakBarrierTypeEnum BarrierType;
	struct McProcessPointType ProcessPoint;
	plcstring Name[33];
	enum McAcpTrakBarrierStatusEnum Status;
} McAcpTrakShErrorBarrierInfoType;

typedef struct McAcpTrakShErrorLocLimitInfoType
{	plcstring Name[33];
	float VelocityLimit;
	float AccelerationLimit;
	plcbit InRange;
} McAcpTrakShErrorLocLimitInfoType;

typedef struct McAcpTrakShErrorConvoyInfoType
{	struct McAxisType ConvoyMaster;
	struct McAxisType Shuttle;
} McAcpTrakShErrorConvoyInfoType;

typedef struct McAcpTrakShErrorManeuverInfoType
{	enum McAcpTrakShManeuverReasonEnum Reason;
	struct McAcpTrakShErrorShuttleInfoType ShuttleManInfo;
	struct McAcpTrakShErrorBarrierInfoType BarrierManInfo;
	struct McAcpTrakShErrorLocLimitInfoType LocalLimitManInfo;
	struct McAcpTrakShErrorConvoyInfoType ConvoyManInfo;
} McAcpTrakShErrorManeuverInfoType;

typedef struct McAcpTrakShErrorEncdiffInfoType
{	double Difference;
	struct McAcpTrakSegPositionType LowPosition;
	struct McAcpTrakSegPositionType HighPosition;
} McAcpTrakShErrorEncdiffInfoType;

typedef struct McAcpTrakShErrorGripperInfoType
{	struct McSegmentType Segment;
	plcstring SegmentName[33];
} McAcpTrakShErrorGripperInfoType;

typedef struct McAcpTrakShErrorSegmentInfoType
{	struct McSegmentType Segment;
	plcstring SegmentName[33];
} McAcpTrakShErrorSegmentInfoType;

typedef struct McAcpTrakShErrorInfoType
{	struct McAcpTrakSegPositionType SegmentPosition;
	float Velocity;
	float Acceleration;
	enum McAcpTrakShErrorReasonEnum Reason;
	struct McAcpTrakShErrorManeuverInfoType ManeuverErrorInfo;
	struct McAcpTrakShErrorEncdiffInfoType EncdiffErrorInfo;
	struct McAcpTrakShErrorGripperInfoType GripperErrorInfo;
	struct McAcpTrakShErrorSegmentInfoType SegmentErrorInfo;
} McAcpTrakShErrorInfoType;

typedef struct McAcpTrakShResizeParamType
{	enum McAcpTrakShResizeModeEnum Mode;
	double ExtentToFront;
	double ExtentToBack;
	double Width;
} McAcpTrakShResizeParamType;

typedef struct McAcpTrakShSizeInfoType
{	double ExtentToFront;
	double ExtentToBack;
	double Width;
} McAcpTrakShSizeInfoType;

typedef struct McAcpTrakShuttleMonData
{	plcbit Available;
	struct McPosType Position;
	struct McOrientType Orientation;
	double ExtentToFront;
	double ExtentToBack;
	double Width;
	unsigned long UserData;
	unsigned short Index;
} McAcpTrakShuttleMonData;

typedef struct McAcpTrakAssemblyMonData
{	struct McAcpTrakShuttleMonData Shuttle[150];
} McAcpTrakAssemblyMonData;

typedef struct McAcpTrakShuttleVisData
{	plcbit Available;
	unsigned char Reserved[3];
	float PositionX;
	float PositionY;
	float RotationZ;
	plcstring Text[32];
	float ColorRed;
	float ColorGreen;
	float ColorBlue;
	float ExtentToFront;
	float ExtentToBack;
	float Width;
} McAcpTrakShuttleVisData;

typedef struct McAcpTrakAssemblyVisData
{	struct McAcpTrakShuttleVisData Shuttle[150];
} McAcpTrakAssemblyVisData;

typedef struct McAcpTrakSegInfoType
{	plcbit CommunicationReady;
	plcbit ReadyForPowerOn;
	plcbit PowerOn;
	unsigned long StartupCount;
	enum McCommunicationStateEnum CommunicationState;
} McAcpTrakSegInfoType;

typedef struct McAcpTrakSegErrorGripperInfoType
{	struct McAxisType Shuttle;
} McAcpTrakSegErrorGripperInfoType;

typedef struct McAcpTrakSegErrorInfoType
{	enum McAcpTrakSegErrorReasonEnum Reason;
	struct McAcpTrakSegErrorGripperInfoType GripperErrorInfo;
} McAcpTrakSegErrorInfoType;

typedef struct McAcpTrakProcPointGetInfoType
{	struct McAcpTrakSecPositionType SectorPosition;
} McAcpTrakProcPointGetInfoType;

typedef struct McAcpTrakTrgPointGetInfoType
{	struct McAxisType Axis;
	enum McAcpTrakTrgPointEventEnum Event;
	plcbit ShuttleControlled;
	struct McAxisType ConvoyMaster;
} McAcpTrakTrgPointGetInfoType;

typedef struct McAcpTrakBarrierInfoType
{	enum McAcpTrakBarrierStatusEnum Status;
	unsigned long RemainingTickets;
} McAcpTrakBarrierInfoType;

typedef struct McAcpTrakAdvBarrierParType
{	signed long TicketCount;
} McAcpTrakAdvBarrierParType;

typedef struct McAcpTrakSegmentPosition
{	signed short Index;
	double Position;
} McAcpTrakSegmentPosition;

typedef struct McAcpTrakShuttleEncoderPosition
{	plcbit Available;
	struct McAcpTrakSegmentPosition SegPos[4];
	double ActPosition;
	double DesPosition;
} McAcpTrakShuttleEncoderPosition;

typedef struct McAcpTrakShuttleEncoderMonitor
{	struct McAcpTrakShuttleEncoderPosition ShuttleEncPos[32];
} McAcpTrakShuttleEncoderMonitor;

typedef struct McAcpTrakAsmGetInfoType
{	enum McAcpTrakSimulationOnPlcEnum SimulationOnPlcMode;
} McAcpTrakAsmGetInfoType;

typedef struct McAcpTrakSegGetInfoType
{	plcstring Name[33];
	unsigned short ID;
	enum McAcpTrakSegTypeEnum Type;
	double Length;
	unsigned long NodeNumber;
	plcstring PlkInterface[33];
	unsigned char ChannelCount;
	struct McFrameType StartFrame;
	struct McFrameType EndFrame;
} McAcpTrakSegGetInfoType;

typedef struct McAcpTrakSecGetInfoType
{	double Length;
	plcbit SectorClosed;
	plcstring Name[33];
	enum McAcpTrakSecTypeEnum Type;
} McAcpTrakSecGetInfoType;

typedef struct McAcpTrakAdvSecAddShWithMovType
{	enum McAcpTrakMoveCmdEnum MoveCmd;
	double Position;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McDirectionEnum Direction;
} McAcpTrakAdvSecAddShWithMovType;

typedef struct McAcpTrakSecAddShWithMovInfoType
{	enum McAxisPLCopenStateEnum PLCopenState;
} McAcpTrakSecAddShWithMovInfoType;

typedef struct McAcpTrakAdvSecAddShParType
{	float Velocity;
	enum McDirectionEnum Orientation;
	float Deceleration;
} McAcpTrakAdvSecAddShParType;

typedef struct McAcpTrakAsmInfoType
{	plcbit CommunicationReady;
	plcbit ReadyForPowerOn;
	plcbit PowerOn;
	unsigned long StartupCount;
	unsigned short SegmentsInDisabledCount;
	unsigned short SegmentsInStoppingCount;
	unsigned short SegmentsInErrorStopCount;
	unsigned short ShuttlesCount;
	unsigned short ShuttlesInStandstillCount;
	unsigned short ShuttlesInDisabledCount;
	unsigned short ShuttlesInStoppingCount;
	unsigned short ShuttlesInErrorStopCount;
	unsigned short ConvoysCount;
} McAcpTrakAsmInfoType;

typedef struct McAcpTrakAsmErrorEncdiffInfoType
{	double Difference;
	struct McAcpTrakSegPositionType LowPosition;
	struct McAcpTrakSegPositionType HighPosition;
} McAcpTrakAsmErrorEncdiffInfoType;

typedef struct McAcpTrakAsmErrorGripperInfoType
{	struct McAxisType Shuttle;
	struct McSegmentType Segment;
	plcstring SegmentName[33];
} McAcpTrakAsmErrorGripperInfoType;

typedef struct McAcpTrakAsmErrorSegmentInfoType
{	struct McSegmentType Segment;
	plcstring SegmentName[33];
} McAcpTrakAsmErrorSegmentInfoType;

typedef struct McAcpTrakAsmErrorInfoType
{	enum McAcpTrakAsmErrorReasonEnum Reason;
	struct McAcpTrakAsmErrorEncdiffInfoType EncdiffErrorInfo;
	struct McAcpTrakAsmErrorGripperInfoType GripperErrorInfo;
	struct McAcpTrakAsmErrorSegmentInfoType SegmentErrorInfo;
} McAcpTrakAsmErrorInfoType;

typedef struct McAcpTrakAdvAsmGetShParType
{	enum McAcpTrakGetShuttleModeEnum SelectionMode;
} McAcpTrakAdvAsmGetShParType;

typedef struct McAcpTrakAsmGetShAddInfoType
{	unsigned short ShuttleID;
} McAcpTrakAsmGetShAddInfoType;

typedef struct McAcpTrakAdvAsmGetSegParType
{	enum McAcpTrakGetSegmentModeEnum SelectionMode;
} McAcpTrakAdvAsmGetSegParType;

typedef struct McAcpTrakAdvAsmGetSecParType
{	enum McAcpTrakGetSectorModeEnum SelectionMode;
} McAcpTrakAdvAsmGetSecParType;

typedef struct McAcpTrakAdvSecGetShParType
{	enum McAcpTrakGetShuttleModeEnum SelectionMode;
	double StartPosition;
	double EndPosition;
} McAcpTrakAdvSecGetShParType;

typedef struct McAcpTrakSecGetShAddInfoType
{	unsigned short ShuttleID;
	double Position;
	enum McDirectionEnum Orientation;
} McAcpTrakSecGetShAddInfoType;

typedef struct McAcpTrakAdvBarrierGetShParType
{	enum McAcpTrakBarrierGetShModeEnum SelectionMode;
} McAcpTrakAdvBarrierGetShParType;

typedef struct McAcpTrakBarrierGetShInfoType
{	unsigned short ShuttleID;
	double Distance;
} McAcpTrakBarrierGetShInfoType;

typedef struct McAcpTrakSecInfoType
{	unsigned short ShuttlesCount;
	unsigned short ShuttlesInStandstillCount;
	unsigned short ShuttlesInDisabledCount;
	unsigned short ShuttlesInStoppingCount;
	unsigned short ShuttlesInErrorStopCount;
	unsigned short ConvoysCount;
} McAcpTrakSecInfoType;

typedef struct McAcpTrakAdvGetMinShDistParType
{	enum McAcpTrakShRelativeRefPointEnum MeasurePointsMode;
	struct McAxisType* Shuttle1;
	struct McAxisType* Shuttle2;
} McAcpTrakAdvGetMinShDistParType;

typedef struct McAcpTrakAsmGetMinShDistType
{	double Curve;
	double Junction;
	double Straight;
} McAcpTrakAsmGetMinShDistType;

typedef struct McAcpTrakConvoyParType
{	double PositiveOffset;
	double NegativeOffset;
	plcbit Elastic;
	plcbit Separable;
} McAcpTrakConvoyParType;

typedef struct McAcpTrakShConvoyParType
{	struct McAxisType* ReferenceShuttle;
	enum McAcpTrakCouplingModeEnum CouplingMode;
	plcbit Elastic;
} McAcpTrakShConvoyParType;

typedef struct McAcpTrakAdvShConvoyParType
{	double TargetDistance;
	float Velocity;
	float Acceleration;
	float Deceleration;
} McAcpTrakAdvShConvoyParType;

typedef struct McAcpTrakAdvShRemoveConParType
{	float Deceleration;
} McAcpTrakAdvShRemoveConParType;

typedef struct McAcpTrakAdvConDeleteParType
{	enum McAcpTrakConDeleteModeEnum Mode;
} McAcpTrakAdvConDeleteParType;

typedef struct McAcpTrakConInfoType
{	unsigned short ShuttleCount;
	double ActualPositiveOffset;
	double ActualNegativeOffset;
} McAcpTrakConInfoType;

typedef struct McAcpTrakAdvConGetShParType
{	enum McAcpTrakConGetShuttleModeEnum Mode;
} McAcpTrakAdvConGetShParType;

typedef struct McAcpTrakConGetShAddInfoType
{	unsigned short ShuttleID;
	double Position;
	enum McDirectionEnum Orientation;
} McAcpTrakConGetShAddInfoType;

typedef struct McAcpTrakShSwitchSecInfoType
{	double Position;
	enum McDirectionEnum Orientation;
} McAcpTrakShSwitchSecInfoType;

typedef struct McAcpTrakAdvShSwitchSecParType
{	float Deceleration;
	double StartPosition;
	double EndPosition;
} McAcpTrakAdvShSwitchSecParType;

typedef struct McAcpTrakShReadSecPosInfoType
{	double Position;
	enum McDirectionEnum Orientation;
} McAcpTrakShReadSecPosInfoType;

typedef struct McAcpTrakAdvShReadSecPosParType
{	double StartPosition;
	double EndPosition;
} McAcpTrakAdvShReadSecPosParType;

typedef struct McAcpTrakAdvShCamAutCmdParType
{	plcbit Elastic;
	float Deceleration;
} McAcpTrakAdvShCamAutCmdParType;

typedef struct McAcpTrakShCamAutCmdCommandsType
{	plcbit Start;
	plcbit Stop;
	plcbit Restart;
	plcbit EndAutomat;
	plcbit SetSignal1;
	plcbit SetSignal2;
	plcbit SetSignal3;
	plcbit SetSignal4;
	plcbit ResetSignal1;
	plcbit ResetSignal2;
	plcbit ResetSignal3;
	plcbit ResetSignal4;
} McAcpTrakShCamAutCmdCommandsType;

typedef struct McAcpTrakShCamAutCmdInfoType
{	plcbit Running;
	plcbit StandBy;
	unsigned char ActualStateIndex;
	unsigned short ActualStateCamIndex;
	plcbit InCam;
	plcbit InCompensation;
	plcbit InPosition;
} McAcpTrakShCamAutCmdInfoType;

typedef struct McAcpTrakAdvSecStopParType
{	enum McStopModeEnum StopMode;
	double StartPosition;
	double EndPosition;
} McAcpTrakAdvSecStopParType;

typedef struct McAcpTrakDiverterInfoType
{	struct McAcpTrakSegPositionType SegmentPosition1;
	struct McAcpTrakSegPositionType SegmentPosition2;
} McAcpTrakDiverterInfoType;

typedef struct McASMTrkSegType
{	struct McCfgUnboundedArrayType SegmentReference;
} McASMTrkSegType;

typedef struct McASMTrkPosAbsType
{	plcstring SegmentReference[251];
	enum McASMTrkPosAbsSegCntDirEnum SegmentCountDirection;
	double Position;
	enum McASMSegPosRelToEnum PositionRelativeTo;
	struct McCfgTransXYZType Translation;
	struct McCfgOrientType Orientation;
} McASMTrkPosAbsType;

typedef struct McASMSegType
{	plcstring SegmentReference[251];
	double Position;
	enum McASMSegPosRelToEnum PositionRelativeTo;
} McASMSegType;

typedef struct McASMTrkPosRelOneType
{	struct McASMSegType SegmentTrack;
	struct McASMSegType SegmentExistingTrack;
} McASMTrkPosRelOneType;

typedef struct McASMTrkPosRelTwoAlignType
{	plcstring SegmentRefTrack[251];
	plcstring SegmentRefExistingTrack[251];
} McASMTrkPosRelTwoAlignType;

typedef struct McASMTrkPosRelTwoType
{	struct McASMTrkPosRelTwoAlignType AlignmentFirst;
	struct McASMTrkPosRelTwoAlignType AlignmentSecond;
} McASMTrkPosRelTwoType;

typedef struct McASMTrkPosType
{	enum McASMTrkPosEnum Type;
	struct McASMTrkPosAbsType Absolute;
	struct McASMTrkPosRelOneType RelativeToOneSegment;
	struct McASMTrkPosRelTwoType RelativeToTwoSegments;
} McASMTrkPosType;

typedef struct McASMTrkType
{	struct McASMTrkSegType Segments;
	struct McASMTrkPosType Position;
} McASMTrkType;

typedef struct McASMTrksType
{	double TrackSeparation;
	struct McCfgUnboundedArrayType Track;
} McASMTrksType;

typedef struct McASMCSSStopReacType
{	enum McASMCSSStopReacEnum Type;
} McASMCSSStopReacType;

typedef struct McASMCSSSpdFltrLP1stOrdType
{	float FilterTime;
} McASMCSSSpdFltrLP1stOrdType;

typedef struct McASMCSSSpdFltrType
{	enum McASMCSSSpdFltrEnum Type;
	struct McASMCSSSpdFltrLP1stOrdType Lowpass1stOrder;
} McASMCSSSpdFltrType;

typedef struct McASMCSSCtrlSetPosType
{	float ProportionalGain;
} McASMCSSCtrlSetPosType;

typedef struct McASMCSSCtrlSetSpdType
{	float ProportionalGain;
	float IntegrationTime;
} McASMCSSCtrlSetSpdType;

typedef struct McASMCSSCtrlSetFFwdType
{	float TotalMass;
	float ForcePositive;
	float ForceNegative;
	float SpeedForceFactor;
	float ForceLoad;
} McASMCSSCtrlSetFFwdType;

typedef struct McASMCSSCtrlSetType
{	struct McASMCSSCtrlSetPosType Position;
	struct McASMCSSCtrlSetSpdType Speed;
	struct McASMCSSCtrlSetFFwdType FeedForward;
} McASMCSSCtrlSetType;

typedef struct McASMCSSMoveErrLimType
{	double PositionError;
	double VelocityError;
} McASMCSSMoveErrLimType;

typedef struct McASMCSSCPDPSType
{	struct McASMCSSCtrlSetType Controller;
	struct McASMCSSMoveErrLimType MovementErrorLimits;
} McASMCSSCPDPSType;

typedef struct McASMCSSCPAPSUseParSetCtrlType
{	enum McASMCSSCPAPSUseParSetCtrlEnum Type;
	struct McASMCSSCtrlSetType UseExplicitValues;
} McASMCSSCPAPSUseParSetCtrlType;

typedef struct McASMCSSCPAPSUPSMoveErrLimType
{	enum McASMCSSCPAPSUPSMoveErrLimEnum Type;
	struct McASMCSSMoveErrLimType UseExplicitValues;
} McASMCSSCPAPSUPSMoveErrLimType;

typedef struct McASMCSSCPAPSUseParSetType
{	struct McASMCSSCPAPSUseParSetCtrlType Controller;
	struct McASMCSSCPAPSUPSMoveErrLimType MovementErrorLimits;
} McASMCSSCPAPSUseParSetType;

typedef struct McASMCSSCPAPSUseType
{	struct McCfgUnboundedArrayType ParameterSet;
} McASMCSSCPAPSUseType;

typedef struct McASMCSSCPAPSType
{	enum McASMCSSCPAPSEnum Type;
	struct McASMCSSCPAPSUseType Used;
} McASMCSSCPAPSType;

typedef struct McASMCSSCtrlParType
{	struct McASMCSSCPDPSType DefaultParameterSet;
	struct McASMCSSCPAPSType AdditionalParameterSets;
} McASMCSSCtrlParType;

typedef struct McASMCSSType
{	enum McASMCSSActSegSimOnPLCEnum ActivateSegmentSimulationOnPLC;
	struct McASMCSSStopReacType StopReaction;
	struct McASMCSSSpdFltrType SpeedFilter;
	struct McASMCSSCtrlParType ControllerParameters;
	enum McASMCSSScpErrReacEnum ScopeErrorReaction;
	unsigned short ShuttleIdentificationTime;
} McASMCSSType;

typedef struct McASMShDistResType
{	double CollisionAvoidance;
	double ErrorStopAvoidance;
} McASMShDistResType;

typedef struct McASMShShSttType
{	struct McCfgUnboundedArrayType ShuttleStereotypeReference;
} McASMShShSttType;

typedef struct McASMShMagnPltCfgShTypType
{	enum McASMShMagnPltCfgShTypEnum Type;
} McASMShMagnPltCfgShTypType;

typedef struct McASMShMagnPltCfgType
{	struct McCfgUnboundedArrayType ShuttleType;
} McASMShMagnPltCfgType;

typedef struct McASMShColAvStratType
{	enum McASMShColAvStratEnum Type;
} McASMShColAvStratType;

typedef struct McASMShColAvMaxMdlDimLenType
{	double ExtentToFront;
	double ExtentToBack;
} McASMShColAvMaxMdlDimLenType;

typedef struct McASMShColAvMaxMdlDimWidType
{	double Width;
} McASMShColAvMaxMdlDimWidType;

typedef struct McASMShColAvMaxMdlDimType
{	struct McASMShColAvMaxMdlDimLenType Length;
	struct McASMShColAvMaxMdlDimWidType Width;
} McASMShColAvMaxMdlDimType;

typedef struct McASMShColAvType
{	struct McASMShColAvStratType Strategy;
	struct McASMShColAvMaxMdlDimType MaximumModelDimensions;
} McASMShColAvType;

typedef struct McASMShType
{	unsigned short MaximumCount;
	struct McASMShDistResType DistanceReserves;
	struct McASMShShSttType ShuttleStereotypes;
	struct McASMShMagnPltCfgType MagnetPlateConfigurations;
	struct McASMShColAvType CollisionAvoidance;
} McASMShType;

typedef struct McASMAsmFeatType
{	struct McCfgUnboundedArrayType AssemblyFeatureReference;
} McASMAsmFeatType;

typedef struct McASMVisType
{	plcstring MonitoringPV[251];
	enum McASMVisProcTskCEnum ProcessingTaskClass;
} McASMVisType;

typedef struct McCfgAsmType
{	struct McASMTrksType Tracks;
	struct McASMCSSType CommonSegmentSettings;
	struct McASMShType Shuttles;
	struct McASMAsmFeatType AssemblyFeatures;
	struct McASMVisType Visualization;
} McCfgAsmType;

typedef struct McAFCCplgObjType
{	plcstring Name[251];
	unsigned short ShuttleCount;
	struct McCfgReferenceType CamAutomatReference;
	struct McCfgReferenceType CamListReference;
} McAFCCplgObjType;

typedef struct McCfgAsmFeatCplgType
{	struct McCfgUnboundedArrayType CouplingObject;
} McCfgAsmFeatCplgType;

typedef struct McAFSSDShOnSecDefSngShType
{	struct McCfgUnboundedArrayType Position;
} McAFSSDShOnSecDefSngShType;

typedef struct McAFSSDShOnSecDefSetOfShType
{	double StartPosition;
	unsigned char NumberOfShuttles;
	double DistanceBetweenShuttles;
} McAFSSDShOnSecDefSetOfShType;

typedef struct McAFSSDShOnSecDefType
{	enum McAFSSDShOnSecDefEnum Type;
	struct McAFSSDShOnSecDefSngShType SingleShuttle;
	struct McAFSSDShOnSecDefSetOfShType SetOfShuttles;
} McAFSSDShOnSecDefType;

typedef struct McAFSSDShOnSecType
{	struct McCfgReferenceType SectorReference;
	enum McAFSSDShOnSecOrientEnum Orientation;
	struct McAFSSDShOnSecDefType Definition;
} McAFSSDShOnSecType;

typedef struct McCfgAsmFeatSimShDefType
{	struct McCfgUnboundedArrayType ShuttleOnSector;
} McCfgAsmFeatSimShDefType;

typedef struct McAFSTShTrcCfgType
{	unsigned short ShuttleCount;
	struct McCfgReferenceType SectorReference;
	enum McAFSTShTrcCfgSecRstEnum SectorRestricted;
} McAFSTShTrcCfgType;

typedef struct McCfgAsmFeatShTraceType
{	struct McAFSTShTrcCfgType ShuttleTraceConfiguration;
} McCfgAsmFeatShTraceType;

typedef struct McAFSAAPrioType
{	struct McCfgReferenceType SectorReference;
	enum McAFSAAPrioOrientEnum Orientation;
} McAFSAAPrioType;

typedef struct McCfgAsmFeatShAutAttType
{	struct McCfgUnboundedArrayType Priority;
} McCfgAsmFeatShAutAttType;

typedef struct McAFLLScpSngShType
{	plcstring LocalLimitName[251];
} McAFLLScpSngShType;

typedef struct McAFLLScpType
{	enum McAFLLScpEnum Type;
	struct McAFLLScpSngShType SingleShuttles;
} McAFLLScpType;

typedef struct McAFLLLocSecType
{	struct McCfgReferenceType SectorReference;
} McAFLLLocSecType;

typedef struct McAFLLLocCrvAreaType
{	float CurvatureThreshold;
} McAFLLLocCrvAreaType;

typedef struct McAFLLLocType
{	enum McAFLLLocEnum Type;
	struct McAFLLLocSecType Sector;
	struct McAFLLLocCrvAreaType CurvedArea;
} McAFLLLocType;

typedef struct McAFLLMotLimVelBasicType
{	float Velocity;
} McAFLLMotLimVelBasicType;

typedef struct McAFLLMotLimVelType
{	enum McAFLLMotLimVelEnum Type;
	struct McAFLLMotLimVelBasicType Basic;
} McAFLLMotLimVelType;

typedef struct McAFLLMotLimAccBasicType
{	float Acceleration;
} McAFLLMotLimAccBasicType;

typedef struct McAFLLMotLimAccType
{	enum McAFLLMotLimAccEnum Type;
	struct McAFLLMotLimAccBasicType Basic;
} McAFLLMotLimAccType;

typedef struct McAFLLMotLimType
{	struct McAFLLMotLimVelType Velocity;
	struct McAFLLMotLimAccType Acceleration;
} McAFLLMotLimType;

typedef struct McAFLLType
{	struct McAFLLScpType Scope;
	struct McAFLLLocType Location;
	struct McAFLLMotLimType MotionLimits;
} McAFLLType;

typedef struct McCfgAsmFeatLocLimType
{	struct McCfgUnboundedArrayType LocalLimit;
} McCfgAsmFeatLocLimType;

typedef struct McAFESExFromAsmPwrOnType
{	struct McCfgUnboundedArrayType SegmentReference;
} McAFESExFromAsmPwrOnType;

typedef struct McAFESExFromType
{	enum McAFESExFromEnum Type;
	struct McAFESExFromAsmPwrOnType AssemblyPowerOn;
} McAFESExFromType;

typedef struct McCfgAsmFeatExSegType
{	struct McAFESExFromType ExclusionFrom;
} McCfgAsmFeatExSegType;

typedef struct McAFSSRSetLenType
{	double ExtentToFront;
	double ExtentToBack;
} McAFSSRSetLenType;

typedef struct McAFSSRSetWidType
{	double Width;
} McAFSSRSetWidType;

typedef struct McAFSSRSetType
{	struct McAFSSRSetLenType Length;
	struct McAFSSRSetWidType Width;
} McAFSSRSetType;

typedef struct McCfgAsmFeatShShpRegType
{	struct McCfgUnboundedArrayType Set;
} McCfgAsmFeatShShpRegType;

typedef struct McSCSegType
{	plcstring SegmentReference[251];
	double Position;
	enum McSCSegPosRelToEnum PositionRelativeTo;
} McSCSegType;

typedef struct McSCIntmSegType
{	struct McCfgUnboundedArrayType SegmentReference;
} McSCIntmSegType;

typedef struct McCfgSecCompType
{	struct McSCSegType StartSegment;
	struct McSCIntmSegType IntermediateSegments;
	struct McSCSegType EndSegment;
} McCfgSecCompType;

typedef struct McSSStType
{	double Position;
	enum McSSStPosRelToEnum PositionRelativeTo;
} McSSStType;

typedef struct McCfgSecSubType
{	struct McCfgReferenceType SectorReference;
	struct McSSStType Start;
	double Length;
	enum McSSDirEnum Direction;
} McCfgSecSubType;

typedef struct McSSTMoveLimIntVelBasicType
{	float Velocity;
} McSSTMoveLimIntVelBasicType;

typedef struct McSSTMoveLimIntVelType
{	enum McSSTMoveLimIntVelEnum Type;
	struct McSSTMoveLimIntVelBasicType Basic;
} McSSTMoveLimIntVelType;

typedef struct McSSTMoveLimIntAccBasicType
{	float Acceleration;
} McSSTMoveLimIntAccBasicType;

typedef struct McSSTMoveLimIntAccType
{	enum McSSTMoveLimIntAccEnum Type;
	struct McSSTMoveLimIntAccBasicType Basic;
} McSSTMoveLimIntAccType;

typedef struct McSSTMoveLimIntDecBasicType
{	float Deceleration;
} McSSTMoveLimIntDecBasicType;

typedef struct McSSTMoveLimIntDecType
{	enum McSSTMoveLimIntDecEnum Type;
	struct McSSTMoveLimIntDecBasicType Basic;
} McSSTMoveLimIntDecType;

typedef struct McSSTMoveLimIntType
{	struct McSSTMoveLimIntVelType Velocity;
	struct McSSTMoveLimIntAccType Acceleration;
	struct McSSTMoveLimIntDecType Deceleration;
	enum McSSTMoveLimIntUpdModEnum UpdateMode;
} McSSTMoveLimIntType;

typedef struct McSSTMoveLimType
{	enum McSSTMoveLimEnum Type;
	struct McSSTMoveLimIntType Internal;
} McSSTMoveLimType;

typedef struct McSSTJerkFltrUseType
{	float JerkTime;
} McSSTJerkFltrUseType;

typedef struct McSSTJerkFltrType
{	enum McSSTJerkFltrEnum Type;
	struct McSSTJerkFltrUseType Used;
} McSSTJerkFltrType;

typedef struct McSSTUsrDatType
{	unsigned short Size;
} McSSTUsrDatType;

typedef struct McSSTCAIMDUseExpValLenType
{	double ExtentToFront;
	double ExtentToBack;
} McSSTCAIMDUseExpValLenType;

typedef struct McSSTCAIMDUseExpValWidType
{	double Width;
} McSSTCAIMDUseExpValWidType;

typedef struct McSSTCAIMDUseExpValType
{	struct McSSTCAIMDUseExpValLenType Length;
	struct McSSTCAIMDUseExpValWidType Width;
} McSSTCAIMDUseExpValType;

typedef struct McSSTCAIMDType
{	enum McSSTCAIMDEnum Type;
	struct McSSTCAIMDUseExpValType UseExplicitValues;
} McSSTCAIMDType;

typedef struct McSSTColAvType
{	struct McSSTCAIMDType InitialModelDimensions;
} McSSTColAvType;

typedef struct McCfgShStereoTypType
{	enum McSSTMeasUnitEnum MeasurementUnit;
	double MeasurementResolution;
	struct McSSTMoveLimType MovementLimits;
	struct McSSTJerkFltrType JerkFilter;
	struct McSSTUsrDatType UserData;
	struct McSSTColAvType CollisionAvoidance;
} McCfgShStereoTypType;

typedef struct McSEGStopReacType
{	enum McSEGStopReacEnum Type;
} McSEGStopReacType;

typedef struct McSEGSpdFltrLP1stOrdType
{	float FilterTime;
} McSEGSpdFltrLP1stOrdType;

typedef struct McSEGSpdFltrType
{	enum McSEGSpdFltrEnum Type;
	struct McSEGSpdFltrLP1stOrdType Lowpass1stOrder;
} McSEGSpdFltrType;

typedef struct McCfgSegType
{	plcstring SegmentReference[251];
	plcstring SegmentSectorReference[251];
	enum McSEGSegSecDirEnum SegmentSectorDirection;
	enum McSEGElongationCompEnum ElongationCompensation;
	struct McSEGStopReacType StopReaction;
	struct McSEGSpdFltrType SpeedFilter;
} McCfgSegType;

typedef struct MC_BR_SegCycChanSetPos_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	unsigned char ChannelIndex;
	unsigned short CyclicControlBits;
	double CyclicSetPosition;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegCycChanSetPos_AcpTrak_typ;

typedef struct MC_BR_ConGetShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* ConvoyMaster;
	struct McAcpTrakAdvConGetShParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakConGetShAddInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ConGetShuttle_AcpTrak_typ;

typedef struct MC_BR_AsmGetDiverter_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAcpTrakDiverterInfoType DiverterInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetDiverter_AcpTrak_typ;

typedef struct MC_BR_ShPowerOn_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ShPowerOn_AcpTrak_typ;

typedef struct MC_BR_ShPowerOff_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShPowerOff_AcpTrak_typ;

typedef struct MC_BR_ShShuttleCmd_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McAcpTrakShShuttleCmdEnum Command;
	struct McAxisType* Shuttle;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShShuttleCmd_AcpTrak_typ;

typedef struct MC_BR_AsmPowerOn_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_AsmPowerOn_AcpTrak_typ;

typedef struct MC_BR_AsmPowerOff_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmPowerOff_AcpTrak_typ;

typedef struct MC_BR_AsmReadStatus_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit AssemblyDisabled;
	plcbit AssemblyReady;
	plcbit AssemblyHoming;
	plcbit AssemblyStopping;
	plcbit AssemblyErrorStop;
} MC_BR_AsmReadStatus_AcpTrak_typ;

typedef struct MC_BR_AsmReset_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmReset_AcpTrak_typ;

typedef struct MC_BR_AsmCommandError_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	enum McErrorCmdEnum Command;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmCommandError_AcpTrak_typ;

typedef struct MC_BR_AsmStop_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	enum McStopModeEnum StopMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_AsmStop_AcpTrak_typ;

typedef struct MC_BR_AsmGetShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakAsmGetShAddInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetShuttle_AcpTrak_typ;

typedef struct MC_BR_AsmGetShuttleSel_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	struct McAcpTrakAdvAsmGetShParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakAsmGetShAddInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetShuttleSel_AcpTrak_typ;

typedef struct MC_BR_AsmGetSegment_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	struct McAcpTrakAdvAsmGetSegParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McSegmentType Segment;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetSegment_AcpTrak_typ;

typedef struct MC_BR_AsmGetSector_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	struct McAcpTrakAdvAsmGetSecParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McSectorType Sector;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetSector_AcpTrak_typ;

typedef struct MC_BR_AsmDeleteShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	enum McAcpTrakAsmDeleteShCmdEnum Command;
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short DeletedCount;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmDeleteShuttle_AcpTrak_typ;

typedef struct MC_BR_AsmEnable_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmEnable_AcpTrak_typ;

typedef struct MC_BR_AsmDisable_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmDisable_AcpTrak_typ;

typedef struct MC_BR_AsmReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakAsmInfoType AssemblyInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmReadInfo_AcpTrak_typ;

typedef struct MC_BR_AsmReadErrorInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakAsmErrorInfoType ErrorInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmReadErrorInfo_AcpTrak_typ;

typedef struct MC_BR_AsmGetInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakAsmGetInfoType AssemblyInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetInfo_AcpTrak_typ;

typedef struct MC_BR_AsmGetMinShDist_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAssemblyType* Assembly;
	enum McAcpTrakShRelativeAlignmentEnum Mode;
	struct McAcpTrakAdvGetMinShDistParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakAsmGetMinShDistType Distance;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_AsmGetMinShDist_AcpTrak_typ;

typedef struct MC_BR_BarrierCommand_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	enum McAcpTrakBarrierCmdEnum Command;
	struct McAcpTrakAdvBarrierParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_BarrierCommand_AcpTrak_typ;

typedef struct MC_BR_BarrierReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakBarrierInfoType BarrierInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_BarrierReadInfo_AcpTrak_typ;

typedef struct MC_BR_BarrierGetShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	struct McAcpTrakAdvBarrierGetShParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakBarrierGetShInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_BarrierGetShuttle_AcpTrak_typ;

typedef struct MC_BR_ProcPointGetInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakProcPointGetInfoType ProcPointInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ProcPointGetInfo_AcpTrak_typ;

typedef struct MC_BR_TrgPointGetInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakTrgPointGetInfoType TrgPointInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_TrgPointGetInfo_AcpTrak_typ;

typedef struct MC_BR_TrgPointEnable_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McProcessPointType* ProcessPoint;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short EventCount;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_TrgPointEnable_AcpTrak_typ;

typedef struct MC_BR_SecAddShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	double Position;
	struct McAcpTrakAdvSecAddShParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAxisType Axis;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SecAddShuttle_AcpTrak_typ;

typedef struct MC_BR_SecGetShuttle_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	enum McAcpTrakSearchModeEnum Mode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakSecGetShAddInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SecGetShuttle_AcpTrak_typ;

typedef struct MC_BR_SecGetShuttleSel_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	enum McAcpTrakSearchModeEnum Mode;
	struct McAcpTrakAdvSecGetShParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned short TotalCount;
	unsigned short RemainingCount;
	struct McAxisType Axis;
	struct McAcpTrakSecGetShAddInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Next;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SecGetShuttleSel_AcpTrak_typ;

typedef struct MC_BR_SecGetInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakSecGetInfoType SectorInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SecGetInfo_AcpTrak_typ;

typedef struct MC_BR_SecReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakSecInfoType SectorInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SecReadInfo_AcpTrak_typ;

typedef struct MC_BR_SecAddShWithMov_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	double Position;
	float Velocity;
	enum McDirectionEnum Orientation;
	struct McAcpTrakAdvSecAddShWithMovType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAxisType Axis;
	unsigned short ID;
	struct McAcpTrakSecAddShWithMovInfoType AdditionalInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit Error;
} MC_BR_SecAddShWithMov_AcpTrak_typ;

typedef struct MC_BR_SecStop_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSectorType* Sector;
	struct McAcpTrakAdvSecStopParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_SecStop_AcpTrak_typ;

typedef struct MC_BR_SegPowerOn_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_SegPowerOn_AcpTrak_typ;

typedef struct MC_BR_SegPowerOff_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegPowerOff_AcpTrak_typ;

typedef struct MC_BR_SegReset_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegReset_AcpTrak_typ;

typedef struct MC_BR_SegCommandError_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	enum McErrorCmdEnum Command;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegCommandError_AcpTrak_typ;

typedef struct MC_BR_SegProcessParID_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	unsigned long DataAddress;
	unsigned long NumberOfParIDs;
	enum McAcpTrakSegProcessParIDModeEnum Mode;
	unsigned char ChannelIndex;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegProcessParID_AcpTrak_typ;

typedef struct MC_BR_RoutedMoveVel_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McSectorType* Sector;
	double Position;
	float Velocity;
	float RouteVelocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McBufferModeEnum BufferMode;
	struct McAcpTrakAdvRouteParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit InVelocity;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
	plcbit PositionReached;
} MC_BR_RoutedMoveVel_AcpTrak_typ;

typedef struct MC_BR_RoutedMoveAbs_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McSectorType* Sector;
	double Position;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McBufferModeEnum BufferMode;
	struct McAcpTrakAdvRouteParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_RoutedMoveAbs_AcpTrak_typ;

typedef struct MC_BR_ElasticMoveAbs_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	double Position;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McBufferModeEnum BufferMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ElasticMoveAbs_AcpTrak_typ;

typedef struct MC_BR_ModuloMoveAbs_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	double Position;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McDirectionEnum Direction;
	enum McBufferModeEnum BufferMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	plcbit Elastic;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ModuloMoveAbs_AcpTrak_typ;

typedef struct MC_BR_ElasticMoveAdd_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	double Distance;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McBufferModeEnum BufferMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ElasticMoveAdd_AcpTrak_typ;

typedef struct MC_BR_ElasticMoveVel_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	enum McDirectionEnum Direction;
	enum McBufferModeEnum BufferMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit InVelocity;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ElasticMoveVel_AcpTrak_typ;

typedef struct MC_BR_ShCamAutCmd_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Slave;
	struct McAcpTrakAdvShCamAutCmdParType AdvancedParameters;
	struct McAcpTrakShCamAutCmdCommandsType Commands;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShCamAutCmdInfoType Info;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Ready;
} MC_BR_ShCamAutCmd_AcpTrak_typ;

typedef struct MC_BR_ShSwitchSector_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McSectorType* Sector;
	struct McAcpTrakAdvShSwitchSecParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShSwitchSecInfoType Info;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ShSwitchSector_AcpTrak_typ;

typedef struct MC_BR_ShReadSectorPos_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McSectorType* Sector;
	struct McAcpTrakAdvShReadSecPosParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShReadSecPosInfoType Info;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadSectorPos_AcpTrak_typ;

typedef struct MC_BR_ShReadRecoveryInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShRecoveryInfoType RecoveryInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadRecoveryInfo_AcpTrak_typ;

typedef struct MC_BR_ShReadSize_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShSizeInfoType SizeInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadSize_AcpTrak_typ;

typedef struct MC_BR_SegReadStatus_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit SegmentDisabled;
	plcbit SegmentReady;
	plcbit SegmentStopping;
	plcbit SegmentErrorStop;
} MC_BR_SegReadStatus_AcpTrak_typ;

typedef struct MC_BR_SegReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakSegInfoType SegmentInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegReadInfo_AcpTrak_typ;

typedef struct MC_BR_SegReadErrorInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakSegErrorInfoType ErrorInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegReadErrorInfo_AcpTrak_typ;

typedef struct MC_BR_SegGetInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McSegmentType* Segment;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakSegGetInfoType SegmentInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_SegGetInfo_AcpTrak_typ;

typedef struct MC_BR_ShReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShInfoType ShuttleInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadInfo_AcpTrak_typ;

typedef struct MC_BR_ShReadSegmentInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShSegmentInfoType SegmentInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadSegmentInfo_AcpTrak_typ;

typedef struct MC_BR_ShReadErrorInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakShErrorInfoType ErrorInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadErrorInfo_AcpTrak_typ;

typedef struct MC_BR_ShReadFrame_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	unsigned long CoordSystem;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McFrameType Frame;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShReadFrame_AcpTrak_typ;

typedef struct MC_BR_ShCopyUserData_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	unsigned long DataAddress;
	unsigned long DataSize;
	enum McAcpTrakCopyUserDataModeEnum Mode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShCopyUserData_AcpTrak_typ;

typedef struct MC_BR_ShSelCtrlParSet_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McAcpTrakSelectShSideEnum Mode;
	unsigned char ParameterSetIndex;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShSelCtrlParSet_AcpTrak_typ;

typedef struct MC_BR_ShResize_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McAcpTrakShResizeCmdEnum Command;
	struct McAcpTrakShResizeParamType ResizeParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShResize_AcpTrak_typ;

typedef struct MC_BR_ElasticMoveCycPos_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McIplModeEnum InterpolationMode;
	struct McAdvMoveCycParType AdvancedParameters;
	double CyclicPosition;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit InCyclicPosition;
} MC_BR_ElasticMoveCycPos_AcpTrak_typ;

typedef struct MC_BR_ShCouplingObjCmd_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McAcpTrakCouplingObjCmdEnum Command;
	plcstring CouplingObjectName[33];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShCouplingObjCmd_AcpTrak_typ;

typedef struct MC_BR_ShLocalLimitCmd_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	enum McAcpTrakShLocalLimitCmdEnum Command;
	plcstring LocalLimitName[33];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShLocalLimitCmd_AcpTrak_typ;

typedef struct MC_BR_ShCreateConvoy_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McAcpTrakConvoyParType Parameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ShCreateConvoy_AcpTrak_typ;

typedef struct MC_BR_ShMoveInConvoy_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McAcpTrakShConvoyParType Parameters;
	struct McAcpTrakAdvShConvoyParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalTwoRefType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ShMoveInConvoy_AcpTrak_typ;

typedef struct MC_BR_ConReadInfo_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* ConvoyMaster;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	struct McAcpTrakConInfoType ConvoyInfo;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ConReadInfo_AcpTrak_typ;

typedef struct MC_BR_ConDelete_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* ConvoyMaster;
	struct McAcpTrakAdvConDeleteParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_ConDelete_AcpTrak_typ;

typedef struct MC_BR_ShRemoveFromConvoy_AcpTrak
{
	/* VAR_INPUT (analog) */
	struct McAxisType* Axis;
	struct McAcpTrakAdvShRemoveConParType AdvancedParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct McInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_ShRemoveFromConvoy_AcpTrak_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MC_BR_SegCycChanSetPos_AcpTrak(struct MC_BR_SegCycChanSetPos_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ConGetShuttle_AcpTrak(struct MC_BR_ConGetShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetDiverter_AcpTrak(struct MC_BR_AsmGetDiverter_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShPowerOn_AcpTrak(struct MC_BR_ShPowerOn_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShPowerOff_AcpTrak(struct MC_BR_ShPowerOff_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShShuttleCmd_AcpTrak(struct MC_BR_ShShuttleCmd_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmPowerOn_AcpTrak(struct MC_BR_AsmPowerOn_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmPowerOff_AcpTrak(struct MC_BR_AsmPowerOff_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmReadStatus_AcpTrak(struct MC_BR_AsmReadStatus_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmReset_AcpTrak(struct MC_BR_AsmReset_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmCommandError_AcpTrak(struct MC_BR_AsmCommandError_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmStop_AcpTrak(struct MC_BR_AsmStop_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetShuttle_AcpTrak(struct MC_BR_AsmGetShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetShuttleSel_AcpTrak(struct MC_BR_AsmGetShuttleSel_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetSegment_AcpTrak(struct MC_BR_AsmGetSegment_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetSector_AcpTrak(struct MC_BR_AsmGetSector_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmDeleteShuttle_AcpTrak(struct MC_BR_AsmDeleteShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmEnable_AcpTrak(struct MC_BR_AsmEnable_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmDisable_AcpTrak(struct MC_BR_AsmDisable_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmReadInfo_AcpTrak(struct MC_BR_AsmReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmReadErrorInfo_AcpTrak(struct MC_BR_AsmReadErrorInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetInfo_AcpTrak(struct MC_BR_AsmGetInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_AsmGetMinShDist_AcpTrak(struct MC_BR_AsmGetMinShDist_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_BarrierCommand_AcpTrak(struct MC_BR_BarrierCommand_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_BarrierReadInfo_AcpTrak(struct MC_BR_BarrierReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_BarrierGetShuttle_AcpTrak(struct MC_BR_BarrierGetShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ProcPointGetInfo_AcpTrak(struct MC_BR_ProcPointGetInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_TrgPointGetInfo_AcpTrak(struct MC_BR_TrgPointGetInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_TrgPointEnable_AcpTrak(struct MC_BR_TrgPointEnable_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecAddShuttle_AcpTrak(struct MC_BR_SecAddShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecGetShuttle_AcpTrak(struct MC_BR_SecGetShuttle_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecGetShuttleSel_AcpTrak(struct MC_BR_SecGetShuttleSel_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecGetInfo_AcpTrak(struct MC_BR_SecGetInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecReadInfo_AcpTrak(struct MC_BR_SecReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecAddShWithMov_AcpTrak(struct MC_BR_SecAddShWithMov_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SecStop_AcpTrak(struct MC_BR_SecStop_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegPowerOn_AcpTrak(struct MC_BR_SegPowerOn_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegPowerOff_AcpTrak(struct MC_BR_SegPowerOff_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegReset_AcpTrak(struct MC_BR_SegReset_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegCommandError_AcpTrak(struct MC_BR_SegCommandError_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegProcessParID_AcpTrak(struct MC_BR_SegProcessParID_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_RoutedMoveVel_AcpTrak(struct MC_BR_RoutedMoveVel_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_RoutedMoveAbs_AcpTrak(struct MC_BR_RoutedMoveAbs_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ElasticMoveAbs_AcpTrak(struct MC_BR_ElasticMoveAbs_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ModuloMoveAbs_AcpTrak(struct MC_BR_ModuloMoveAbs_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ElasticMoveAdd_AcpTrak(struct MC_BR_ElasticMoveAdd_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ElasticMoveVel_AcpTrak(struct MC_BR_ElasticMoveVel_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShCamAutCmd_AcpTrak(struct MC_BR_ShCamAutCmd_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShSwitchSector_AcpTrak(struct MC_BR_ShSwitchSector_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadSectorPos_AcpTrak(struct MC_BR_ShReadSectorPos_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadRecoveryInfo_AcpTrak(struct MC_BR_ShReadRecoveryInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadSize_AcpTrak(struct MC_BR_ShReadSize_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegReadStatus_AcpTrak(struct MC_BR_SegReadStatus_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegReadInfo_AcpTrak(struct MC_BR_SegReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegReadErrorInfo_AcpTrak(struct MC_BR_SegReadErrorInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_SegGetInfo_AcpTrak(struct MC_BR_SegGetInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadInfo_AcpTrak(struct MC_BR_ShReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadSegmentInfo_AcpTrak(struct MC_BR_ShReadSegmentInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadErrorInfo_AcpTrak(struct MC_BR_ShReadErrorInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShReadFrame_AcpTrak(struct MC_BR_ShReadFrame_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShCopyUserData_AcpTrak(struct MC_BR_ShCopyUserData_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShSelCtrlParSet_AcpTrak(struct MC_BR_ShSelCtrlParSet_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShResize_AcpTrak(struct MC_BR_ShResize_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ElasticMoveCycPos_AcpTrak(struct MC_BR_ElasticMoveCycPos_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShCouplingObjCmd_AcpTrak(struct MC_BR_ShCouplingObjCmd_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShLocalLimitCmd_AcpTrak(struct MC_BR_ShLocalLimitCmd_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShCreateConvoy_AcpTrak(struct MC_BR_ShCreateConvoy_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShMoveInConvoy_AcpTrak(struct MC_BR_ShMoveInConvoy_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ConReadInfo_AcpTrak(struct MC_BR_ConReadInfo_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ConDelete_AcpTrak(struct MC_BR_ConDelete_AcpTrak* inst);
_BUR_PUBLIC void MC_BR_ShRemoveFromConvoy_AcpTrak(struct MC_BR_ShRemoveFromConvoy_AcpTrak* inst);
_BUR_PUBLIC unsigned short LLMInit(signed long sysInitPhase);


#ifdef __cplusplus
};
#endif
#endif /* _MCACPTRAK_ */

