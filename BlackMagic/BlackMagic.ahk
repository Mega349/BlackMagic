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
global ScriptVersion := "1.6.0"
TempPointerFile = %A_Temp%\Trove_Pointer.ini
TempVersionsFile = %A_Temp%\Versions.ini
PointerHostFile := "https://webtrash.lima-city.de/Trove_Pointer_Host.ini"
VersionsFile := "https://webtrash.lima-city.de/Versions.ini"
PointerFile := "pointer.ini"
iniFile := "blackconfig.ini"

;Pointer blank Pattern
global LastUpdateSupport := "01.01.2000"

global SkipSize := 0
global SkipBase := "0x00000000"
global xSkipOffsetString := "0x0+0x0+0x0+0x0+0x0"
global ySkipOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zSkipOffsetString := "0x0+0x0+0x0+0x0+0x0"

global AccelerationSize := 0
global AccelerationBase := "0x00000000"
global xAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"
global yAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zAccelerationOffsetString := "0x0+0x0+0x0+0x0+0x0"

global ViewSize := 0
global ViewBase := "0x00000000"
global xViewOffsetString := "0x0+0x0+0x0+0x0+0x0"
global yViewOffsetString := "0x0+0x0+0x0+0x0+0x0"
global zViewOffsetString := "0x0+0x0+0x0+0x0+0x0"

global SpeedSize := 0
global SpeedBase := "0x00000000"
global SpeedOffsetString := "0x0+0x0+0x0+0x0+0x0"

;CD = Camera Distance
global CDSize := 0
global CDBase := "0x00000000"
global minCDOffsetString := "0x0+0x0"
global maxCDOffsetString := "0x0+0x0"

global cViewSize := 0
global cViewBase := "0x00000000"
global cViewHightSOffsetString := "0x0+0x0"
global cViewWidthOffsetString := "0x0+0x0"

global EncKeySize := 0
global EncKeyBase := "0x00000000"
global EncKeyOffsetString := "0x0+0x0+0x0+0x0+0x0"


;default Config
PointerAutoUpdate := true
EnableUpdateCheck := true
ShowTooltip := true
FlyAccel := 20
SkipDistance := 3.5
SuperJumpAccel := 20
FallManipulationAccel := -3
minCamDistance := 1.5
maxCamDistance := 4.2
FloatAccel := 0.4
DecSpeedValue := 260
EnableForceAccel := true
EnableStopIfDontMove := false


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
TroveMoveForwardKey = w
TroveMoveLeftKey = a
TroveMoveBackwardKey = s
TroveMoveRightKey = d


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
defaultTroveMoveForwardKey := TroveMoveForwardKey
defaultTroveMoveLeftKey := TroveMoveLeftKey
defaultTroveMoveBackwardKey := TroveMoveBackwardKey
defaultTroveMoveRightKey := TroveMoveRightKey


;Internal Vars
AntiAFKDelay := 2500
PI := 3.1414

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
