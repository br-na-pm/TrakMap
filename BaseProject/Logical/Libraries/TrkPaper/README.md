# Track Paper Widget Library
This is a brief overview of how the track paper library works and how to implement it.

## Overview
The track paper widget library provides a convenient wrapper to automatically build the SVG strings for an entire track system for the paper widget. The library utilizes the prebuilt SVG from the track system (post processed) in combination with acp trak status blocks to build a simple drop in to show the status of an acp trak system.

## Usage
### Preparing the SVG 
   The first step to use the track map is to have the automatically generated SVG generated with a valid layout and the SVGData file device. Some simple post processing must be done on this SVG in order to function with the Trak Paper widget. The SVG must be generated from a system with MpMotion 5.13+. The post processing is done by executing the SvgPython.py script with the input file name of the pre-generated SVG. To run the script you will need to have Python (preferably 3.8+) installed

   1. Place SvgPrep.py and generated SVG into the same directory
   2. Open a command line in this directory
   3. Execute "python -i preGeneratedSvg.svg -o OutputFileName"

    Upon a success a new file named "OutputFileName.svg" will have been generated in the same directory. This is the new pre-processed SVG that you will use in the paper widget.

### Add in the Track Paper Library 
    To your project add the track paper library and the "TrakDiag" task. The TrakDiag task is the task that automatically implements the TrakPaper Core function block and supporting function blocks. 

### Populate the Segment List Variable
    The TrakPaper library uses a list of segments to build the string. In order for this to work you must populate a segment list with the segment variable reference and the name of that segment. The variable is TrackDiag.Seg.SegList. 

    The easiest method is in your init of the task add your definitions for the segments:
        TrackDiag.Seg.SegList[0].Name  := 'gSeg_A_1'; 	TrackDiag.Seg.SegList[0].McType := gSeg_A_1;
        TrackDiag.Seg.SegCount := 1;

    The above would make a system with a singular segment with a segment name of gSeg_A_1.

### Connecting to the Paper widget
    The final step that must be done is to connect to the paper widget and custom status widget.
    To the paper widget, map the paperCore variable SvgTransform and Svg


   