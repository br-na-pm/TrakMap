;!include "SetupPC.nsh"
!include "SetupTrakMap_TS.nsh"

Var nsiPVI_OptionsFileName
Var nsiPVI_ErrorText

LangString mappFrameworkProductName ${LANG_ENGLISH} "mappFramework"
LangString mappFrameworkProductName ${LANG_GERMAN} "mappFramework"


; Text resources for section text (component selection)
LangString ARsimShortText ${LANG_GERMAN} "ARsim Starter Projekt"
LangString ARsimShortText ${LANG_ENGLISH} "ARsim Starter Project"
LangString ARsimLongText ${LANG_GERMAN} "ARsim Projekt und Start"
LangString ARsimLongText ${LANG_ENGLISH} "ARsim project and start"
LangString ARsimEndShortText ${LANG_GERMAN} "ARsim Ende"
LangString ARsimEndShortText ${LANG_ENGLISH} "ARsim end"
LangString ARsimEndLongText ${LANG_GERMAN} "ARsim Ende"
LangString ARsimEndLongText ${LANG_ENGLISH} "ARsim end"

LangString TrakMapShortText ${LANG_GERMAN} "${ProductNameShort} ${Version}"
LangString TrakMapShortText ${LANG_ENGLISH} "${ProductNameShort} ${Version}"
LangString TrakMapLongText ${LANG_GERMAN} "${ProductNameLong} ${Version}"
LangString TrakMapLongText ${LANG_ENGLISH} "${ProductNameLong} ${Version}"

LangString TrakMapBaseShortText ${LANG_GERMAN} "Solution Hauptpaket"
LangString TrakMapBaseShortText ${LANG_ENGLISH} "Solution main package"
LangString TrakMapBaseLongText ${LANG_GERMAN} "Trak Map Widget - Technology Solution / Hilfe"
LangString TrakMapBaseLongText ${LANG_ENGLISH} "Trak Map Widget - Technology Solution / Help"

;LangString TrakMapSampleShortText ${LANG_GERMAN} "Beispiel"
;LangString TrakMapSampleShortText ${LANG_ENGLISH} "Sample"
;LangString TrakMapSampleLongText ${LANG_GERMAN} "Change Your View - Beispiel Projekt"
;LangString TrakMapSampleLongText ${LANG_ENGLISH} "Change Your View - Sample Project"

;LangString TrakMapTSShortText ${LANG_GERMAN} "TechnologySolution"
;LangString TrakMapTSShortText ${LANG_ENGLISH} "TechnologySolution"
;LangString TrakMapTSLongText ${LANG_GERMAN} "Change Your View - TechnologySolution"
;LangString TrakMapTSLongText ${LANG_ENGLISH} "Change Your View - TechnologySolution"

;LangString TrakMapLibShortText ${LANG_GERMAN} "TrakMap Library"
;LangString TrakMapLibShortText ${LANG_ENGLISH} "TrakMap Library"
;LangString TrakMapLibLongText ${LANG_GERMAN} "TrakMap Runtime Library"
;LangString TrakMapLibLongText ${LANG_ENGLISH} "TrakMap Runtime Library"

LangString MenuShortText ${LANG_GERMAN} "Start Menü Eintrag"
LangString MenuShortText ${LANG_ENGLISH} "Start Menu entry"
LangString MenuLongText ${LANG_GERMAN} "Eintrag in das Startmenü"
LangString MenuLongText ${LANG_ENGLISH} "Entry into the start menu"

LangString TrakMapEndShortText ${LANG_GERMAN} "TrakMap Ende"
LangString TrakMapEndShortText ${LANG_ENGLISH} "TrakMap end"
LangString TrakMapEndLongText ${LANG_GERMAN} "TrakMap Ende"
LangString TrakMapEndLongText ${LANG_ENGLISH} "TrakMap end"

