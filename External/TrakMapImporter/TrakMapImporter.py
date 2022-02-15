import PySimpleGUI as sg
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

        #=====================================================================================================================================================================
        #Iterate through all ./g/g/g elements
        #Record the id of the first polygon, set the second polygon to x + that id, set the polyline to that id, set the text to x + that id, change the text to that id 
        self.segList = []
        for group in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            firstpolygon = group.find('{http://www.w3.org/2000/svg}polygon')
            if firstpolygon != None:
                object_id = firstpolygon.get('id')
                id_num = 0
                for polygon in group.findall('{http://www.w3.org/2000/svg}polygon'):
                    #set the prefix accordingly ===========================================================================================================
                    idStr = 'sgprf'
                    if id_num != 0:
                        idStr = 'xsgprf'
                    polygon.set('id', idStr + object_id)
                    id_num += 1
                    #while we're at it, negate the x-coords because the svg is mirrored -------------------------------------------------------------------
                    #First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
                    segment_points_str = ''
                    segment_points_str = segment_points_str + polygon.attrib['points']
                    #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
                    segment_points_w_commas = segment_points_str.split(' ')
                    #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
                    segment_points = []
                    for pointpair in segment_points_w_commas:
                        #weed out any empty pairs
                        if (len(pointpair) > 0):
                            templist = pointpair.split(',')
                            segment_points.append(templist)
                    #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
                    list_xcoords = []
                    list_ycoords = []
                    for coordinatepair in segment_points:
                        list_xcoords.append(coordinatepair[0])
                        list_ycoords.append(coordinatepair[1])
                    #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = float(list_xcoords[i])
                        list_ycoords[i] = float(list_ycoords[i])
                    #Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = -1 * list_xcoords[i]
                    #Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = str(list_xcoords[i])
                        list_ycoords[i] = str(list_ycoords[i])
                    #Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
                    segment_points_str = ''
                    for i in range(0, len(list_xcoords)):
                        segment_points_str = segment_points_str + list_xcoords[i] + ',' + list_ycoords[i] + ' '
                    polygon.set('points', segment_points_str)
                for polyline in group.findall('{http://www.w3.org/2000/svg}polyline'):
                    #set the prefix accordingly ============================================================================================================
                    polyline.set('id', 'sgprf' + object_id)
                    id_num += 1
                    #while we're at it, negate the x-coords because the svg is mirrored --------------------------------------------------------------------
                    #First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
                    segment_points_str = ''
                    segment_points_str = segment_points_str + polyline.attrib['points']
                    #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
                    segment_points_w_commas = segment_points_str.split(' ')
                    #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
                    segment_points = []
                    for pointpair in segment_points_w_commas:
                        #weed out any empty pairs
                        if (len(pointpair) > 0):
                            templist = pointpair.split(',')
                            segment_points.append(templist)
                    #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
                    list_xcoords = []
                    list_ycoords = []
                    for coordinatepair in segment_points:
                        list_xcoords.append(coordinatepair[0])
                        list_ycoords.append(coordinatepair[1])
                    #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = float(list_xcoords[i])
                        list_ycoords[i] = float(list_ycoords[i])
                    #Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = -1 * list_xcoords[i]
                    #Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
                    for i in range(0, len(list_xcoords)):
                        list_xcoords[i] = str(list_xcoords[i])
                        list_ycoords[i] = str(list_ycoords[i])
                    #Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
                    segment_points_str = ''
                    for i in range(0, len(list_xcoords)):
                        segment_points_str = segment_points_str + list_xcoords[i] + ',' + list_ycoords[i] + ' '
                    polyline.set('points', segment_points_str)
                for text in group.findall('{http://www.w3.org/2000/svg}text'):
                    #set the prefix accordingly ============================================================================================================
                    text.set('id', 'xsgprf' + object_id)
                    text.text = object_id
                    #while we're at it, negate the x-coords because the svg is mirrored --------------------------------------------------------------------
                    text_x_coord_str = text.attrib['x']
                    text_x_coord = float(text_x_coord_str)
                    text_x_coord = text_x_coord * -1
                    text_x_coord_str = str(text_x_coord)
                    text.set('x', text_x_coord_str)

                self.segList.append(object_id)

        #=====================================================================================================================================================================
        #Negate the x coords for all workspace, sector, triggerpoint, and standalone polyline objects
        #ATTENTION: THE STANDALONE SECTION CATCHES THE SECTOR POLYLINES DUE TO SYNTAX, SO THE SECTOR SECTION HAS BEEN REMOVED
        for group in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='workspace']/{http://www.w3.org/2000/svg}g"):
            for polyline in group.findall('{http://www.w3.org/2000/svg}polyline'):
                #First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
                workspace_points_str = ''
                workspace_points_str = workspace_points_str + polyline.attrib['points']
                #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
                workspace_points_w_commas = workspace_points_str.split(' ')
                #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
                workspace_points = []
                for pointpair in workspace_points_w_commas:
                    #weed out any empty pairs
                    if (len(pointpair) > 0):
                        templist = pointpair.split(',')
                        workspace_points.append(templist)
                #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
                list_xcoords = []
                list_ycoords = []
                for coordinatepair in workspace_points:
                    list_xcoords.append(coordinatepair[0])
                    list_ycoords.append(coordinatepair[1])
                #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = float(list_xcoords[i])
                    list_ycoords[i] = float(list_ycoords[i])
                #Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = -1 * list_xcoords[i]
                #Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = str(list_xcoords[i])
                    list_ycoords[i] = str(list_ycoords[i])
                #Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
                workspace_points_str = ''
                for i in range(0, len(list_xcoords)):
                    workspace_points_str = workspace_points_str + list_xcoords[i] + ',' + list_ycoords[i] + ' '
                polyline.set('points', workspace_points_str)
            for rect in group.findall('{http://www.w3.org/2000/svg}rect'):
                rect_x_coord_str = rect.attrib['x']
                rect_x_coord = float(rect_x_coord_str)
                rect_x_coord = rect_x_coord * -1
                rect_x_coord_str = str(rect_x_coord)
                rect.set('x', rect_x_coord_str)
        for group in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='triggerpoint']"):
            for line in group.findall('{http://www.w3.org/2000/svg}line'):
                line_x1_coord_str = line.attrib['x1']
                line_x1_coord = float(line_x1_coord_str)
                line_x1_coord = line_x1_coord * -1
                line_x1_coord_str = str(line_x1_coord)
                line.set('x1', line_x1_coord_str)
                line_x2_coord_str = line.attrib['x2']
                line_x2_coord = float(line_x2_coord_str)
                line_x2_coord = line_x2_coord * -1
                line_x2_coord_str = str(line_x2_coord)
                line.set('x2', line_x2_coord_str)
            for polygon in group.findall('{http://www.w3.org/2000/svg}polygon'):
                #First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
                triggerpoint_points_str = ''
                triggerpoint_points_str = triggerpoint_points_str + polygon.attrib['points']
                #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
                triggerpoint_points_w_commas = triggerpoint_points_str.split(' ')
                #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
                triggerpoint_points = []
                for pointpair in triggerpoint_points_w_commas:
                    #weed out any empty pairs
                    if (len(pointpair) > 0):
                        templist = pointpair.split(',')
                        triggerpoint_points.append(templist)
                #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
                list_xcoords = []
                list_ycoords = []
                for coordinatepair in triggerpoint_points:
                    list_xcoords.append(coordinatepair[0])
                    list_ycoords.append(coordinatepair[1])
                #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = float(list_xcoords[i])
                    list_ycoords[i] = float(list_ycoords[i])
                #Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = -1 * list_xcoords[i]
                #Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = str(list_xcoords[i])
                    list_ycoords[i] = str(list_ycoords[i])
                #Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
                triggerpoint_points_str = ''
                for i in range(0, len(list_xcoords)):
                    triggerpoint_points_str = triggerpoint_points_str + list_xcoords[i] + ',' + list_ycoords[i] + ' '
                polygon.set('points', triggerpoint_points_str)
        for group in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g"):
            for polyline in group.findall('{http://www.w3.org/2000/svg}polyline'):
                #First, gather the points into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------------------------------------------
                standalone_points_str = ''
                standalone_points_str = standalone_points_str + polyline.attrib['points']
                #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
                standalone_points_w_commas = standalone_points_str.split(' ')
                #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
                standalone_points = []
                for pointpair in standalone_points_w_commas:
                    #weed out any empty pairs
                    if (len(pointpair) > 0):
                        templist = pointpair.split(',')
                        standalone_points.append(templist)
                #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
                list_xcoords = []
                list_ycoords = []
                for coordinatepair in standalone_points:
                    list_xcoords.append(coordinatepair[0])
                    list_ycoords.append(coordinatepair[1])
                #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = float(list_xcoords[i])
                    list_ycoords[i] = float(list_ycoords[i])
                #Sixth, negate the x coords ------------------------------------------------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = -1 * list_xcoords[i]
                #Seventh, convert the x list and y list back into lists of strings ---------------------------------------------------------------------
                for i in range(0, len(list_xcoords)):
                    list_xcoords[i] = str(list_xcoords[i])
                    list_ycoords[i] = str(list_ycoords[i])
                #Eighth, combine the x's and y's into the points string---------------------------------------------------------------------------------
                standalone_points_str = ''
                for i in range(0, len(list_xcoords)):
                    standalone_points_str = standalone_points_str + list_xcoords[i] + ',' + list_ycoords[i] + ' '
                polyline.set('points', standalone_points_str)

        #=====================================================================================================================================================================
        #Find the segtable, sectortable, and trpttable and clear (delete) them
        for segtable in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='segtable']"):
            segtable.clear()

        for sectortable in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='sectortable']"):
            sectortable.clear()

        for trgpttable in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='trpttable']"):
            trgpttable.clear()

        #=====================================================================================================================================================================
        #Delete sector and triggerpoint texts
        for sector in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='sector']"):
            for sector_text in sector.findall('{http://www.w3.org/2000/svg}text'):
                sector_text.clear()
        for trgpt in self.root.findall("./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g[@id='triggerpoint']"):
            for trgpt_text in trgpt.findall('{http://www.w3.org/2000/svg}text'):
                trgpt_text.clear()

        #=====================================================================================================================================================================
        #Calculate a new viewbox based on the min and max x and min and max y from the segments' polylines
        #First, gather the points from every polyline in every segment into a string (ex: 'x1,y1 x2,y2, x3,y3') --------------------------------
        segment_points_str = ''
        for segment in self.root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
            for segment_polyline in segment.findall('{http://www.w3.org/2000/svg}polyline'):
                segment_points_str = segment_points_str + segment_polyline.attrib['points']
        #Second, split the long string at spaces -----------------------------------------------------------------------------------------------
        segment_points_w_commas = segment_points_str.split(' ')
        #Third, take each point pair (ex: 'x1,y1') and split at commas -------------------------------------------------------------------------
        segment_points = []
        for pointpair in segment_points_w_commas:
            #weed out any empty pairs
            if (len(pointpair) > 0):
                templist = pointpair.split(',')
                segment_points.append(templist)
        #Fourth, take each x & y and add it to the x & y lists respectively --------------------------------------------------------------------
        list_xcoords = []
        list_ycoords = []
        for coordinatepair in segment_points:
            list_xcoords.append(coordinatepair[0])
            list_ycoords.append(coordinatepair[1])
        #Fifth, convert the x list and y list into lists of numbers (lists should be of same length) -------------------------------------------
        for i in range(0, len(list_xcoords)):
            list_xcoords[i] = float(list_xcoords[i])
            list_ycoords[i] = float(list_ycoords[i])
        #Sixth, find the min & max of the x & y lists ------------------------------------------------------------------------------------------
        min_xcoord = min(list_xcoords)
        max_xcoord = max(list_xcoords)
        min_ycoord = min(list_ycoords)
        max_ycoord = max(list_ycoords)
        #Last, calculate the min-x, min-y, length, and width of the viewbox --------------------------------------------------------------------
        self.viewbox_minx = min_xcoord - 0.1
        self.viewbox_miny = min_ycoord - 0.1
        self.viewbox_width = (max_xcoord - min_xcoord) + 0.2
        self.viewbox_height = (max_ycoord - min_ycoord) + 0.2        
        #Change the viewbox --------------------------------------------------------------------------------------------------------------------
        self.root.attrib['viewBox'] = str(self.viewbox_minx) + ' ' + str(self.viewbox_miny) + ' ' + str(self.viewbox_width) + ' ' + str(self.viewbox_height)    

    
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
            file.write("\tpaperCore.ViewBoxCfg.MinX := {};\n".format(self.viewbox_minx))
            file.write("\tpaperCore.ViewBoxCfg.MinY := {};\n".format(self.viewbox_miny))
            file.write("\tpaperCore.ViewBoxCfg.Width := {};\n".format(self.viewbox_width))
            file.write("\tpaperCore.ViewBoxCfg.Height := {};\n".format(self.viewbox_height))
            print(self.viewbox_minx)
            print(self.viewbox_miny)
            print(self.viewbox_width)
            print(self.viewbox_height)
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
    window = sg.Window("TrakMap Builder v1.0", layout)

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