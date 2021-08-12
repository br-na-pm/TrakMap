
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

//Function Declaration to remove compiler warnings

//Verify that the two string lengths do not exceed a length
plcbit CheckStrLen(char* dest,char* source,UDINT length){
	if(brdkStrLen((uintptr_t)dest) + brdkStrLen((uintptr_t)source) >= length){
		return FALSE;
	}
	else{
		return TRUE;
	}
}

DINT StartSVGStrings(char* svgContent,
struct TrkPaperCoreViewBoxCfgType* viewBox){
	
	char tmp[150];
	
	brsmemset((uintptr_t)svgContent,0,sizeof(*svgContent));
	
	snprintf2(tmp,150,"<svg viewBox=\"%f %f %f %f\">",
		viewBox->MinX,
		viewBox->MinY,
		viewBox->Width,
		viewBox->Height);
	if(CheckStrLen(svgContent,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
		brsstrcat((uintptr_t)svgContent,(uintptr_t)&tmp);
	}
	else 
		return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
	
}

DINT StartSVGTransformStrings(char* svgTransform){
	
	brsmemset((uintptr_t)svgTransform,0,sizeof(*svgTransform));
	
	if(CheckStrLen(svgTransform,(char*)&"[",trkPAPER_CORE_MAX_STR_LEN)){
		brsstrcat((uintptr_t)svgTransform,(uintptr_t)&"[");
	}
	else 
		return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
	
}

//Closes the Transform and Content strings with the appropriate tags
DINT CloseSVGStrings(char* svgContent){

	if(CheckStrLen(svgContent,(char*)&"</svg>",trkPAPER_CORE_MAX_STR_LEN)){
		brsstrcat((uintptr_t)svgContent,(uintptr_t)&"</svg>");
	}
	else 
		return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}

//Closes the Transform strings with the appropriate tags
DINT CloseSVGTransformStrings(char* svgTransform){

	if(CheckStrLen(svgTransform,(char*)&"]",trkPAPER_CORE_MAX_STR_LEN)){
		brsstrcat((uintptr_t)svgTransform,(uintptr_t)&"]");
	}
	else 
		return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}



//Method for building the shuttle transform string. Defined the style of a segment based upon the information input into the FB
DINT BuildSegmentStrings(char* svgContent,
	char* svgTransform,
	struct TrkDiagSegmentType* segList,
USINT SegmentCount){
	
	USINT i;
	char tmp[200];
		
	//{"select":"#Segment","fill":1"}
	for (i = 0; i < SegmentCount; i++){
		if(segList[i].Status.ErrorCode > 0){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].Name, //Segment Name
				trkPAPER_SEG_STYLE_ERROR //Segment Style Color index
				);
			
		}
		else if(!segList[i].Status.CommunicationReady || !segList[i].Status.ReadyForPowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].Name, //Segment Name
				trkPAPER_SEG_STYLE_WARNING //Segment Style Color index
				);
		}
		else if(segList[i].Status.PowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].Name, //Segment Name
				trkPAPER_SEG_STYLE_OKAY //Segment Style Color index
				);
		}
		else{
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segList[i].Name, //Segment Name
				trkPAPER_SEG_STYLE_DEFAULT //Segment Style Color index
				);
		}
		
		if(CheckStrLen(svgTransform,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgTransform,(uintptr_t)&tmp);
			if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
				//Every one except for the last index add a comma
				if(i != SegmentCount-1){
					brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
				}
			}
			else{
				return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
			}
			
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
	}
	
	return trkPAPER_CORE_ERR_OK;

}