LangString PanelSetupPkgShortText ${LANG_ENGLISH} "Panel Setup Package"
LangString PanelSetupPkgShortText ${LANG_GERMAN} "Panel Setup Package"
LangString PanelSetupPkgLongText ${LANG_ENGLISH} "Installs Microsoft Visual C++ 2010 Redistributable Package (x86) and B&R Technology Guarding so the panel is ready to run mappView"
LangString PanelSetupPkgLongText ${LANG_GERMAN} "Installiert Microsoft Visual C++ 2010 Redistributable Package (x86) und B&R Technology Guarding um das Panel mappView lauffahig zu machen"

LangString ARsimShortcutShortText ${LANG_ENGLISH} "Simulation launch shortcut"
LangString ARsimShortcutShortText ${LANG_GERMAN} "Simulation start shortcut"
LangString ARsimShortcutLongText ${LANG_ENGLISH} "Shortcut in Programs lauching the Starter Project Simulation"
LangString ARsimShortcutLongText ${LANG_GERMAN} "Shortcut in Programme um das Starter Project Simulation zu started"

LangString ARsimStartShortText ${LANG_ENGLISH} "Simulation auto-launch"
LangString ARsimStartShortText ${LANG_GERMAN} "ARsim automatischer Start"
LangString ARsimStartLongText ${LANG_ENGLISH} "Launch Starter Project Simulation automatically after install"
LangString ARsimStartLongText ${LANG_GERMAN} "Starte das ARsim Starter Projekt automatisch nach erfolgter Installation"

LangString StarterProjectSimShortText ${LANG_ENGLISH} "Install Starter Project ARsim"
LangString StarterProjectSimShortText ${LANG_GERMAN} "Installier Starter Projekt ARsim"
LangString StarterProjectSimLongText ${LANG_ENGLISH} "Change Your View - Starter Project Simulation"
LangString StarterProjectSimLongText ${LANG_GERMAN} "Change Your View - Starter Project Simulation"

LangString PanelSetupShortText ${LANG_GERMAN} "Panel Setup"
LangString PanelSetupShortText ${LANG_ENGLISH} "Panel Setup"
LangString PanelSetupLongText ${LANG_GERMAN} "Panel Setup Konfiguration"
LangString PanelSetupLongText ${LANG_ENGLISH} "Panel Setup Configuration"
LangString PanelEndShortText ${LANG_GERMAN} "Panel Ende"
LangString PanelEndShortText ${LANG_ENGLISH} "Panel end"
LangString PanelEndLongText ${LANG_GERMAN} "Panel Ende"
LangString PanelEndLongText ${LANG_ENGLISH} "Panel end"

LangString mappFrameworkProductName ${LANG_ENGLISH} "mappFramework"
LangString mappFrameworkProductName ${LANG_GERMAN} "mappFramework"


; Variable declarationen for sections
!insertmacro VariableForSection "TrakMap"
	!insertmacro VariableForSection "TrakMapBase"
	;!insertmacro VariableForSection "Sample"
	;!insertmacro VariableForSection "TS"
	;!insertmacro VariableForSection "Lib"
	!insertmacro VariableForSection "Menu"

	!insertmacro VariableForSection "ARsim"
		!insertmacro VariableForSection "ARsimShortcut"
		!insertmacro VariableForSection "ARsimStart"
		!insertmacro VariableForSection "StarterProjectSim"
	!insertmacro VariableForSection "ARsimEnd"

	!insertmacro VariableForSection "PanelSetup"
		!insertmacro VariableForSection "PanelSetupPkg"
	!insertmacro VariableForSection "PanelEnd"

!insertmacro VariableForSection "TrakMapEnd"

Section # Remove old
	;SetOutPath "$INSTDIR\${ProductNameShort}"
	;RMDir /r "$INSTDIR\${ProductNameShort}"

	;SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\TrakMap"
	;RMDir /r "$VersionBaseFolder\AS\TechnologyPackages\TrakMap\V1.0.9.001"
SectionEnd

