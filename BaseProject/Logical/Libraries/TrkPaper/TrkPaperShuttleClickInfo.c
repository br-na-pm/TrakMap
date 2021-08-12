
#include <bur/plctypes.h>
#include <stdint.h>
#include <AsBrStr.h>

#define TRUE 1
#define FALSE 0

#ifdef __cplusplus
	extern "C"
	{
#endif
#include "TrkPaper.h"
#ifdef __cplusplus
	};
#endif


DINT ShuttleLookup(struct TrkPaperCoreAxisLookupType* Axes, 
	char* ShuttleID,
	TrkPaperShClickInfoDataType* Data,
	struct MC_BR_ShReadInfo_AcpTrak* ShReadInfo){
	
	USINT ShuttleIndex;
	
	
	ShuttleIndex = atoi(DELETE(ShuttleID, 2, 1));
	
	if (ShuttleIndex >= trkPAPER_MAX_SHUTTLE_COUNT){
		return trkPAPER_SH_INFO_ERR_SH_CNT_EXCD;
	}
	
	if (Axes[ShuttleIndex].Present){
		
		Data->Axis = Axes[ShuttleIndex].Axis;
			
		return trkPAPER_SH_INFO_ERR_OK;
		
	}else{
		return trkPAPER_SH_INFO_ERR_INVLID_AXIS;
		
	}

}



