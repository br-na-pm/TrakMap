
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
DINT BuildShuttlePolygon(char* dest,
	USINT idx, 
	LREAL length,
	LREAL width,
	UDINT userDataAdr,
struct tpCoreColorOptionTyp* colorOption){
	
	char tmp[150];
	USINT red,blue,green;
	struct UserDataTyp* tst;
	
	if(!colorOption->Enabled){
		snprintf2(tmp,150,"<polygon id=\"sh%d\" points=\"0,0 %0f,0 , %f,%f %f,%f 0,%f\" style=\"fill:rgb(0,255,0);\"/>",
			idx,	//polygon index
			(length-width/2.0),//p1.x
			length,	//p1.y
			width/2.0, //p2.x
			(length-width/2.0),//p2.y
			width,//p2.x
			width); //p3.y
	}
	else{
		brsmemcpy(&red,userDataAdr + colorOption->Offsets.Red,sizeof(USINT));
		brsmemcpy(&green,userDataAdr + colorOption->Offsets.Green,sizeof(USINT));
		brsmemcpy(&blue,userDataAdr + colorOption->Offsets.Blue,sizeof(USINT));
		
		snprintf2(tmp,150,"<polygon id=\"sh%d\" points=\"0,0 %0f,0 , %f,%f %f,%f 0,%f\" style=\"fill:rgb(%d,%d,%d);\"/>",
			idx,	//polygon index
			(length-width/2.0),//p1.x
			length,	//p1.y
			width/2.0, //p2.x
			(length-width/2.0),//p2.y
			width,//p2.x
			width,
			red,
			green,
			blue); //p3.y
	}
	if(CheckStrLen(dest,&tmp,tpCORE_MAX_STR_LEN)){
		brsstrcat(dest,&tmp);
		return tpCORE_ERR_OK;
	}
	else 
		return tpCORE_ERR_STR_LEN_EXCEEDED;
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

//This function loops through the assembly monitor data and builds a SVG string + SVG Transform. Will return 0 if succesful
//Will monitor to make sure the string lengths are not exceeded
DINT BuildShuttleStrings(struct McAcpTrakAssemblyMonData* mon,
	char* svgContent,char* svgTransform,
struct tpCoreOptionsTyp* coreOptions){
	USINT i;
	USINT transCounter;
	transCounter = 0;
	char tmp[150];
	
