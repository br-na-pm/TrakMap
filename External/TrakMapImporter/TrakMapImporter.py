from math import ceil
from tabnanny import verbose
import PySimpleGUI as sg
import os.path
import argparse
from pathlib import Path

import xml.etree.ElementTree as ET
from xml.dom import minidom

VERSION_NUMBER = '1.02.9'

VB_MARGIN_HEIGHT = 0.23
VB_MARGIN_MINY = 0.02

VBL_POS_MINX = -0.5
VBL_POS_MINY = 0.0



DEV_MODE = False
if DEV_MODE:
    defaultTextSvg = "C:/ACPTrakScenes/gAssembly_1.svg"
    defaultTextOuputFolder = "C:/ACPTrakScenes/"
    defaultTextOutput = "Trakmap.svg"
    defaultTextSegDefine = "C:/Projects/test-trak-oldmap/Logical/Source/Diagnostic/TrakDiag/SegDefinition.st"
else:
    defaultTextSvg = ""
    defaultTextOuputFolder = ""
    defaultTextOutput = ""
    defaultTextSegDefine = ""

class TrakMap:
    def __init__(self,inputSVG):
        self._inputSVG = inputSVG
        try: 
            self._inputSvgPath = Path(self._inputSVG)
        except:
            return
        self._assemblyName = self._inputSvgPath.stem
        
        self.svgParse()
        

    def svgParse(self):
        ET.register_namespace('', "http://www.w3.org/2000/svg")
        
        tree = ET.parse(self._inputSvgPath)
        self.root = tree.getroot()
        
        
        
        self.segList = []

        class Point:
            x: float = 0.0
            y: float = 0.0

        minimumDim = Point()
        maximumDim = Point()

        
        segmentCount = 0
        sectorCount = 0
        ppCount = 0
        removeCount = 0


        for gggroup in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            #Search for segments inside <svg><g><g><g>
            SegmentPolygon = gggroup.find('{http://www.w3.org/2000/svg}polygon')
            if SegmentPolygon != None:
                segmentCount += 1;
                segmentRefFromId = SegmentPolygon.get('id')
                self.segList.append(segmentRefFromId)
                polygon_num = 0

                for polygon in gggroup.findall('{http://www.w3.org/2000/svg}polygon'):
                    if polygon_num == 0:
                        #trak segment background
                        idStr = 'psg'
                    elif polygon_num == 1:
                        idStr = 'bsg'
                        #trak segment arrow
                    polygon_num += 1
                    polygon.set('id', idStr + segmentRefFromId)

                for polyline in gggroup.findall('{http://www.w3.org/2000/svg}polyline'):
                    #trak segment outline
                    polyline.set('id', 'psg' + segmentRefFromId)

                    #get max extents of trak
                    points = polyline.get('points').strip().split(' ')
                    

                    for point in points:
                        #infer maxmimum dimensions 
                        #TODO check only 0,0 points on the segment
                        xy = point.split(',')
                        xy = [float(i) for i in xy]
                        if minimumDim.x == 0.0 and minimumDim.y == 0.0 and maximumDim.x == 0.0 and maximumDim.y == 0.0:
                            #initialize
                            minimumDim.x = xy[0]
                            minimumDim.y = xy[0]
                            maximumDim.x = xy[1]
                            maximumDim.y = xy[1]

                        if minimumDim.x > xy[0]:
                            minimumDim.x = xy[0]
                        if maximumDim.x < xy[0]:
                            maximumDim.x = xy[0]
                            
                        if minimumDim.y > xy[1]:
                            minimumDim.y = xy[1]
                        if maximumDim.y < xy[1]:
                            maximumDim.y = xy[1]


                for polyline in gggroup.findall('{http://www.w3.org/2000/svg}text'):
                    polyline.set('id', 'tsg' + segmentRefFromId)  

            #Also look for id="segtable" and remove it
            if(gggroup.get('id') == 'segtable' or removeCount > 0):
                if(gggroup.get('id') == 'segtable'):
                    removeCount = ceil(segmentCount / 20.0)
                removeCount -= 1
                self.root.find('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g').remove(gggroup)
                #gggroup.clear()
            
        # Clear out unnecessary elements
        for ggroup in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            #Count number of each type so we know how many tables to kill (this is slow but meh)
            if(ggroup.get('id') == 'sector'):
                sectorCount += 1
            if(ggroup.get('id') == 'triggerpoint'):
                ppCount += 1
        removeCount = 0
        for ggroup in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            if(ggroup.get('id') in ['sector', 'triggerpoint', 'trpttable', 'sectortable', 'workspace'] or removeCount>0):
                if ggroup.get('id') == 'sectortable':
                    removeCount = ceil(sectorCount / 20.0)
                if ggroup.get('id') == 'trpttable':
                    removeCount = ceil(ppCount / 20.0)

                if removeCount>0:
                    removeCount -= 1
                #ggroup.clear()
                self.root.find('./{http://www.w3.org/2000/svg}g').remove(ggroup)

            tickmarkGroup = ggroup.find('{http://www.w3.org/2000/svg}polyline')
            if(tickmarkGroup != None):
                if(tickmarkGroup.get('stroke') in ['lightgrey', 'darkorange','purple']):
                    self.root.find('./{http://www.w3.org/2000/svg}g').remove(ggroup)
                    #ggroup.clear()
    

        #Set Viewbox based on calculated maximums
        self.viewBox = self.root.attrib['viewBox'].split(' ')

        self.viewBox[0] = self.viewBox[0]                               #min-x
        self.viewBox[1] = str(float(self.viewBox[1]) + VB_MARGIN_MINY)  #min-y
        self.viewBox[2] = self.viewBox[2]                               #width
        self.viewBox[3] =  str(abs(minimumDim.y) + VB_MARGIN_HEIGHT)    #height

        viewBoxString = self.viewBox[0] + ' ' + self.viewBox[1] + ' ' + self.viewBox[2] + ' ' + self.viewBox[3]
        self.root.set('viewBox', viewBoxString);
            


    def svgParseLists(self, genSegList, genSecList, genPPList):
        ET.register_namespace('', "http://www.w3.org/2000/svg")
        
        tree = ET.parse(self._inputSvgPath)
        self.rootList = tree.getroot()


        #Set Viewbox based on set attributes
        vBL = self.rootList.attrib['viewBox'].split(' ')

        vBL[0] = str(VBL_POS_MINX)
        vBL[1] = str(VBL_POS_MINY)

        viewBoxString = vBL[0] + ' ' + vBL[1] + ' ' + vBL[2] + ' ' + vBL[3]
        self.rootList.set('viewBox', viewBoxString);

        for gggroup in self.rootList.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            if(gggroup.get('id') != 'segtable'):
                gggroup.clear()
            else:
                break

        # Clear out unnecessary elements
        ggList = self.rootList.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g')
        for ggroup in ggList:
            if(ggroup.get('id') in ['sector', 'triggerpoint', 'workspace']):
                ggroup.set('id', 'KILLME')
                ggroup.clear()
            #ggList.remove(ggroup)

            tickmarkGroup = ggroup.find('{http://www.w3.org/2000/svg}polyline')
            if(tickmarkGroup != None):
                if(tickmarkGroup.get('stroke') in ['lightgrey', 'darkorange']):
                    ggroup.clear()    
    
    def writeTrakMapSVG(self,FilePath):
        if not FilePath.endswith(".svg"):
            FilePath += ".svg"
        xmlstr = minidom.parseString(ET.tostring(self.root)).toprettyxml(indent = " ", newl='')
        with open(FilePath, 'w') as file:
            file.write(xmlstr)
        #print('{input} file successfully prepared and output to {output}'.format(input = inputPath, output = outputPath))

    def writeTrakListSVG(self,FilePath):
        if not FilePath.endswith(".svg"):
            FilePath += ".svg"
        xmlstr = minidom.parseString(ET.tostring(self.rootList)).toprettyxml(indent = " ", newl='')
        with open(FilePath, 'w') as file:
            file.write(xmlstr)
        #print('{input} file successfully prepared and output to {output}'.format(input = inputPath, output = outputPath))

    def exportSegDefine(self,FilePath):
        path = Path(FilePath)
        with open(path, 'w') as file:
            file.write("//This file was automatically generated using the TrakMapImporter program. Verify that the segment names and assembly name match your project values correctly\n")
            file.write("ACTION SegDefinition: \n")
            for idx,seg in enumerate(self.segList):
                file.write("\tTrakDiag.Seg.SegList[{indx}].Name  := '{segName}';\t\tTrakDiag.Seg.SegList[{indx}].McType := {segName};\n".format(
                    indx = idx,
                    segName = seg
                ))
            file.write("\n\tTrakDiag.Seg.SegCount := {length};\n".format(length = len(self.segList)))
            file.write("\n\tTrakDiag.Seg.SegListAdr := ADR(TrakDiag.Seg.SegList);\n")
            file.write("\n\tDiagFbs.Asm.ReadInfo.Assembly := ADR({assName});\n".format(assName = self._assemblyName))
            file.write("\tDiagFbs.Asm.ReadStatus.Assembly := ADR({assName});\n\n".format(assName = self._assemblyName))
            file.write("\tpaperCore.ViewBoxCfg.MinX := {};\n".format(self.viewBox[0]))
            file.write("\tpaperCore.ViewBoxCfg.MinY := {};\n".format(self.viewBox[1]))
            file.write("\tpaperCore.ViewBoxCfg.Width := {};\n".format(self.viewBox[2]))
            file.write("\tpaperCore.ViewBoxCfg.Height := {};\n".format(self.viewBox[3]))
            file.write("END_ACTION \n")

