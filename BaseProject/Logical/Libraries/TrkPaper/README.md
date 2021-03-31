# Track Paper Widget Library
This is a brief overview of how the track paper library works and how to implement it.

## Overview
The track paper widget library provides a convenient wrapper to automatically build the SVG strings for an entire track system for the paper widget. The library utilizes the prebuilt SVG from the track system (post processed) in combination with acp trak status blocks to build a simple drop in to show the status of an acp trak system.

## Usage
### Preparing the SVG 
   The first step to use the track map is to have the automatically generated SVG generated with a valid layout and the SVGData file device. Some simple post processing must be done on this SVG in order to function with the Trak Paper widget.