
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
	USINT i;
	
	ShuttleIndex = atoi((uintptr_t)ShuttleID);
	

	for (i = 0; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		if (Axes[i].ShuttleID == ShuttleIndex){
			ShReadInfo->Axis =(uintptr_t)&Axes[i].Axis;	
			return FALSE;				
		}
			
		}	return TRUE;
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
			
			//Cyclicly read shuttle data
			if(!inst->Internal.CoreInt->TrakStatus->Asm.PowerOn){
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_WAIT;
				inst->Internal.Fbs.ShReadInfo.Enable = FALSE;
				inst->Valid = FALSE;
			}
			else if(!inst->Enable){
				inst->Active = FALSE;
				inst->Valid = FALSE;
				inst->Internal.State = trkPAPER_CORE_OFF;
				inst->Internal.Fbs.ShReadInfo.Enable = FALSE;
			}
			else if(inst->Update){
				inst->Valid = FALSE;
				inst->Update = FALSE;
				inst->Internal.State = trkPAPER_SH_CLICK_INFO_LOOKUP;
				inst->Internal.Fbs.ShReadInfo.Enable = FALSE;
				inst->ErrorID = trkPAPER_SH_INFO_ERR_OK;
			}
			else if (inst->Internal.Fbs.ShReadInfo.Error) {
				inst->Valid = FALSE;
				inst->ErrorID = trkPAPER_SH_INFO_WRN_BAD_SH_READ;
			}	
			else if(inst->Internal.Fbs.ShReadInfo.Valid){
				inst->Valid = TRUE;
				inst->Data.ShInfo = inst->Internal.Fbs.ShReadInfo.ShuttleInfo;
			}
			break;
		
		case trkPAPER_SH_BUILD_TABLE:
			//Initialize Table
			brsmemset((uintptr_t)&inst->Internal.Axes, 0, sizeof(inst->Internal.Axes));
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
				if(inst->Internal.Fbs.AsmGetShuttle.TotalCount >= trkPAPER_MAX_SHUTTLE_COUNT ){			
					inst->Error = TRUE;
					inst->ErrorID = trkPAPER_SH_INFO_ERR_SH_CNT_EXCD;		
					inst->Internal.State = trkPAPER_SH_CLICK_INFO_ERROR;
				}
				//Populate Axes table for shuttle 
				inst->Internal.Axes[inst->Internal.ShuttleCount].Present = TRUE;
				inst->Internal.Axes[inst->Internal.ShuttleCount].Axis = inst->Internal.Fbs.AsmGetShuttle.Axis;
				inst->Internal.Axes[inst->Internal.ShuttleCount].ShuttleID = inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID;
				inst->Internal.Fbs.AsmGetShuttle.Next = FALSE;
				inst->Internal.ShuttleCount++;
								
				
				if(inst->Internal.Fbs.AsmGetShuttle.RemainingCount == 0 ){
					//Done populating the lookup table, moving on
					inst->Internal.Fbs.AsmGetShuttle.Enable = FALSE;
					if (inst->Internal.UpdateLookupTable ) {
						inst->Internal.State =trkPAPER_SH_CLICK_INFO_LOOKUP; 
						inst->ErrorID = trkPAPER_SH_INFO_ERR_OK;
						inst->Internal.UpdateLookupTable = FALSE;
					} 
					else{
						inst->Internal.State = trkPAPER_SH_CLICK_INFO_RUN;	
					}
				}
				else{
					//move to next shuttle 
					inst->Internal.State = trkPAPER_SH_CLICK_GET_NEXT;
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
			inst->Internal.UpdateLookupTable = ShuttleLookup(inst->Internal.Axes, inst->Ident, &inst->Data, &inst->Internal.Fbs.ShReadInfo);
		
			/*remake table if shuttle is not found*/
			if(inst->Internal.UpdateLookupTable){
				inst->Internal.State = trkPAPER_SH_BUILD_TABLE;
			}
			else{
				inst->Internal.Fbs.ShReadInfo.Enable = TRUE;
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