def ValidateInputs(values) -> bool:
    if values["-Input SVG-"] != "" and values["-Output SVG-"] != "" and values["-OutputPath-"] != "" and values["-TrakDiagAction-"] != "" :
        return True
    else:

        return False

def CreateLayout():
    sg.change_look_and_feel("Reddit")

  
    file_list_column = [
        [
            sg.Text("Input SVG file"),
            sg.In(size=(100, 1), enable_events=True, key="-Input SVG-", default_text = defaultTextSvg),
            sg.FileBrowse(file_types=(("Scaleable Vector Graphics", "*.svg"),))

        ],
        [
            sg.Text("Output Folder Path"),
            sg.In(size=(100, 1), enable_events=True, key="-OutputPath-", default_text = defaultTextOuputFolder),
            sg.FolderBrowse()
        ],
        [
            sg.Text("Output SVG name"),
            sg.In(size=(100, 1), enable_events=True, key="-Output SVG-", default_text = defaultTextOutput)
        ],
        [
            sg.Text("TrakDiag SegDefine Action"),
            sg.In(size=(100, 1), enable_events=True, key="-TrakDiagAction-", default_text = defaultTextSegDefine),
            sg.FileBrowse(file_types=(("Structured Text", "*.st"),))
        ],
        #remove visible for generation option checkboxes
        [
           sg.Text("List File Generation Options", visible=False),
            sg.Checkbox("Segment List", key="-SegListGen-", default=True, visible=False),
            sg.Checkbox("Sector List", key="-SecListGen-", visible=False),
            sg.Checkbox("Process Point List", key="-PPListGen-", visible=False)
        ],
        [
            sg.Button(button_text="Generate TrakMap Files",key="-Generate-")
        ]
    ]
    layout = [
        [
            sg.Column(file_list_column),
        ]
    ]
    return layout

def main() -> None:
    
    layout = CreateLayout()
    window = sg.Window("TrakMap Builder {ver}".format(ver = VERSION_NUMBER), layout)

    while True:
        val = {}
        event, values = window.read()
        if event == "Exit" or event == sg.WIN_CLOSED:
            break
        if event == "-Generate-":
            passFail = ValidateInputs(values)
            if not passFail:
                sg.Popup("Invalid Inputs. Please validate your inputs.")
            else:
                trakMap = TrakMap(values["-Input SVG-"])
                trakMap.svgParseLists(values["-SegListGen-"], values["-SecListGen-"], values["-PPListGen-"])
                trakMap.writeTrakMapSVG(values["-OutputPath-"]+"/"+values["-Output SVG-"])
                trakMap.writeTrakListSVG(values["-OutputPath-"]+"/SegList"+values["-Output SVG-"])
                trakMap.exportSegDefine(values["-TrakDiagAction-"])
                sg.Popup("Files Prepared successfully")

if __name__ == '__main__':
    main()