; Dummy section for the start of the root group
Section "$(TrakMapLongText)" TrakMap
SectionEnd


Section "$(TrakMapBaseShortText)" TrakMapBase

	;!insertmacro WaitForProcessToClose "TrakMap2.exe" "mappView Import Tool"

;	SetOutPath "$INSTDIR\${ProductNameShort}"
;	File /r "SetupData\TrakMapLogo.ico"
;	File /r "SetupData\Launch Simulation.exe"
;	File /r "SetupData\VisuKioskMode.exe"

;	SetOutPath "$INSTDIR\${ProductNameShort}\ImporterProgram"
;	File /r "SetupData\ImporterProgram\*.*"

	!insertmacro InstallHelp "$VersionBaseFolder" "Help"

;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"

	SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)"
	FindFirst $0 $1 "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)\*.*.*"
	Var /GLOBAL frameworkPath
    loop:
		StrCmp $1 "" done
		StrCpy $frameworkPath $1
        ;RMDir /r "$VersionBaseFolder\AS\TechnologyPackages\${ProductNameShort}\$1"
        FindNext $0 $1
        Goto loop
    done:
		SetOutPath "$VersionBaseFolder\AS\TechnologyPackages\$(mappFrameworkProductName)\$frameworkPath\Framework"
		File /r "..\build\*.zip"
    FindClose $0

;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"

SectionEnd

;Section "$(TrakMapSampleShortText)" Sample
;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"
;SectionEnd

;Section "$(TrakMapTSShortText)" TS
;	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
;	File /r "TechnologySolution\*.*"
;SectionEnd

;Section "$(TrakMapLibShortText)" Lib
;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"
;SectionEnd


; Dummy section for the end of the root group
Section "$(TrakMapEndShortText)" TrakMapEnd
SectionEnd

; description text (LongText) for component selection
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro SetDescriptionTextforMUI "TrakMap"
	!insertmacro SetDescriptionTextforMUI "TrakMapBase"
;	!insertmacro SetDescriptionTextforMUI "Sample"
;	!insertmacro SetDescriptionTextforMUI "TS"
;	!insertmacro SetDescriptionTextforMUI "Lib"
;	!insertmacro SetDescriptionTextforMUI "Menu"

;	!insertmacro SetDescriptionTextforMUI "ARsim"
;	!insertmacro SetDescriptionTextforMUI "StarterProjectSim"
;	!insertmacro SetDescriptionTextforMUI "ARsimShortcut"
;	!insertmacro SetDescriptionTextforMUI "ARsimStart"

;	!insertmacro SetDescriptionTextforMUI "PanelSetup"
;	!insertmacro SetDescriptionTextforMUI "PanelSetupPkg"

!insertmacro MUI_FUNCTION_DESCRIPTION_END


;!insertmacro CreateUninstaller "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
SectionEnd

;!insertmacro CreateUninstaller "$INSTDIR\${ProductNameShort}"

Section "un.Uninstaller"
	RMDir /r "$INSTDIR\${ProductNameShort}"
SectionEnd


