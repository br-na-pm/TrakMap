<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="ShuttleIni" Source="Source.SampleTrak.Assembly.SubModule1.ShuttleInit.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="AsmSampleT" Source="Source.SampleTrak.Assembly.AsmSampleTrak.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="AsmConfig" Source="Source.SampleTrak.Assembly.AsmConfig.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3">
    <Task Name="AsmAlarm" Source="Source.SampleTrak.Assembly.AsmAlarm.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="trakmodule" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TrakALM" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TrakPML" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TrakCFG" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
</SwConfiguration>