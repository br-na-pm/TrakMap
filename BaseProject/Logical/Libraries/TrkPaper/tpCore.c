
#include <bur/plctypes.h>

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
//Verify that the two string lengths do not exceed a length
plcbit CheckStrLen(char* dest,char* source,UDINT length){
	if(brdkStrLen(dest) + brdkStrLen(source) >= length){
		return FALSE;
	}
	else{
		return TRUE;
	}
}

DINT StartSVGStrings(char* svgContent,
	char* svgTransform,
struct tpCoreViewBoxCfgTyp* viewBox){
	
	char tmp[150];
	
	brsmemset(svgContent,0,sizeof(svgContent));
	brsmemset(svgTransform,0,sizeof(svgTransform));
	
	snprintf2(tmp,150,"<svg viewBox=\"%f %f %f %f\">",
		viewBox->MinX,
		viewBox->MinY,
		viewBox->Width,
		viewBox->Height);
	if(CheckStrLen(svgContent,&tmp,tpCORE_MAX_STR_LEN)){
		brsstrcat(svgContent,&tmp);
	}
	else 
		return tpCORE_ERR_STR_LEN_EXCEEDED;
	if(CheckStrLen(svgTransform,&"[",tpCORE_MAX_STR_LEN)){
		brsstrcat(svgTransform,&"[");
	}
	else 
		return tpCORE_ERR_STR_LEN_EXCEEDED;
	//No Error, finished everything return OK
	return tpCORE_ERR_OK;
	
}

//Closes the Transform and Content strings with the appropriate tags
DINT CloseSVGStrings(char* svgContent,
char* svgTransform){
	if(CheckStrLen(svgContent,&"</svg>",tpCORE_MAX_STR_LEN)){
		brsstrcat(svgContent,&"</svg>");
	}
	else 
		return tpCORE_ERR_STR_LEN_EXCEEDED;
	if(CheckStrLen(svgTransform,&"]",tpCORE_MAX_STR_LEN)){
		brsstrcat(svgTransform,&"]");
	}
	else 
		return tpCORE_ERR_STR_LEN_EXCEEDED;
	
	//No Error, finished everything return OK
	return tpCORE_ERR_OK;
}



//Method for building the shuttle transform string. Defined the style of a segment based upon the information input into the FB
DINT BuildSegmentStrings(char* svgContent,
	char* svgTransform,
struct tpCoreSegmentTyp* segList,
USINT SegmentCount){
	
	USINT i;
	char tmp[200];
		
	//{"select":"#Segment","fill":1"}
	for (i = 0; i < SegmentCount; i++){
		if(segList[i].Status.ErrorCode > 0){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].SegmentId, //Segment Name
				segStyleError //Segment Style Color index
				);
			
		}
		else if(!segList[i].Status.CommunicationReady || !segList[i].Status.ReadyForPowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].SegmentId, //Segment Name
				segStyleWarning //Segment Style Color index
				);
		}
		else if(segList[i].Status.PowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].SegmentId, //Segment Name
				segStyleOkay //Segment Style Color index
				);
		}
		else{
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].SegmentId, //Segment Name
				segStyleDefault //Segment Style Color index
				);
		}
		
		if(CheckStrLen(svgTransform,&tmp,tpCORE_MAX_STR_LEN)){
			brsstrcat(svgTransform,&tmp);
			if(CheckStrLen(svgTransform,&",",tpCORE_MAX_STR_LEN)){
				//Every one except for the last index add a comma
				if(i != SegmentCount-1){
					brsstrcat(svgTransform,&",");
				}
			}
			else{
				return tpCORE_ERR_STR_LEN_EXCEEDED;	
			}
			
		}
		else 
			return tpCORE_ERR_STR_LEN_EXCEEDED;	
	}
	
	return tpCORE_ERR_OK;

}

/* Core Track Master function blocks. Handles the building of the SVG string */
void tpCore(struct tpCore* inst)
{
	switch (inst->Internal.State){
		case tpCORE_OFF:
			//******************************************************************************** Off state
			if(inst->Enable){
				inst->Internal.TypeID = tpCORE_CORE_TYPE_ID;
				inst->Handle = &inst->Internal;
				
				inst->Active = TRUE;
				inst->Internal.State = tpCORE_INIT;
			}
			break;
		case tpCORE_INIT:
				inst->Internal.State = tpCORE_RUNNING;
			break;
		
		case tpCORE_RUNNING:
			StartSVGStrings(&inst->SvgContent,&inst->SvgTransform,&inst->ViewBoxCfg);
			
			inst->ErrorID = BuildSegmentStrings(&inst->SvgContent,&inst->SvgTransform,inst->Segments,inst->SegmentCount);
			
			CloseSVGStrings(&inst->SvgContent,&inst->SvgTransform);
			inst->StrLengths.ContentLength = brdkStrLen(&inst->SvgContent);
			inst->StrLengths.TransformLength = brdkStrLen(&inst->SvgTransform);
			
			if(inst->ErrorID != tpCORE_ERR_OK){
				inst->Error = TRUE;
				
				inst->Internal.State = tpCORE_ERROR;
			}
			if(!inst->Enable){
				inst->Active = FALSE;
				inst->Internal.State = tpCORE_OFF;
			}
			break;
		case tpCORE_RESET:
			//Try and recover by resetting any blocks
			
			break;
		case tpCORE_ERROR:
			if(inst->ErrorRest){
				inst->Error = FALSE;
				inst->ErrorID = tpCORE_ERR_OK;
				
				inst->Internal.State = tpCORE_OFF;
			}
			break;
	}
	//FB calls
}

