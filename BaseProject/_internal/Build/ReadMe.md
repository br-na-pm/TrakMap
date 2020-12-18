# Automation Studio Project Version Tracking

1. Launch Automation Studio and go to the Configuration View
2. Right-click on the CPU target directory and select Properties
3. Select the Build Events tab
4. Add the following text to the Configuration Pre-Build Step

```
powershell -ExecutionPolicy ByPass -File $(WIN32_AS_PROJECT_PATH)\_internal\build\Version.ps1  $(WIN32_AS_PROJECT_PATH)" $(AS_CONFIGURATION)
```

5. Create two variables in Global.var

```
(*Project Version Tracking Variables*)
VAR
	MachineSoftwareVersion : STRING[80] := '1.2.3-0-465abcd';
	MachineLastRevisionDate : DATE_AND_TIME := DT#2020-01-01-01:01;
END_VAR
```