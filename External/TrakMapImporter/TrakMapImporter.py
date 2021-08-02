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
        
        self.viewBox = self.root.attrib['viewBox'].split(' ')
        
        self.segList = []
        for group in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            group_text = group.find('{http://www.w3.org/2000/svg}text')
            if group_text != None:
                txt = group_text.text
                if txt.find(' (') >= 0: # Remove the (NN XX) from the ID
                    txt = txt[:txt.find(' (')]
                self.segList.append(txt)
                id_num = 0
                for polygon in group.findall('{http://www.w3.org/2000/svg}polygon'):
                    idStr = ''
                    if id_num != 0:
                        idStr = 'x'
                    polygon.set('id', idStr + txt)
                    id_num += 1
                for polyline in group.findall('{http://www.w3.org/2000/svg}polyline'):
                    polyline.set('id', txt)
                    id_num += 1
                group_text.set('id', 'x' + txt)
    
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