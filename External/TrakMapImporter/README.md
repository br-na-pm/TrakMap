# Track Paper Widget Library
This is a brief overview of how to implement the track paper widget.

## Overview
The track paper widget library provides a convenient wrapper to automatically build the SVG strings for an entire track system for the paper widget. The library utilizes the prebuilt SVG from the track system (post processed) in combination with acp trak status blocks to build a simple drop in widget to show the status of an acp trak system.

# Major Components
The TrakPaper widget consists of a few components.

1. TrakPaper Library
2. TrakDiag Task
3. SegmentStatus Custom Widget
4. MpPaper widget
5. ACOPOS Trak layout generated SVG

Each of these components works together to create the TrakMap widget and functionality. 

## Usage

### Import the TrakMap Technology Solution
Place the provided technology solution in the Automation Studio technology solutions folder (BrAutomationInstallationFolder)/(AutomationStudioVersion)/AS/TechnologySolutions. In your project, select the root node in the logical view, in the toolbox select to add a "Technology Solution" package and select the TrakMap application package that appears.

### Running the TrakMapImporter program
We've created a simple tool to help assist in the parsing of the SVG and other steps needed to use the track map. Run the provided .exe
There is a prompt for 4 inputs:

1. Initial SVG
2. Export Folder
3. Export File Name
4. TrackDiag SegDefine.st action file path

The initial SVG should be the file name for the exported SVG from Automation Runtime. The export folder is the location in which you'd like to generate the SVG for the paper widget itself. The Export file name is the name of the exported SVG you'd like to have. The final input is the file location of the SegDefine.st action under the provided TrackDiag task. 

The program when "Generate" is pressed, will process the provided SVG and create a formatted SVG for the paper widget. Additionally it will populate the action with the segment names and assembly name. Upon completion of the export, you should validate that the values are correct from your project.

### Deploy to your Software Configuration
To your project add the track paper library and the "TrakDiag" task. The TrakDiag task is the task that automatically implements the TrakPaper Core function block and supporting function blocks.  The TrackDiag task must be added to the cyclic 8 task class (or a large idle time task class)

### Setting up the Paper widget
The final step that must be done is to connect to the paper widget and custom status widget.

You'll need to enable the following local variables in OPC-UA for the TrackDiag task

1. TrackDiag:clickedSegment
2. TrackDiag:clickId
3. TrackDiag:paperCore.SvgTransform
4. TrackDiag:paperCore.SvgContent
   
#### Paper Widget
To the paper widget, map the paperCore variable SvgTransform and SvgContent variables from the TrakDiag task.

The Trak paper widget uses the color List property of the paper widget for the segment status colors during operation. The default color values could be the following: `#c9c9c9,#FF0000,#00FF00,#FFFF80`

The important part is that the following indices are used for the styling of the segments:

| Style Description | Index | 
| ------ | ------ |
| Segment Default Style | 0 |
| Segment is in an error state | 1 |
| Segment is okay style | 2 |
| Segment is in a warning state style | 3 |

Custom styling is possible by changing the color at the defined index.

In order to use the segment details, the "clickID" property must be set for the Paper Widget. This can be done by using the below code block in an event binding and setting the "contentRefId" and "widgetRefId" correctly
```xml
    <EventBinding id="content_trackmap.paperTrackMap.Click">
      <Source xsi:type="widgets.brease.Paper.Event" contentRefId="trackmapContent" widgetRefId="paperTrackMap" event="Click" />
      <EventHandler>
        <Action>
          <Target xsi:type="opcUa.NodeAction" refId="::TrackDiag:clickId">
            <Method xsi:type="opcUa.NodeAction.SetValueString" value="= elementId" />
          </Target>
        </Action>
      </EventHandler>
    </EventBinding>
```

#### Custom Status Widget
To use the custom widget, add the custom library provided into the project. Add the SegmentStatus widget into your content wherever you desire. Connect the `TrackDiag:clickedSegment` variable to the widget. That is all that is needed for the custom widget

#### Theme Definitions
The custom widget utilizes some custom themes for the toggle buttons present. You can use your own themes should you like, or you can add the provided style file to your existing theme for styling.

#### Text Files
In the provided files there are the text files. These can be included to populate the error texts and segment statuses in the status widget. Add the provided text files to the text definition for the project.


   