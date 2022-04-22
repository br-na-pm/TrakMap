
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
	USINT SegmentCount,
	BOOL SegClickValid,
char* currSegIdent){
	
	USINT i;
	DINT fillIndex;
	char tmp[200];
		
	//{"select":"#Segment","fill":1"}
	for (i = 0; i < SegmentCount; i++){
		if(segList[i].Status.ErrorCode > 0){
			fillIndex = trkPAPER_SEG_STYLE_ERROR; //Segment Style Color index	
		}
		else if(!segList[i].Status.CommunicationReady || !segList[i].Status.ReadyForPowerOn){
			fillIndex = trkPAPER_SEG_STYLE_WARNING;
		}
		else if(segList[i].Status.PowerOn){
			fillIndex = trkPAPER_SEG_STYLE_OKAY;
		}
		else{
			fillIndex = trkPAPER_SEG_STYLE_DEFAULT;
		}
		
		if(SegClickValid && brsstrcmp((uintptr_t)segList[i].Name, (uintptr_t)currSegIdent) == 0){
			snprintf2(tmp,200,"{\"select\":\"#psg%s\",\"fill\":%d,\"style\":\"stroke:11;stroke-width:0.008%;stroke-opacity:1\",\"duration\":1}",
				segList[i].Name, //Segment Name
				fillIndex //Segment Style Color index
				);
		}else{
			snprintf2(tmp,200,"{\"select\":\"#psg%s\",\"fill\":%d,\"style\":\"stroke:11;stroke-width:0.005%;stroke-opacity:0.05\",\"duration\":1}",
				segList[i].Name, //Segment Name
				fillIndex //Segment Style Color index
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
	

	snprintf2(tmp,150,"<circle id=\"sh%d\" r=\"0.05\" style=\"fill:rgb(150,150,150)\"/>",
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
	char* svgContent,
struct TrkPaperCoreViewBoxCfgType* viewBoxCfg){
	
	USINT i;
	char tmp[200];
	
	for (i = 0; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		if(mon->Shuttle[i].Available){
			brsmemset((uintptr_t)&tmp,0,sizeof(tmp));
			snprintf2(tmp,200,"<g id=\"Shuttle%d\" transform=\"translate(%d,%d)\">",
				mon->Shuttle[i].Index,
				viewBoxCfg->Width * 10,
				viewBoxCfg->Height * 10);
			if(CheckStrLen(svgContent,(char*)&tmp,trkPAPER_CORE_MAX_STR_LEN)){
				brsstrcat((uintptr_t)svgContent,(uintptr_t)&tmp);
			}
			else 
				return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			
			DINT returnVal;
			returnVal = BuildShuttlePolygon(svgContent,	mon->Shuttle[i].Index);
			if(returnVal!= trkPAPER_CORE_ERR_OK)
				return returnVal;
			
			snprintf2(tmp,200,"<text id=\"tsh%d\" x=\"0\" y=\"0\" dominant-baseline=\"middle\" text-anchor=\"middle\" text-decoration=\"underline\" font-weight=\"bold\" font-size=\"0.035px\">%d</text>",
				mon->Shuttle[i].Index,
				mon->Shuttle[i].Index);
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
		
	}
	
	
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}

//This function loops through the assembly monitor data and builds a Transform string. Will return 0 if succesful
//Will monitor to make sure the string lengths are not exceeded
DINT BuildShuttleTransformStrings(struct McAcpTrakAssemblyMonData* mon,
	char* svgTransform,
	struct TrkPaperCoreOptionsType* trkOptions,
	BOOL ShuttleClickValid,
char* Ident){
	
	USINT i;
	UDINT fillIndex;
	char tmp[150];
	USINT currShIdent;
	
	for (i = 0; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
		if(mon->Shuttle[i].Available && trkOptions->Shuttle.Enabled){
			brsmemset((uintptr_t)&tmp,0,sizeof(tmp));
		
			LREAL shCenterX;
			LREAL shCenterY;
			
			shCenterX = mon->Shuttle[i].Position.X / 1000.0;
			shCenterY = -(mon->Shuttle[i].Position.Y / 1000.0);
			
			if(trkOptions->Segment.Enabled){
				if(CheckStrLen(svgTransform,(char*)&",",trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat((uintptr_t)svgTransform,(uintptr_t)&",");
				}
				else 
					return trkPAPER_CORE_MAX_STR_LEN;	
			}
	
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
			
			//Perform fill and style change
			currShIdent = atoi((uintptr_t)Ident);
			
			if(trkOptions->Color.Enabled){
				//Grab Fill Index
				brsmemcpy((uintptr_t)&fillIndex,(uintptr_t)(mon->Shuttle[i].UserData + trkOptions->Color.Offset),sizeof(UDINT));
			}else{
				fillIndex = 0;
			}
			
			if(ShuttleClickValid && mon->Shuttle[i].Index == currShIdent){
				snprintf2(tmp,150,",{\"select\":\"#sh%d\",\"fill\":%d,\"style\":\"stroke:11;stroke-width:0.015%;stroke-opacity:1\",\"duration\":1}",
					mon->Shuttle[i].Index,
					fillIndex + trkPAPER_SEG_COLOR_OFFSET//offset shuttle fill index by segment colors
					);
			}else{
				snprintf2(tmp,150,",{\"select\":\"#sh%d\",\"fill\":%d,\"style\":\"stroke:11;stroke-width:0;stroke-opacity:1\",\"duration\":1}",
					mon->Shuttle[i].Index,
					fillIndex + trkPAPER_SEG_COLOR_OFFSET//offset shuttle fill index by segment colors
					);
			}
			
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
	}
	
	
		
	//No Error, finished everything return OK
	return trkPAPER_CORE_ERR_OK;
}


//Parses ClickID and triggers corresponding function block
DINT ParseClickID(char* ClickID,
struct TrkPaperCore* inst){
	
	DINT StrIndex; 
	char shIdent[] = "sh";
	char segIdent[] = "sg"; //TODO: change to sg following python script change
	
	brsmemset((uintptr_t)&inst->Internal.Fbs.TrkPaperSegClickInfo.Ident, 0, sizeof(inst->Internal.Fbs.TrkPaperSegClickInfo.Ident));
	brsmemset((uintptr_t)&inst->Internal.Fbs.TrkPaperShuttleClickInfo.Ident, 0, sizeof(inst->Internal.Fbs.TrkPaperSegClickInfo.Ident));
	
	inst->Internal.Fbs.TrkPaperShuttleClickInfo.Enable = FALSE;
	inst->Internal.Fbs.TrkPaperSegClickInfo.Enable = FALSE;
	
	//Segment
	StrIndex = brdkStrSearch((uintptr_t)ClickID, (uintptr_t)segIdent);
	if (StrIndex != -1) {
		brsmemcpy((uintptr_t)&inst->Internal.Fbs.TrkPaperSegClickInfo.Ident, (uintptr_t)(ClickID + StrIndex + 2), brdkStrLen((uintptr_t)ClickID) - StrIndex);
		inst->Internal.Fbs.TrkPaperSegClickInfo.Enable = TRUE;
		inst->Internal.Fbs.TrkPaperSegClickInfo.Update = TRUE;
		return trkPAPER_CORE_ERR_OK;
	}
	
	//Shuttle
	StrIndex = brdkStrSearch((uintptr_t)ClickID, (uintptr_t)shIdent);
	if (StrIndex != -1) {
		brsmemcpy((uintptr_t)&inst->Internal.Fbs.TrkPaperShuttleClickInfo.Ident, (uintptr_t)(ClickID + StrIndex + 2), brdkStrLen((uintptr_t)ClickID) - StrIndex);
		inst->Internal.Fbs.TrkPaperShuttleClickInfo.Enable = TRUE;
		inst->Internal.Fbs.TrkPaperShuttleClickInfo.Update = TRUE;
		return trkPAPER_CORE_ERR_OK;

	}
	
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
				
				
				inst->Internal.Fbs.TrkPaperSegClickInfo.Handle = inst->Handle;
				inst->Internal.Fbs.TrkPaperShuttleClickInfo.Handle = inst->Handle;
			
				
				inst->Active = TRUE;
				inst->Internal.State = trkPAPER_CORE_INIT;
				
				inst->Internal.TrakStatus = inst->TrakStatus;
				inst->Internal.Assembly = inst->Assembly;
			}
			break;
		
		case trkPAPER_CORE_INIT:
				
			inst->Internal.State = trkPAPER_CORE_RUNNING;
			break;


		case trkPAPER_CORE_RUNNING:
			
			//ClickInfo
			if(inst->ReadClickID){
				inst->ErrorID = ParseClickID(inst->ClickID, inst);
				inst->ReadClickID = FALSE;
			}
			
			//Build Shuttle Strings
			StartSVGStrings((char*)&inst->SvgContent,&inst->ViewBoxCfg);
			inst->ErrorID = BuildShuttleStrings(inst->ShuttleMon,(char*)&inst->SvgContent, &inst->ViewBoxCfg);		
			CloseSVGStrings((char*)&inst->SvgContent);
			
			StartSVGTransformStrings((char*)&inst->SvgTransform);
			
			if(inst->Options->Segment.Enabled){
				inst->ErrorID = BuildSegmentStrings((char*)&inst->SvgContent,(char*)&inst->SvgTransform,inst->Segments,inst->SegmentCount, inst->Internal.Fbs.TrkPaperSegClickInfo.Valid, (char*)&inst->Internal.Fbs.TrkPaperSegClickInfo.Ident);
			}
		
			inst->ErrorID = BuildShuttleTransformStrings(inst->ShuttleMon,(char*)&inst->SvgTransform,inst->Options,inst->Internal.Fbs.TrkPaperShuttleClickInfo.Valid,(char*)&inst->Internal.Fbs.TrkPaperShuttleClickInfo.Ident);
			
			CloseSVGTransformStrings((char*)&inst->SvgTransform);
			
			inst->StrLengths.ContentLength = brdkStrLen((uintptr_t)&inst->SvgContent);
			inst->StrLengths.TransformLength = brdkStrLen((uintptr_t)&inst->SvgTransform);
			
			//Data Assignment for click ID parsing
			inst->ClickData.Segment.Valid = inst->Internal.Fbs.TrkPaperSegClickInfo.Valid;
			inst->ClickData.Segment.Data = inst->Internal.Fbs.TrkPaperSegClickInfo.Data;
			
			inst->ClickData.Shuttle.Valid = inst->Internal.Fbs.TrkPaperShuttleClickInfo.Valid;
			inst->ClickData.Shuttle.Data = inst->Internal.Fbs.TrkPaperShuttleClickInfo.Data;
			
			//Error and Enable Handling
			if(inst->ErrorID != trkPAPER_CORE_ERR_OK){
				inst->Error = TRUE;
				
				inst->Internal.State = trkPAPER_CORE_ERROR;
			}
			else if(inst->Internal.Fbs.TrkPaperSegClickInfo.ErrorID != trkPAPER_SEG_INFO_ERR_OK){
				inst->ErrorID = trkPAPER_CORE_ERR_SEG_INFO;
				inst->Error = TRUE;
				inst->Internal.State = trkPAPER_CORE_ERROR;
			}
			else if(inst->Internal.Fbs.TrkPaperShuttleClickInfo.ErrorID != trkPAPER_SH_INFO_ERR_OK){
				inst->ErrorID = trkPAPER_CORE_ERR_SH_INFO;
				inst->Error = TRUE;
				inst->Internal.State = trkPAPER_CORE_ERROR;
			}
			else if(!inst->Enable){
				inst->Active = FALSE;
				inst->Internal.State = trkPAPER_CORE_OFF;
			}
			break;
		case trkPAPER_CORE_RESET:
			//Try and recover by resetting any blocks
			inst->Internal.Fbs.TrkPaperSegClickInfo.ErrorReset = TRUE;
			inst->Internal.Fbs.TrkPaperShuttleClickInfo.ErrorReset = TRUE;
			
			inst->Internal.State = trkPAPER_CORE_OFF;
			
			break;
		case trkPAPER_CORE_ERROR:
			if(inst->ErrorRest){
				inst->Error = FALSE;
				inst->ErrorID = trkPAPER_CORE_ERR_OK;
				
				inst->Internal.State = trkPAPER_CORE_RESET;
			}
			break;
	}
	//FB calls	
	TrkPaperSegClickInfo(&inst->Internal.Fbs.TrkPaperSegClickInfo);
	TrkPaperShuttleClickInfo(&inst->Internal.Fbs.TrkPaperShuttleClickInfo);
	inst->Internal.Fbs.TrkPaperSegClickInfo.ErrorReset = FALSE;
	inst->Internal.Fbs.TrkPaperShuttleClickInfo.ErrorReset = FALSE;
}

