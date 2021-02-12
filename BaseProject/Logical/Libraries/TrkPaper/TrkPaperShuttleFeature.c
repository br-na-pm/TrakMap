
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
void TrkPaperShuttleFeature(struct TrkPaperShuttleFeature* inst)
{
	DINT BuildShuttlePolygon(char* dest,
	USINT idx, 
	LREAL length,
	LREAL width,
	UDINT userDataAdr,
	struct TrkPaperCoreColorOptionType* colorOption){
	
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
		if(CheckStrLen(dest,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
			brsstrcat(dest,&tmp);
			return trkPAPER_CORE_ERR_OK;
		}
		else 
			return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	}
	//This function loops through the assembly monitor data and builds a SVG string + SVG Transform. Will return 0 if succesful
	//Will monitor to make sure the string lengths are not exceeded
	DINT BuildShuttleStrings(struct McAcpTrakAssemblyMonData* mon,
	char* svgContent,char* svgTransform,
	struct TrkPaperCoreOptionsType* coreOptions){
		USINT i;
		USINT transCounter;
		transCounter = 0;
		char tmp[150];
	
		for (i = 0; i < trkPAPER_MAX_SHUTTLE_COUNT; i++){
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
				if(CheckStrLen(svgContent,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgContent,&tmp);
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;
			
				DINT returnVal;
				returnVal = BuildShuttlePolygon(svgContent,mon->Shuttle[i].Index,length,width,mon->Shuttle[i].UserData,&coreOptions->Color);
				if(returnVal!= trkPAPER_CORE_ERR_OK)
					return returnVal;
			
				snprintf2(tmp,150,"<text x=\"%f\" y=\"%f\" font-weight=\"bold\" font-size=\"0.035px\">%d</text>",
					mon->Shuttle[i].ExtentToBack / 2000.0,
					width * 3.0 / 4.0,
					mon->Shuttle[i].Index);
				if(CheckStrLen(svgContent,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgContent,&tmp);
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;
	
			
				//Create an invisible bounding rectangle to handle the click event. "Invisible" by using the alpha channel, if you use the 
				//Vibisility property, the click event will not fire for the SVG
				snprintf2(tmp,150,"<rect id=\"ID%d\" width=\"%f\" height=\"%f\" style=\"fill:rgba(0,0,0,0)\"/>",
					mon->Shuttle[i].Index,
					length,
					width);
				if(CheckStrLen(svgContent,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgContent,&tmp);
				}
				else 
					return trkPAPER_CORE_MAX_STR_LEN;
			
			
				if(CheckStrLen(svgContent,&"</g>",trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgContent,&"</g>");
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;
		
			
				//Check to see if we've had more transforms to add a comma between the units
				if(transCounter>0){
					if(CheckStrLen(svgTransform,&",",trkPAPER_CORE_MAX_STR_LEN)){
						brsstrcat(svgTransform,&",");
					}
					else 
						return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
				}
				//Preform translation
				snprintf2(tmp,150,"{\"select\":\"#Shuttle%d\",\"duration\":100,\"display\":true,\"translate\":[%f,%f]},",
					mon->Shuttle[i].Index,
					shCenterX,
					shCenterY,
					-mon->Shuttle[i].Orientation.Angle1,
					length/2.0,
					width/2.0);
				if(CheckStrLen(svgTransform,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgTransform,&tmp);
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;
				//Preform rotation
				snprintf2(tmp,150,"{\"select\":\"#sh%d\",\"duration\":100,\"display\":true,\"spin\":[%f,%f,%f]}",
					mon->Shuttle[i].Index,
					-mon->Shuttle[i].Orientation.Angle1, //Spin amount
					length/2.0,	//Spin center x
					width/2.0); //Spin center y
				if(CheckStrLen(svgTransform,&tmp,trkPAPER_CORE_MAX_STR_LEN)){
					brsstrcat(svgTransform,&tmp);
				}
				else 
					return trkPAPER_CORE_ERR_STR_LEN_EXCD;	
				transCounter++;
			}
		
		}
	
		//No Error, finished everything return OK
		return trkPAPER_CORE_ERR_OK;
	}
}

