<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1" />
  <TaskClass Name="Cyclic#2">
    <Task Name="DiagConfig" Source="Source.SampleTrak.Diagnostic.DiagConfig.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3">
    <Task Name="DiagAlarm" Source="Source.SampleTrak.Diagnostic.DiagAlarm.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="TrackDiag" Source="Source.SampleTrak.Diagnostic.TrackDiag.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="TrackMap" Source="Source.SampleTrak.Diagnostic.TrackMap.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Logbook" Source="Source.SampleTrak.Diagnostic.Logbook.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
</SwConfiguration>