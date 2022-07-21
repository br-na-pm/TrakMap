
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


DINT SegmentLookup(	struct TrkDiagSegmentType* segList,
	USINT SegmentCount,
	char* SegmentID,
	TrkDiagSegmentType* Data){
	
	USINT i;
	
	
	for (i = 0; i < SegmentCount; i++){
		if (brsstrcmp((uintptr_t)segList[i].Name, (uintptr_t)SegmentID) == 0){
			brsmemcpy((uintptr_t)Data, (uintptr_t)&segList[i], sizeof(segList[i]));
			return trkPAPER_SEG_INFO_ERR_OK;
		}	
	}
		
	return trkPAPER_SEG_INFO_ERR_BAD_IDENT;
}



void TrkPaperSegClickInfo(struct TrkPaperSegClickInfo* inst)
{
	switch (inst->Internal.State){
		case trkPAPER_SEG_CLICK_INFO_OFF:
			//******************************************************************************** Off state
			if(inst->Enable){
				if(inst->Handle == 0){
					inst->Error = TRUE;
					inst->ErrorID = trkPAPER_SEG_INFO_ERR_INVLID_HDL;
									
					inst->Internal.State = trkPAPER_SEG_CLICK_INFO_ERROR;
				}
				else{
					inst->Internal.CoreInt = (TrkPaperCoreInternalType*)inst->Handle;
					if(inst->Internal.CoreInt->TypeID != trkPAPER_CORE_CORE_TYPE_ID){
						inst->Error = TRUE;
						inst->ErrorID = trkPAPER_SEG_INFO_ERR_INVLID_HDL;
										
						inst->Internal.State = trkPAPER_SEG_CLICK_INFO_ERROR;
					}
					else{
						inst->Active = TRUE;
										
						inst->Internal.State = trkPAPER_SEG_CLICK_INFO_WAIT;
						
						inst->Internal.SegmentCount = inst->Internal.CoreInt->TrakStatus->Seg.SegCount;
						inst->Internal.SegList = inst->Internal.CoreInt->TrakStatus->Seg.SegList;
					}
				}
			}
			break;
		
		case trkPAPER_SEG_CLICK_INFO_WAIT:
			
			if(!inst->Enable){
				inst->Active = FALSE;
				inst->Valid = FALSE;
				inst->Internal.State = trkPAPER_SEG_CLICK_INFO_OFF;
			}else if(inst->Update){
				inst->Valid = FALSE;
				inst->Update = FALSE;
				inst->Internal.State = trkPAPER_SEG_CLICK_INFO_LOOKUP;
			}
			
			break;
		
		case trkPAPER_SEG_CLICK_INFO_LOOKUP:
			inst->ErrorID = SegmentLookup(inst->Internal.SegList, inst->Internal.SegmentCount, (char*)&inst->Ident, &inst->Data);
			
			if(inst->ErrorID != trkPAPER_SEG_INFO_ERR_OK){
				inst->Error = TRUE;
				
				inst->Internal.State = trkPAPER_SEG_CLICK_INFO_ERROR;
			}
			else{
				inst->Valid = TRUE;
				inst->Internal.State = trkPAPER_SEG_CLICK_INFO_WAIT;
			
			}
			break;
			
		
		case trkPAPER_SEG_CLICK_INFO_ERROR:
			if(inst->ErrorReset){
				inst->Error = FALSE;
				inst->ErrorID = trkPAPER_SEG_INFO_ERR_OK;
				
				inst->Internal.State = trkPAPER_SEG_CLICK_INFO_OFF;
			}
			break;
	}
}

