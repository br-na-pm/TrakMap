<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="TrackDiag" Source="Source.Diagnostic.TrackDiag.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="DiagConfig" Source="Source.Diagnostic.DiagConfig.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3">
    <Task Name="DiagAlarm" Source="Source.Diagnostic.DiagAlarm.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8">
    <Task Name="Logbook" Source="Source.Diagnostic.Logbook.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <Binaries>
    <BinaryObject Name="DiagALM" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="diag" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="DiagREC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="DiagAUD" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
</SwConfiguration>