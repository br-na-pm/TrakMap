import PySimpleGUI as sg
import os.path
import argparse
from pathlib import Path

import xml.etree.ElementTree as ET
from xml.dom import minidom

def SvgParse(inputPath, outputPath):
    if inputPath.endswith(".svg"):
        path = Path(inputPath)
    else:
        inputPath += ".svg"
    
    try:
        path = Path(inputPath)
    except:
        print("Invalid input path. SVG not found")
        return 
    
    ET.register_namespace('', "http://www.w3.org/2000/svg")
    tree = ET.parse(path)
    root = tree.getroot()
    
    segList = []
    for group in root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
        group_text = group.find('{http://www.w3.org/2000/svg}text')
        if group_text != None:
            txt = group_text.text
            if txt.find(' (') >= 0: # Remove the (NN XX) from the ID
                txt = txt[:txt.find(' (')]
            segList.append(txt)
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

    #Write to the output file
    if not outputPath.endswith('.svg'):
        outputPath += '.svg'
    out = '{output}'.format(output = outputPath)
    xmlstr = minidom.parseString(ET.tostring(root)).toprettyxml(indent = "    ")
    with open(out, 'w') as file:
        file.write(xmlstr)
    print('{input} file successfully prepared and output to {output}'.format(input = inputPath, output = outputPath))
    return segList
    
def UpdateTrakDiag(SegList,FilePath,AssemblyName):
    if not FilePath.endswith(".st"):
        return
    try:
        path = Path(FilePath)
    except:
        print("Invalid file path. ST file not found")
        return 
    
    with open(path, 'w') as file:
        file.write("//This file was automatically generated using the TrakMapImporter program. Verify that the segment names and assembly name match your project values correctly")
        file.write("ACTION SegDefinition: \n")
        for idx,seg in enumerate(SegList):
            file.write("\tTrackDiag.Seg.SegList[{indx}].Name  := '{segName}';\t\tTrackDiag.Seg.SegList[{indx}].McType := {segName};\n".format(
                indx = idx,
                segName = seg
            ))

        file.write("\n\tTrackDiag.Seg.SegCount := {length}\n".format(length = SegList.count));
	    file.write("\n\tTrackDiag.Seg.SegListAdr := ADR(TrackDiag.Seg.SegList);\n"
        file.write("\n\tDiagFbs.Asm.ReadInfo.Assembly := ADR({assName});\n".format(assName = AssemblyName))
        file.write("\tDiagFbs.Asm.ReadStatus.Assembly := ADR({assName});\n".format(assName = AssemblyName))
        file.write("END_ACTION \n")
def ValidateInputs(values) -> bool:
    if values["-Input SVG-"] != "" and values["-Output SVG-"] != "" and values["-OutputPath-"] != "" and values["-TrackDiagAction-"] != "" :
        return True
    else:
        return False

sg.change_look_and_feel("Reddit")

file_list_column = [
    [
        sg.Text("Input SVG file"),
        sg.In(size=(100, 1), enable_events=True, key="-Input SVG-"),
        sg.FileBrowse(file_types=(("Scaleable Vector Graphics", "*.svg"),))
    ],
    [
        sg.Text("Ouput Folder Path"),
        sg.In(size=(100, 1), enable_events=True, key="-OutputPath-"),
        sg.FolderBrowse()
    ],
    [
        sg.Text("Output SVG name"),
        sg.In(size=(100, 1), enable_events=True, key="-Output SVG-")
    ],
    [
        sg.Text("TrackDiag SegDefine Action"),
        sg.In(size=(100, 1), enable_events=True, key="-TrackDiagAction-"),
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
            segList = SvgParse(values["-Input SVG-"],values["-OutputPath-"]+"/"+values["-Output SVG-"])
            tmp = Path(values["-Input SVG-"])
            UpdateTrakDiag(segList,values["-TrackDiagAction-"],tmp.stem)
            sg.Popup("Files Prepared successfully")



