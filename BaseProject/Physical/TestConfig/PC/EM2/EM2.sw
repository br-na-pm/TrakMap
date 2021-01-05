﻿<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio FileVersion="4.9"?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="Config2" Source="Source.SampleTrak.ReusableSource.Config.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2">
    <Task Name="Operation2" Source="Source.SampleTrak.ReusableSource.Operation.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="Alarm2" Source="Source.SampleTrak.ReusableSource.Alarm.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#3">
    <Task Name="Recovery2" Source="Source.SampleTrak.ReusableSource.Recovery.prg" Memory="UserROM" Language="IEC" Debugging="true" />
    <Task Name="BarrierCt2" Source="Source.SampleTrak.ReusableSource.BarrierCtrl.prg" Memory="UserROM" Language="IEC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <Binaries>
    <BinaryObject Name="em2" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
</SwConfiguration>