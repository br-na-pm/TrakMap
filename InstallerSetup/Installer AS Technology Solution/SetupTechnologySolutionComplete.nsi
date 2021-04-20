;!include "SetupPC.nsh"
!include "SetupTrackMap_TS.nsh"

Var nsiPVI_OptionsFileName
Var nsiPVI_ErrorText

; Text resources for section text (component selection)
LangString ARsimShortText ${LANG_GERMAN} "ARsim Starter Projekt"
LangString ARsimShortText ${LANG_ENGLISH} "ARsim Starter Project"
LangString ARsimLongText ${LANG_GERMAN} "ARsim Projekt und Start"
LangString ARsimLongText ${LANG_ENGLISH} "ARsim project and start"
LangString ARsimEndShortText ${LANG_GERMAN} "ARsim Ende"
LangString ARsimEndShortText ${LANG_ENGLISH} "ARsim end"
LangString ARsimEndLongText ${LANG_GERMAN} "ARsim Ende"
LangString ARsimEndLongText ${LANG_ENGLISH} "ARsim end"

LangString TrackMapShortText ${LANG_GERMAN} "${ProductNameShort} ${Version}"
LangString TrackMapShortText ${LANG_ENGLISH} "${ProductNameShort} ${Version}"
LangString TrackMapLongText ${LANG_GERMAN} "${ProductNameLong} ${Version}"
LangString TrackMapLongText ${LANG_ENGLISH} "${ProductNameLong} ${Version}"

LangString TrackMapBaseShortText ${LANG_GERMAN} "Solution Hauptpaket"
LangString TrackMapBaseShortText ${LANG_ENGLISH} "Solution main package"
LangString TrackMapBaseLongText ${LANG_GERMAN} "Track Map Widget - Technology Solution / Hilfe"
LangString TrackMapBaseLongText ${LANG_ENGLISH} "Track Map Widget - Technology Solution / Help"

;LangString TrackMapSampleShortText ${LANG_GERMAN} "Beispiel"
;LangString TrackMapSampleShortText ${LANG_ENGLISH} "Sample"
;LangString TrackMapSampleLongText ${LANG_GERMAN} "Change Your View - Beispiel Projekt"
;LangString TrackMapSampleLongText ${LANG_ENGLISH} "Change Your View - Sample Project"

;LangString TrackMapTSShortText ${LANG_GERMAN} "TechnologySolution"
;LangString TrackMapTSShortText ${LANG_ENGLISH} "TechnologySolution"
;LangString TrackMapTSLongText ${LANG_GERMAN} "Change Your View - TechnologySolution"
;LangString TrackMapTSLongText ${LANG_ENGLISH} "Change Your View - TechnologySolution"

;LangString TrackMapLibShortText ${LANG_GERMAN} "TrackMap Library"
;LangString TrackMapLibShortText ${LANG_ENGLISH} "TrackMap Library"
;LangString TrackMapLibLongText ${LANG_GERMAN} "TrackMap Runtime Library"
;LangString TrackMapLibLongText ${LANG_ENGLISH} "TrackMap Runtime Library"

LangString MenuShortText ${LANG_GERMAN} "Start Menü Eintrag"
LangString MenuShortText ${LANG_ENGLISH} "Start Menu entry"
LangString MenuLongText ${LANG_GERMAN} "Eintrag in das Startmenü"
LangString MenuLongText ${LANG_ENGLISH} "Entry into the start menu"

LangString TrackMapEndShortText ${LANG_GERMAN} "TrackMap Ende"
LangString TrackMapEndShortText ${LANG_ENGLISH} "TrackMap end"
LangString TrackMapEndLongText ${LANG_GERMAN} "TrackMap Ende"
LangString TrackMapEndLongText ${LANG_ENGLISH} "TrackMap end"

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


; Variable declarationen for sections
!insertmacro VariableForSection "TrackMap"
	!insertmacro VariableForSection "TrackMapBase"
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

!insertmacro VariableForSection "TrackMapEnd"