Function OnInit
	; check Windows-Version
	; at least Windows VISTA SP 2 or Windows 7 SP1 or Windows Server 2008 R2 must be available.
	${IfNot} ${AtLeastWin2008R2}
		${If} ${IsWinVista}
		${AndIf} ${AtLeastServicePack} 2
		${Else}
			${If} ${IsWin7}
			${AndIf} ${AtLeastServicePack} 1
			${Else}
				!insertmacro GenerateError ${ErrorCode_WrongOS} "$(LangWrongOS)"
			${EndIf}
		${EndIf}
	${EndIf}

	; initializing section Flags
	; Flags are defined as follows:
	; SF_SELECTED   1
	; SF_SECGRP     2
	; SF_SECGRPEND  4
	; SF_BOLD       8
	; SF_RO         16  ReadOnly
	; SF_EXPAND     32
	; SF_PSELECTED  64
	StrCpy $TrakMapSectionRO 3

		StrCpy $TrakMapBaseSectionRO 17
	;	StrCpy $SampleSectionRO 1
	;	StrCpy $TSSectionRO 1
	;	StrCpy $LibSectionRO 17
	;	StrCpy $MenuSectionRO 1
	;	StrCpy $ARsimSectionRO 2
	;		StrCpy $StarterProjectSimSectionRO 0
	;		StrCpy $ARsimShortcutSectionRO 0
	;		StrCpy $ARsimStartSectionRO 0
	;	StrCpy $ARsimEndSectionRO 4
	;	StrCpy $PanelSetupSectionRO 2
	;		StrCpy $PanelSetupPkgSectionRO 0
	;	StrCpy $PanelEndSectionRO 4
	StrCpy $TrakMapEndSectionRO 4

	; initializing Selection IDs for Sections
	StrCpy $TrakMapSelectionID "TrakMap"
	StrCpy $TrakMapBaseSelectionID "TrakMapBase"
	;StrCpy $SampleSelectionID "Sample"
	;StrCpy $TSSelectionID "TS"
	;StrCpy $LibSelectionID "Lib"
	StrCpy $MenuSelectionID "Menu"

	StrCpy $ARsimSelectionID "ARsim"
	StrCpy $StarterProjectSimSelectionID "StarterProjectSim"
	StrCpy $ARsimShortcutSelectionID "ARsimShortcut"
	StrCpy $ARsimStartSelectionID "ARsimStart"

	StrCpy $ARsimSelectionID "PanelSetup"
	StrCpy $PanelSetupPkgSelectionID "PanelSetupPkg"

	; initializing Section Flags
	!insertmacro ReadAndSetSectionFlag "TrakMap" "TrakMap"
	!insertmacro ReadAndSetSectionFlag "TrakMapBase" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "Sample" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "TS" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "Lib" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "Menu" "TrakMap"

	;!insertmacro ReadAndSetSectionFlag "ARsim" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "StarterProjectSim" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimShortcut" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimStart" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimEnd" "TrakMap"

	;!insertmacro ReadAndSetSectionFlag "PanelSetup" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "TrakMap"
	;!insertmacro ReadAndSetSectionFlag "PanelEnd" "TrakMap"
	!insertmacro ReadAndSetSectionFlag "TrakMapEnd" "TrakMap"

	; check command line parameter "-O=" in case it's selected
	Call DoOptionFileHandling
FunctionEnd

Function DoOptionFileHandling
	${GetOptions} $CommandLine "-O=" $nsiPVI_OptionsFileName
	${If} "$nsiPVI_OptionsFileName" != ""
		${If} ${FileExists} "$nsiPVI_OptionsFileName"
			!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "TrakMapBase"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "Sample"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "TS"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "Lib"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "Menu"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "PanelSetupPkg"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "StarterProjectSim"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "ARsimShortcut"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrakMap" "ARsimStart"
		${Else}
			!insertmacro FormatString1 "$(ErrorFileNotFound)" "$nsiPVI_OptionsFileName" $nsiPVI_ErrorText
			!insertmacro GenerateError "${ErrorCode_FileNotFound}" $nsiPVI_ErrorText
		${EndIf}
	${EndIf}
FunctionEnd


Function .onComponentsPre
	${If} "$IsSilent" == "${TRUE}"
	${OrIf} "$IsReduced" == "${TRUE}"
		Abort
	${EndIf}
FunctionEnd

Function .onComponentsLeave
	!insertmacro GetAndWriteSectionFlag "TrakMap" "TrakMap"
	!insertmacro GetAndWriteSectionFlag "TrakMapBase" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "Sample" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "TS" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "Lib" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "Menu" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "ARsim" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "StarterProjectSim" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "ARsimShortcut" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "ARsimStart" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "PanelSetup" "TrakMap"
	;!insertmacro GetAndWriteSectionFlag "PanelSetupPkg" "TrakMap"

FunctionEnd
