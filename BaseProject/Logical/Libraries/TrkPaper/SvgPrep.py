#Script to take a automatically generated AcpTrack layout and add IDs to the segments
#Does require the SVG to be formatted as an XML!
#Arguments
#   -i  Input file path
#   -o  Output file name (will output to the same path as the script is called in) 
#           Will overwrite any file of the same name

import os.path
import argparse
from pathlib import Path

import xml.etree.ElementTree as ET
from xml.dom import minidom

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', help='Input SVG', dest='inputPath', required=True)
    parser.add_argument('-o', '--output', help='Output SVG', dest='outputPath', required=True)

    args = parser.parse_args()
    path = Path(args.inputPath)
    try:
        path = Path(args.inputPath)
    except:
        print("Invalid input path.")
        return
    
    ET.register_namespace('', "http://www.w3.org/2000/svg")
    tree = ET.parse(path)
    root = tree.getroot()
    
    for group in root.findall('./{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g/{http://www.w3.org/2000/svg}g'):
        group_text = group.find('{http://www.w3.org/2000/svg}text')
        if group_text != None:
            txt = group_text.text
            if txt.find(' (') >= 0: # Remove the (NN XX) from the ID
                txt = txt[:txt.find(' (')]
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
    out = '{output}.svg'.format(output = args.outputPath)
    xmlstr = minidom.parseString(ET.tostring(root)).toprettyxml(indent = "    ")
    with open(out, 'w') as file:
        file.write(xmlstr)

if __name__ == '__main__':
    main()