Section # Remove old
	SetOutPath "$INSTDIR\${ProductNameShort}"
	RMDir /r "$INSTDIR\${ProductNameShort}"

	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\TrackMap"
	RMDir /r "$VersionBaseFolder\AS\TechnologySolutions\TrackMap\V1.0.9.001"
SectionEnd

; Dummy section for the start of the root group
Section "$(TrackMapLongText)" TrackMap
SectionEnd


Section "$(TrackMapBaseShortText)" TrackMapBase

	;!insertmacro WaitForProcessToClose "TrackMap2.exe" "mappView Import Tool"

	SetOutPath "$INSTDIR\${ProductNameShort}"
	File /r "SetupData\TrackMapLogo.ico"
;	File /r "SetupData\Launch Simulation.exe"
;	File /r "SetupData\VisuKioskMode.exe"

;	SetOutPath "$INSTDIR\${ProductNameShort}\ImporterProgram"
;	File /r "SetupData\ImporterProgram\*.*"

	!insertmacro InstallHelp "$VersionBaseFolder" "SetupData\Help"

;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"

	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
	File /r "TechnologySolution\*.*"

;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"

SectionEnd

;Section "$(TrackMapSampleShortText)" Sample
;	SetOutPath "$VersionBaseFolder\Samples"
;	File /r "Sample\*.*"
;SectionEnd

;Section "$(TrackMapTSShortText)" TS
;	SetOutPath "$VersionBaseFolder\AS\TechnologySolutions\${ProductNameShort}"
;	File /r "TechnologySolution\*.*"
;SectionEnd

;Section "$(TrackMapLibShortText)" Lib
;	SetOutPath "$INSTDIR\AS\Library"
;	File /r "Compiled Library\*.*"
;SectionEnd


; Dummy section for the end of the root group
Section "$(TrackMapEndShortText)" TrackMapEnd
SectionEnd

; description text (LongText) for component selection
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro SetDescriptionTextforMUI "TrackMap"
	!insertmacro SetDescriptionTextforMUI "TrackMapBase"
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
	StrCpy $TrackMapSectionRO 3

		StrCpy $TrackMapBaseSectionRO 17
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
	StrCpy $TrackMapEndSectionRO 4

	; initializing Selection IDs for Sections
	StrCpy $TrackMapSelectionID "TrackMap"
	StrCpy $TrackMapBaseSelectionID "TrackMapBase"
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
	!insertmacro ReadAndSetSectionFlag "TrackMap" "TrackMap"
	!insertmacro ReadAndSetSectionFlag "TrackMapBase" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "Sample" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "TS" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "Lib" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "Menu" "TrackMap"

	;!insertmacro ReadAndSetSectionFlag "ARsim" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "StarterProjectSim" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimShortcut" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimStart" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "ARsimEnd" "TrackMap"

	;!insertmacro ReadAndSetSectionFlag "PanelSetup" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "PanelSetupPkg" "TrackMap"
	;!insertmacro ReadAndSetSectionFlag "PanelEnd" "TrackMap"
	!insertmacro ReadAndSetSectionFlag "TrackMapEnd" "TrackMap"

	; check command line parameter "-O=" in case it's selected
	Call DoOptionFileHandling
FunctionEnd

Function DoOptionFileHandling
	${GetOptions} $CommandLine "-O=" $nsiPVI_OptionsFileName
	${If} "$nsiPVI_OptionsFileName" != ""
		${If} ${FileExists} "$nsiPVI_OptionsFileName"
			!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "TrackMapBase"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "Sample"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "TS"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "Lib"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "Menu"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "PanelSetupPkg"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "StarterProjectSim"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "ARsimShortcut"
			;!insertmacro ReadSectionFlagFromFile "$nsiPVI_OptionsFileName" "TrackMap" "ARsimStart"
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
	!insertmacro GetAndWriteSectionFlag "TrackMap" "TrackMap"
	!insertmacro GetAndWriteSectionFlag "TrackMapBase" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "Sample" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "TS" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "Lib" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "Menu" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "ARsim" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "StarterProjectSim" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "ARsimShortcut" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "ARsimStart" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "PanelSetup" "TrackMap"
	;!insertmacro GetAndWriteSectionFlag "PanelSetupPkg" "TrackMap"

FunctionEnd