DINT BuildShuttlePolygon(char* dest,
	USINT idx){
	
	char tmp[150];
	

	snprintf2(tmp,150,"<circle id=\"sh%d\" r=\"0.05\" style=\"fill:rgb(150,150,150);\"/>",
		idx); //circle index
	
	if(CheckStrLen(dest,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
		brsstrcat((uintptr_t)dest,(uintptr_t)&tmp);
		return trkPAPER_CORE_ERR_OK;
	}
	else 
		return trkPAPER_CORE_ERR_STR_LEN_EXCD;
}

//This function loops through the assembly monitor data and builds a SVG string. Will return 0 if succesful
//Will monitor to make sure the string lengths are not exceeded
DINT BuildShuttleStrings(struct McAcpTrakAssemblyMonData* mon,
	char* svgContent){
	USINT i;
	char tmp[150];
	
	for (i = 1; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		brsmemset((uintptr_t)&tmp,0,sizeof(tmp));
		
		LREAL width;
		LREAL length;
		
		//Init Dimensions
		width = 0.04;
		length = 0.05;
	
		snprintf2(tmp,150,"<g id=\"Shuttle%d\">",i);
		if(CheckStrLen(svgContent,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgContent,(uintptr_t)&tmp);
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			
		DINT returnVal;
		returnVal = BuildShuttlePolygon(svgContent,i);
		if(returnVal!= trkPAPER_CORE_ERR_OK)
			return returnVal;
			
		snprintf2(tmp,150,"<text id=\"tx%d\" x=\"0\" y=\"0\" dominant-baseline=\"middle\" text-anchor=\"middle\" text-decoration=\"underline\" font-weight=\"bold\" font-size=\"0.035px\">%d</text>",
			i,
			i);
		if(CheckStrLen(svgContent,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgContent,(uintptr_t)&tmp);
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	
			
		//Create an invisible bounding rectangle to handle the click event. "Invisible" by using the alpha channel, if you use the 
		//Vibisility property, the click event will not fire for the SVG
		snprintf2(tmp,150,"<rect id=\"ID%d\" width=\"%f\" height=\"%f\" style=\"fill:rgba(0,0,0,0)\"/>",
			i,
			length,
			width);
		if(CheckStrLen(svgContent,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgContent,(uintptr_t)&tmp);
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			
			
		if(CheckStrLen(svgContent,(char*)&"</g>",trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgContent,(uintptr_t)&"</g>");
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
		
		
	}
	
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}

//This function loops through the assembly monitor data and builds a Transform string. Will return 0 if succesful
//Will monitor to make sure the string lengths are not exceeded
DINT BuildShuttleTransformStrings(struct McAcpTrakAssemblyMonData* mon,
	char* svgTransform,
	struct TrkPaperCoreOptionsType* trkOptions){
	
	USINT i;
	UDINT fillIndex;
	char tmp[150];
	UDINT maxIndex;
	
	for (i = 0; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		
		if(trkOptions->Segment.Enabled){
			if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
			}
			else 
				return trkPAPER_CORE_MAX_STR_LEN;	
		}
		
		if(mon->Shuttle[i].Available && trkOptions->Shuttle.Enabled){
			brsmemset((uintptr_t)&tmp,0,sizeof(tmp));
		
			LREAL shCenterX;
			LREAL shCenterY;
			
			shCenterX = mon->Shuttle[i].Position.X / 1000.0;
			shCenterY = -(mon->Shuttle[i].Position.Y / 1000.0);
	
			//Perform translation
			snprintf2(tmp,150,"{\"select\":\"#Shuttle%d\",\"duration\":100,\"display\":true,\"translate\":[%f,%f]}",
				mon->Shuttle[i].Index,
				shCenterX,
				shCenterY
				);
			if(CheckStrLen(svgTransform,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgTransform,(uintptr_t)&tmp);
			}
			else 
				return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			
			//Perform fill
			if(trkOptions->Color.Enabled){
				//Grab Fill Index
				brsmemcpy(&fillIndex,mon->Shuttle[i].UserData + trkOptions->Color.Offset,sizeof(UDINT));
				snprintf2(tmp,150,",{\"select\":\"#sh%d\",\"fill\":%d,\"duration\":1}",
					mon->Shuttle[i].Index,
					fillIndex + trkPAPER_SEG_COLOR_OFFSET//offset shuttle fill index by segment colors
					);
				if(CheckStrLen(svgTransform,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat((uintptr_t)svgTransform,(uintptr_t)&tmp);
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			}
			
				
		}else{
			maxIndex = i + 1;
			break;
		}
		
		if(!trkOptions->Segment.Enabled && i < (trkPAPER_MAX_SHUTTLE_COUNT - 1)){
			if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
			}
			else 
				return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
		}
		
	}
	
	for (i = maxIndex; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		
		if(trkOptions->Segment.Enabled && i != maxIndex){
			if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
			}
			else 
				return trkPAPER_CORE_MAX_STR_LEN;	
		}
	
		//Hide Shuttle
		snprintf2(tmp,150,"{\"select\":\"#Shuttle%d\",\"display\":false,\"duration\":1}",
			i);
		if(CheckStrLen(svgTransform,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat((uintptr_t)svgTransform,(uintptr_t)&tmp);
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
		
		if(!trkOptions->Segment.Enabled && i < (trkPAPER_MAX_SHUTTLE_COUNT - 1)){
			if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
			}
			else 
				return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
		}
	}
		
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}

/* Core Track Master function blocks. Handles the building of the SVG string */
void TrkPaperCore(struct TrkPaperCore* inst)
{
	switch (inst->Internal.State){
		case trkPAPER_CORE_OFF:
			//******************************************************************************** Off state
			if(inst->Enable){
				inst->Internal.TypeID = trkPAPER_CORE_CORE_TYPE_ID;
				inst->Handle = (uintptr_t)&inst->Internal;
				
				inst->Internal.Fbs.AsmGetShuttle.Assembly = inst->Assembly;
				inst->Internal.Fbs.AsmGetShuttle.Enable = TRUE;
				inst->Active = TRUE;
				inst->Internal.State = trkPAPER_CORE_INIT;
			}
			break;
		
		case trkPAPER_CORE_INIT:
			//Reset the lookup array just for safety
			brsmemset((uintptr_t)&inst->Internal.Axes,0,sizeof(inst->Internal.Axes));
			
			//Build Shuttle Strings
			StartSVGStrings((char*)&inst->SvgContent,&inst->ViewBoxCfg);
			inst->ErrorID = BuildShuttleStrings(inst->ShuttleMon,(char*)&inst->SvgContent);		
			CloseSVGStrings((char*)&inst->SvgContent);
				
			if(inst->Options->Shuttle.Enabled){
				inst->Internal.State = trkPAPER_CORE_GET_SH;
			}
			else{
				inst->Internal.State = trkPAPER_CORE_RUNNING;
			}
			break;

		case trkPAPER_CORE_GET_SH:
			//******************************************************************************** Get Shuttle state
			if(inst->Internal.Fbs.AsmGetShuttle.Error){
				inst->Error = TRUE;
				inst->ErrorID = trkPAPER_CORE_ERR_INVALID_ASM;
				
				inst->Internal.State = trkPAPER_CORE_ERROR;
			}
			else if(inst->Internal.Fbs.AsmGetShuttle.Valid){
				if(inst->Internal.Fbs.AsmGetShuttle.TotalCount >= trkPAPER_MAX_SHUTTLE_COUNT 
				|| inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID >= trkPAPER_MAX_SHUTTLE_COUNT){
					
					inst->Error = TRUE;
					inst->ErrorID = trkPAPER_CORE_ERR_SH_CNT_EXCD;
					
					inst->Internal.State = trkPAPER_CORE_ERROR;
				}
				else{
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Present = TRUE;
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Axis = inst->Internal.Fbs.AsmGetShuttle.Axis;
					inst->Internal.Fbs.AsmGetShuttle.Next = FALSE;
					
					if(inst->Internal.Fbs.AsmGetShuttle.RemainingCount == 0){
						//Done populating the lookup array, moving on
						inst->Internal.Fbs.AsmGetShuttle.Enable = FALSE;
						
						inst->Internal.State = trkPAPER_CORE_RUNNING;
					}
					else{
						inst->Internal.ShCount++;
						
						inst->Internal.State = trkPAPER_CORE_GET_NEXT;
					}
				}
			}
			break;
		
		case trkPAPER_CORE_GET_NEXT:
			//******************************************************************************** Get next shuttle state
			inst->Internal.Fbs.AsmGetShuttle.Next = TRUE;
			inst->Internal.State = trkPAPER_CORE_GET_SH;
			break;
		
		case trkPAPER_CORE_RUNNING:
			StartSVGTransformStrings((char*)&inst->SvgTransform);
			
			if(inst->Options->Segment.Enabled){
				inst->ErrorID = BuildSegmentStrings((char*)&inst->SvgContent,(char*)&inst->SvgTransform,inst->Segments,inst->SegmentCount);
			}
		
			inst->ErrorID = BuildShuttleTransformStrings(inst->ShuttleMon,(char*)&inst->SvgTransform,inst->Options);
			
			CloseSVGTransformStrings((char*)&inst->SvgTransform);
			inst->StrLengths.ContentLength = brdkStrLen((uintptr_t)&inst->SvgContent);
			inst->StrLengths.TransformLength = brdkStrLen((uintptr_t)&inst->SvgTransform);
			
			if(inst->ErrorID != trkPAPER_CORE_ERR_OK){
				inst->Error = TRUE;
				
				inst->Internal.State = trkPAPER_CORE_ERROR;
			}
			if(!inst->Enable){
				inst->Active = FALSE;
				inst->Internal.State = trkPAPER_CORE_OFF;
			}
			break;
		case trkPAPER_CORE_RESET:
			//Try and recover by resetting any blocks
			
			break;
		case trkPAPER_CORE_ERROR:
			if(inst->ErrorRest){
				inst->Error = FALSE;
				inst->ErrorID = trkPAPER_CORE_ERR_OK;
				
				inst->Internal.State = trkPAPER_CORE_OFF;
			}
			break;
	}
	//FB calls
	MC_BR_AsmGetShuttle_AcpTrak(&inst->Internal.Fbs.AsmGetShuttle);
}