	for (i = 0; i < tpMAX_SHUTTLE_COUNT; i++){
		if(mon->Shuttle[i].Available){
			brsmemset(&tmp,0,sizeof(tmp));
		
			LREAL width;
			LREAL length;
			LREAL shCenterX;
			LREAL shCenterY;
			
			width = mon->Shuttle[i].Width / 1000.0;
			length = (mon->Shuttle[i].ExtentToBack + mon->Shuttle[i].ExtentToFront)/ 1000.0;
			shCenterX = mon->Shuttle[i].Position.X / 1000.0 - mon->Shuttle[i].ExtentToBack / 1000.0;
			shCenterY = -(mon->Shuttle[i].Position.Y / 1000.0 + width / 2.0);
	
			snprintf2(tmp,150,"<g id=\"Shuttle%d\">",mon->Shuttle[i].Index);
			if(CheckStrLen(svgContent,&tmp,tpCORE_MAX_STR_LEN)){
				brsstrcat(svgContent,&tmp);
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;
			
			DINT returnVal;
			returnVal = BuildShuttlePolygon(svgContent,mon->Shuttle[i].Index,length,width,mon->Shuttle[i].UserData,&coreOptions->Color);
			if(returnVal!= tpCORE_ERR_OK)
				return returnVal;
			
			snprintf2(tmp,150,"<text x=\"%f\" y=\"%f\" font-weight=\"bold\" font-size=\"0.035px\">%d</text>",
				mon->Shuttle[i].ExtentToBack / 2000.0,
				width * 3.0 / 4.0,
				mon->Shuttle[i].Index);
			if(CheckStrLen(svgContent,&tmp,tpCORE_MAX_STR_LEN)){
				brsstrcat(svgContent,&tmp);
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;
	
			
			//Create an invisible bounding rectangle to handle the click event. "Invisible" by using the alpha channel, if you use the 
			//Vibisility property, the click event will not fire for the SVG
			snprintf2(tmp,150,"<rect id=\"ID%d\" width=\"%f\" height=\"%f\" style=\"fill:rgba(0,0,0,0)\"/>",
				mon->Shuttle[i].Index,
				length,
				width);
			if(CheckStrLen(svgContent,&tmp,tpCORE_MAX_STR_LEN)){
				brsstrcat(svgContent,&tmp);
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;
			
			
			if(CheckStrLen(svgContent,&"</g>",tpCORE_MAX_STR_LEN)){
				brsstrcat(svgContent,&"</g>");
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;
		
			
			//Check to see if we've had more transforms to add a comma between the units
			if(transCounter>0){
				if(CheckStrLen(svgTransform,&",",tpCORE_MAX_STR_LEN)){
					brsstrcat(svgTransform,&",");
				}
				else 
					return tpCORE_ERR_STR_LEN_EXCEEDED;	
			}
			//Preform translation
			snprintf2(tmp,150,"{\"select\":\"#Shuttle%d\",\"duration\":100,\"display\":true,\"translate\":[%f,%f]},",
				mon->Shuttle[i].Index,
				shCenterX,
				shCenterY,
				-mon->Shuttle[i].Orientation.Angle1,
				length/2.0,
				width/2.0);
			if(CheckStrLen(svgTransform,&tmp,tpCORE_MAX_STR_LEN)){
				brsstrcat(svgTransform,&tmp);
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;
			//Preform rotation
			snprintf2(tmp,150,"{\"select\":\"#sh%d\",\"duration\":100,\"display\":true,\"spin\":[%f,%f,%f]}",
				mon->Shuttle[i].Index,
				-mon->Shuttle[i].Orientation.Angle1, //Spin amount
				length/2.0,	//Spin center x
				width/2.0); //Spin center y
			if(CheckStrLen(svgTransform,&tmp,tpCORE_MAX_STR_LEN)){
				brsstrcat(svgTransform,&tmp);
			}
			else 
				return tpCORE_ERR_STR_LEN_EXCEEDED;	
			transCounter++;
		}
		
	}
	
	//No Error, finished everything return OK
	return tpCORE_ERR_OK;
}

//Method for building the shuttle transform string. Defined the style of a segment based upon the information input into the FB
DINT BuildSegmentStrings(char* svgContent,
	char* svgTransform,
struct tpCoreSegmentsOptionTyp* segOptions){
	
	USINT i;
	char tmp[200];
		
	//{"select":"#Segment","fill":1"}
	for (i = 0; i < segOptions->SegmentCount; i++){
		if(segOptions->Segments[i].Status.ErrorCode > 0){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segOptions->Segments[i].SegmentId, //Segment Name
				segOptions->SegmentStyles.SegError //Segment Style Color index
				);
		}
		else if(!segOptions->Segments[i].Status.CommunicationReady || !segOptions->Segments[i].Status.ReadyForPowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segOptions->Segments[i].SegmentId, //Segment Name
				segOptions->SegmentStyles.SegWarning //Segment Style Color index
				);
		}
		else if(segOptions->Segments[i].Status.PowerOn){
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segOptions->Segments[i].SegmentId, //Segment Name
				segOptions->SegmentStyles.SegOkay //Segment Style Color index
				);
		}
		else{
			snprintf2(tmp,200,"{\"select\":\"#%s\",\"style\":\"fill:%d\"}",
				segOptions->Segments[i].SegmentId, //Segment Name
				segOptions->SegmentStyles.SegDefault //Segment Style Color index
				);
		}
		
		if(CheckStrLen(svgTransform,&tmp,tpCORE_MAX_STR_LEN)){
			brsstrcat(svgTransform,&tmp);
			if(CheckStrLen(svgTransform,&",",tpCORE_MAX_STR_LEN)){
				//Every one except for the last index add a comma
				if(i != segOptions->SegmentCount-1){
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
				if (inst->Assembly !=0) {
					inst->Internal.Fbs.AsmGetShuttle.Assembly = inst->Assembly;
					inst->Internal.Fbs.AsmGetShuttle.Enable = TRUE;
					}
				inst->Active = TRUE;
				inst->Internal.State = tpCORE_INIT;
			}
			break;
		case tpCORE_INIT:
			//Reset the lookup array just for safety
			brsmemset(&inst->Internal.Axes,0,sizeof(inst->Internal.Axes));
			
			if(inst->Options->Shuttle.Enabled){
				inst->Internal.State = tpCORE_GET_SH;
			}
			else{
				inst->Internal.State = tpCORE_RUNNING;
			}
			break;
		case tpCORE_GET_SH:
			//******************************************************************************** Get Shuttle state
			if(inst->Internal.Fbs.AsmGetShuttle.Error){
				inst->Error = TRUE;
				inst->ErrorID = tpCORE_ERR_INVALID_ASSEMBLY;
				
				inst->Internal.State = tpCORE_ERROR;
			}
			else if(inst->Internal.Fbs.AsmGetShuttle.Valid){
				if(inst->Internal.Fbs.AsmGetShuttle.TotalCount >= tpMAX_SHUTTLE_COUNT 
				|| inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID >= tpMAX_SHUTTLE_COUNT){
					
					inst->Error = TRUE;
					inst->ErrorID = tpCORE_ERR_SH_COUNT_EXCEEDED;
					
					inst->Internal.State = tpCORE_ERROR;
				}
				else{
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Present = TRUE;
					inst->Internal.Axes[inst->Internal.Fbs.AsmGetShuttle.AdditionalInfo.ShuttleID].Axis = inst->Internal.Fbs.AsmGetShuttle.Axis;
					inst->Internal.Fbs.AsmGetShuttle.Next = FALSE;
					
					if(inst->Internal.Fbs.AsmGetShuttle.RemainingCount == 0){
						//Done populating the lookup array, moving on
						inst->Internal.Fbs.AsmGetShuttle.Enable = FALSE;
						
						inst->Internal.State = tpCORE_RUNNING;
					}
					else{
						inst->Internal.ShCount++;
						
						inst->Internal.State = tpCORE_GET_NEXT;
					}
				}
			}
			break;
		case tpCORE_GET_NEXT:
			//******************************************************************************** Get next shuttle state
			inst->Internal.Fbs.AsmGetShuttle.Next = TRUE;
			inst->Internal.State = tpCORE_GET_SH;
			break;
		case tpCORE_RUNNING:
			StartSVGStrings(&inst->SvgContent,&inst->SvgTransform,&inst->ViewBoxCfg);
			//TODO: This error checking method won't work, need to have a different method with different states or something of the like. This is just a placeholder for now as we're not going to be using the Shuttle Implementation
			if(inst->Options->Shuttle.Enabled){
				inst->ErrorID = BuildShuttleStrings(inst->ShuttleMon,&inst->SvgContent,&inst->SvgTransform,inst->Options);
			}
			if(inst->Options->Segments.Enabled){
				inst->ErrorID = BuildSegmentStrings(&inst->SvgContent,&inst->SvgTransform,&inst->Options->Segments);
			}
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
	MC_BR_AsmGetShuttle_AcpTrak(&inst->Internal.Fbs.AsmGetShuttle);
}

