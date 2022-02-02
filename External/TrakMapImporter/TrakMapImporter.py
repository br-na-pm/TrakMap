import PySimpleGUI as sg
import os.path
import argparse
from pathlib import Path

import xml.etree.ElementTree as ET
from xml.dom import minidom

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

        #Calculate a new viewbox based on the min and max x and min and max y from the sector(s) polyline(s)
        #First, gather the points from every polyline in every sector into a string (ex: 'x1,y1 x2,y2, x3,y3')
        #Also, delete the sector text while we're at it
        sector_points_str = ''
        for sector in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='sector']"):
            for sector_polyline in sector.findall('{http://www.w3.org/2000/svg}polyline'):
                sector_points_str = sector_points_str + sector_polyline.attrib['points']
            for sector_text in sector.findall('{http://www.w3.org/2000/svg}text'):
                sector_text.clear()
            
            
        #Second, split the long string at spaces
        sector_points_w_commas = sector_points_str.split(' ')
        #Third, take each point pair (ex: 'x1,y1') and split at commas
        sector_points = []
        for pointpair in sector_points_w_commas:
            #weed out any empty pairs
            if (len(pointpair) > 0):
                templist = pointpair.split(',')
                sector_points.append(templist)
        #Fourth, take each x & y and add it to the x & y lists respectively
        list_xcoords = []
        list_ycoords = []
        for coordinatepair in sector_points:
            list_xcoords.append(coordinatepair[0])
            list_ycoords.append(coordinatepair[1])
        #Fifth, convert the x list and y list into lists of numbers (lists should be of same length)
        for i in range(0, len(list_xcoords)):
            list_xcoords[i] = float(list_xcoords[i])
            list_ycoords[i] = float(list_ycoords[i])
        #Sixth, find the min & max of the x & y lists
        min_xcoord = min(list_xcoords)
        max_xcoord = max(list_xcoords)
        min_ycoord = min(list_ycoords)
        max_ycoord = max(list_ycoords)
        #Last, calculate the min-x, min-y, length, and width of the viewbox
        viewbox_minx = min_xcoord - 0.2
        viewbox_miny = min_ycoord - 0.2
        viewbox_width = (max_xcoord - min_xcoord) + 0.4
        viewbox_height = (max_ycoord - min_ycoord) + 0.4        
        

        #Change the viewbox
        self.viewBox = self.root.attrib['viewBox'].split(' ')
        self.root.attrib['viewBox'] = str(viewbox_minx) + ' ' + str(viewbox_miny) + ' ' + str(viewbox_width) + ' ' + str(viewbox_height)
        



        #Iterate through all ./g/g/g elements
        #Record the id of the first polygon, set the second polygon to x + that id, set the polyline to that id, set the text to x + that id, change the text to that id 
        self.segList = []
        for group in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            ########### NEW STUFF ###########
            firstpolygon = group.find('{http://www.w3.org/2000/svg}polygon')
            if firstpolygon != None:
                object_id = firstpolygon.get('id')
                id_num = 0
                for polygon in group.findall('{http://www.w3.org/2000/svg}polygon'):
                    idStr = ''
                    if id_num != 0:
                        idStr = 'x'
                    polygon.set('id', idStr + object_id)
                    id_num += 1
                for polyline in group.findall('{http://www.w3.org/2000/svg}polyline'):
                    polyline.set('id', object_id)
                    id_num += 1
                for text in group.findall('{http://www.w3.org/2000/svg}text'):
                    text.set('id', 'x' + object_id)
                    text.text = object_id
                self.segList.append(object_id)

        #Find the segtable and the sectortable and clear (delete) them
        for segtable in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='segtable']"):
            segtable.clear()

        for sectortable in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='sectortable']"):
            sectortable.clear()
            

    
    def writeTrakMapSVG(self,FilePath):
        if not FilePath.endswith(".svg"):
            FilePath += ".svg"
        xmlstr = minidom.parseString(ET.tostring(self.root)).toprettyxml(indent = "    ")
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
            sg.In(size=(100, 1), enable_events=True, key="-Input SVG-"),
            sg.FileBrowse(file_types=(("Scaleable Vector Graphics", "*.svg"),))
        ],
        [
            sg.Text("Output Folder Path"),
            sg.In(size=(100, 1), enable_events=True, key="-OutputPath-"),
            sg.FolderBrowse()
        ],
        [
            sg.Text("Output SVG name"),
            sg.In(size=(100, 1), enable_events=True, key="-Output SVG-")
        ],
        [
            sg.Text("TrakDiag SegDefine Action"),
            sg.In(size=(100, 1), enable_events=True, key="-TrakDiagAction-"),
            sg.FileBrowse(file_types=(("Structured Text", "*.st"),))
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
    window = sg.Window("TrakMap Builder", layout)

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
                trakMap.writeTrakMapSVG(values["-OutputPath-"]+"/"+values["-Output SVG-"])
                trakMap.exportSegDefine(values["-TrakDiagAction-"])
                sg.Popup("Files Prepared successfully")

if __name__ == '__main__':
    main()