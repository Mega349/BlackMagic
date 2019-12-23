#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
#SingleInstance force
#WinActivateForce
SetBatchLines -1
SetTitleMatchMode, 3
OnExit("ExitFunktion")

;------------------------
;Variable:
;------------------------

;File / Name / Location Vars
global ScriptName := "BlackMagic"
global ScriptVersion := "1.4.0"
TempPointerFile = %A_Temp%\Trove_Pointer.ini
TempVersionsFile = %A_Temp%\Versions.ini
PointerHostFile := "https://webtrash.lima-city.de/Trove_Pointer_Host.ini"
SpeedHostFile := "https://webtrash.lima-city.de/SpeedValue.txt"
VersionsFile := "https://webtrash.lima-city.de/Versions.ini"
PointerFile := "pointer.ini"
SpeedFile := "SpeedValue.txt"
SpeedFileBackup := "SpeedValue.txt.back"
iniFile := "blackconfig.ini"

;Pointer blank Pattern
global LastUpdateSupport := "01.01.2000"

global SkipBase := "0x00000000"
global xSkipOffsetString := "0x0+0x0+0x0+0x0+0x0"
global ySkipOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zSkipOffsetString := "0x0+0x0+0x0+0x0+0x0"

global AccelerationBase := "0x00000000"
global xAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"
global yAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"

global ViewBase := "0x00000000"
global xViewOffsetString := "0x0+0x0+0x0+0x0+0x0"
global yViewOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zViewOffsetString := "0x0+0x0+0x0+0x0+0x0"

global SpeedBase := "0x00000000"
global SpeedOffsetString := "0x0+0x0+0x0+0x0+0x0"

;CD = Camera Distance
global CDBase := "0x00000000"
global currentCDOffsetString := "0x0+0x0" ;unused, will be added later
global minCDOffsetString := "0x0+0x0"
global maxCDOffsetString := "0x0+0x0"


;default Config
PointerAutoUpdate := 1
EnableUpdateCheck := 1
ShowTooltip := 1
LastSpeed := 1
FlyAccel := 20
SkipDistance := 3.5
SuperJumpAccel := 20
FallManipulationAccel := -3
minCamDistance := 1.5
maxCamDistance := 4.2


;default Keys
SpeedKey = ^k
FreezeKey = ^p
yFreezeKey = ^l
FlyKey = ^w
SkipKey = MButton
FloatKey = ^f
SuperJumpKey = ^m
FallManipulationKey = ^g
AntiAFKKey = ^h


;default Trove Keys
TroveJumpKey = space
TroveAntiAFKKey = m


;backup default Keys
defaultSpeedKey := SpeedKey
defaultFreezeKey := FreezeKey
defaultyFreezeKey := yFreezeKey
defaultFlyKey := FlyKey
defaultSkipKey := SkipKey
defaultFloatKey := FloatKey
defaultSuperJumpKey := SuperJumpKey
defaultFallManipulationKey := FallManipulationKey
defaultAntiAFKKey := AntiAFKKey

defaultTroveJumpKey := TroveJumpKey
defaultTroveAntiAFKKey := TroveAntiAFKKey


;Internal Vars
SplitSpeed := []
SpeedString := []
SpeedValue := []
SpeedDispValue := []
SpeedValueString := []
AntiAFKDelay := 2500

;------------------------
;Start:
;------------------------

SplashTextOn,130,25,% ScriptName " v" ScriptVersion,% "Starting..."

;------------------------
;Admin Check:
;------------------------

if !A_IsAdmin
{
	try
	{
		Run *RunAs %A_ScriptFullPath%
		ExitApp
	}
	ExitApp ;continue without Admin permissions? - here no
}

;------------------------
;Create and Read INI File:
;------------------------

Gosub, loadINI

;------------------------
;Auto Update:
;------------------------

if (PointerAutoUpdate == TRUE)
{
	try
	{
		UrlDownloadToFile, %PointerHostFile% , %TempPointerFile%
	}
	if FileExist(TempPointerFile)
	{
		ReadPointerfromini(TempPointerFile)
		if (WritePointertoini(PointerFile) != TRUE)
		{
			ReadPointerfromini(PointerFile)
		}
	    FileDelete,%TempPointerFile%
	}
}

SpeedString := ReadFiletoArray(SpeedFile)

CounterPOS := 1
while (CounterPOS <= SpeedString.Length())
{
	SplitSpeed := StrSplit(SpeedString[CounterPOS] ,"=")
	SpeedDispValue[CounterPOS] := SplitSpeed[1]
	SpeedValue[CounterPOS] := SplitSpeed[2]
	CounterPOS++
}
CounterPOS := 1
while (CounterPOS <= SpeedString.Length())
{
	if (CounterPOS == 1)
	{
		SpeedValueString := SpeedDispValue[CounterPOS]
	}
	Else
	{
		SpeedValueString := SpeedValueString "|" SpeedDispValue[CounterPOS]
	}
	CounterPOS++
}

;------------------------
;Update check:
;------------------------

if (EnableUpdateCheck == TRUE)
{
	SplashTextOn,200,25,% ScriptName " v" ScriptVersion,% "Check for Update..."
	try
	{
		UrlDownloadToFile, %VersionsFile%, %TempVersionsFile%
	}
	if FileExist(TempVersionsFile)
	{
		IniRead,NewScriptVersion,%TempVersionsFile%,Version,BM
		if (NewScriptVersion != "ERROR" && NewScriptVersion != ScriptVersion)
		{
			SplashTextOff
			MsgBox, 4, %ScriptName%,% "An Update is available! " ScriptVersion " -> " NewScriptVersion "`nDownload now?"
			IfMsgBox, Yes
			{
				IniRead,NewScriptVersionURL,%TempVersionsFile%,URL,BM
				run, %NewScriptVersionURL%
			}
		}
	}
	FileDelete,%TempVersionsFile%
}

;------------------------
;GUI:
;------------------------

SplashTextOn,200,25,% ScriptName " v" ScriptVersion,% "Building GUI..."
Gosub, GUI
Gosub, refreshInputBox

;------------------------
;End Startup:
;------------------------

Gosub, ToolTip
Gosub, InitHotkeys
Gosub, refreshAddress
SplashTextOff
return

;------------------------
;funktions/hotkeys/subroutine:
;------------------------

#Include, inifile.ahk
#Include, GUI.ahk
#Include, hotkeys.ahk
#Include, subroutine.ahk
#Include, hacks.ahk
#Include, funktions.ahk