void TrkPaperShuttleClickInfo(struct TrkPaperShuttleClickInfo* inst)
{
	switch (inst->Internal.State){
		case trkPAPER_SH_CLICK_INFO_OFF:
			//******************************************************************************** Off state
			if(inst->Enable){
				if(inst->Handle == 0){
					inst->Error = TRUE;
					inst->ErrorID = trkPAPER_SH_INFO_ERR_INVLID_HDL;
									
					inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
				}
				else{
					inst->Internal.CoreInt = (TrkPaperCoreInternalType*)inst->Handle;
					if(inst->Internal.CoreInt->TypeID != trkPAPER_CORE_CORE_TYPE_ID){
						inst->Error = TRUE;
						inst->ErrorID = trkPAPER_SH_INFO_ERR_INVLID_HDL;
										
						inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
					}
					else{
						inst->Active = TRUE;
						
						inst->Internal.Fbs.AsmGetShuttle.Assembly = inst->Internal.CoreInt->Assembly;
						
						inst->Internal.State = trkPAPER_SH_CLICK_INFO_WAIT;
					}
				}
			}
			break;
		
		
		
		case trkPAPER_SH_CLICK_INFO_WAIT:
			
			//If build table case (power on, shuttle count change) build table
			inst->Valid = FALSE;
			if(inst->Internal.CoreInt->TrakStatus->Asm.PowerOn && inst->Internal.CoreInt->TrakStatus->Asm.AssemblyReady){
				inst->Internal.State = trkPAPER_SH_BUILD_TABLE;
			}
			break;
		
		case trkPAPER_SH_CLICK_INFO_RUN:
			
			if(!inst->Internal.CoreInt->TrakStatus->Asm.PowerOn || inst->Internal.ShuttleCount != inst->Internal.CoreInt->TrakStatus->Asm.ShuttlesCount){
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_WAIT;
			}
			else if(!inst->Enable){
				inst->Active = FALSE;
				inst->Internal.State = trkPAPER_CORE_OFF;
			}
			else if(inst->Update){
				inst->Valid = FALSE;
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_LOOKUP;
			}
			
			break;
		
		case trkPAPER_SH_BUILD_TABLE:
			//Initialize Table
			brsmemset(&inst->Internal.Axes, 0, sizeof(inst->Internal.Axes));
			inst->Internal.ShuttleCount = 0;
			inst->Internal.Fbs.AsmGetShuttle.Enable = TRUE;
			
			inst->Internal.State = trkPAPER_SH_CLICK_GET_SH;
			break;
		
		case trkPAPER_SH_CLICK_GET_SH:
			//******************************************************************************** Get Shuttle state
			if(inst->Internal.Fbs.AsmGetShuttle.Error){
				inst->Error = TRUE;
				inst->ErrorID = trkPAPER_SH_INFO_ERR_INVALID_ASM;
				
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
			}
			else if(inst->Internal.Fbs.AsmGetShuttle.Valid){
				if(inst->Internal.Fbs.AsmGetShuttle.TotalCount >= trkPAPER_MAX_SHUTTLE_COUNT 
				|| inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID >= trkPAPER_MAX_SHUTTLE_COUNT){
					
					inst->Error = TRUE;
					inst->ErrorID = trkPAPER_SH_INFO_ERR_SH_CNT_EXCD;
					
					inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
				}
				else{
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Present = TRUE;
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Axis = inst->Internal.Fbs.AsmGetShuttle.Axis;
					inst->Internal.Fbs.AsmGetShuttle.Next = FALSE;
					inst->Internal.ShuttleCount++;
					
					if(inst->Internal.Fbs.AsmGetShuttle.RemainingCount == 0){
						//Done populating the lookup array, moving on
						inst->Internal.Fbs.AsmGetShuttle.Enable = FALSE;
						inst->Internal.State = trkPAPER_SH_CLICK_INFO_RUN;
					}
					else{
						inst->Internal.State = trkPAPER_SH_CLICK_GET_NEXT;
					}
				}
			}
			break;
		
		case trkPAPER_SH_CLICK_GET_NEXT:
			//******************************************************************************** Get next shuttle state
			inst->Internal.Fbs.AsmGetShuttle.Next = TRUE;
			inst->Internal.State = trkPAPER_SH_CLICK_GET_SH;
			break;
		
		
		case trkPAPER_SH_CLICK_INFO_LOOKUP:
			
			//Shuttle Lookup
			inst->ErrorID = ShuttleLookup(inst->Internal.Axes, inst->Ident, &inst->Data, &inst->Internal.Fbs.ShReadInfo);
			
			
			
			if(inst->ErrorID != trkPAPER_SH_INFO_ERR_OK){
				inst->Error = TRUE;
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
			}
			else{
				inst->Internal.Fbs.ShReadInfo.Axis = &inst->Data.Axis;
				inst->Internal.Fbs.ShReadInfo.Enable = TRUE;
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_READ;	
			}
			break;
		
		case trkPAPER_SH_CLICK_INFO_READ:
			
			if(inst->Internal.Fbs.ShReadInfo.Error){
				inst->Error = TRUE;
				inst->ErrorID = trkPAPER_SH_INFO_ERR_BAD_SH_READ;
				
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
			}else if(inst->Internal.Fbs.ShReadInfo.Valid){
				inst->Data.ShInfo = inst->Internal.Fbs.ShReadInfo.ShuttleInfo;
				inst->Valid = TRUE;
				inst->Internal.Fbs.ShReadInfo.Enable = FALSE;
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_RUN;
			}
			
			break;
			
		case trkPAPER_SH_CLICK_INFO_RESET:
			inst->Error = FALSE;
			inst->ErrorID = trkPAPER_SH_INFO_ERR_OK;
			
			//Reset FUBs
			inst->Internal.Fbs.AsmGetShuttle.Enable = FALSE;
			inst->Internal.Fbs.ShReadInfo.Enable = FALSE;
				
			inst->Internal.State = trkPAPER_SH_CLICK_INFO_OFF;
			break;
		
		case trkPAPER_SH_CLICK_INFO_ERROR:
			if(inst->ErrorReset){
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_RESET;
			}
			break;
	}
	//FB calls
	MC_BR_AsmGetShuttle_AcpTrak(&inst->Internal.Fbs.AsmGetShuttle);
	MC_BR_ShReadInfo_AcpTrak(&inst->Internal.Fbs.ShReadInfo);
}

