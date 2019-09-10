#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
#SingleInstance force
#WinActivateForce
SetTitleMatchMode, 3
OnExit("ExitFunktion")

;------------------------
;Variable:
;------------------------

;File / Name / Location Vars
global ScriptName := "BlackMagic"
global ScriptVersion := "1.0"
TempPointerFile = %A_Temp%\Trove_Pointer.ini
;TempSpeedFile = %A_Temp%\SpeedValue.txt
PointerHostFile := "https://webtrash.lima-city.de/Trove_Pointer_Host.ini"
SpeedHostFile := "https://webtrash.lima-city.de/SpeedValue.txt"
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

;Config Vars
PointerAutoUpdate := 1
ShowTooltip := 1
LastSpeed := 1
FlyAccel := 20
SkipDistance:= 3.5
SpeedKey = ^k
FreezeKey = ^p
yFreezeKey = ^l
FlyKey = ^w
SkipKey = MButton

;Internal Vars
SplitSpeed := []
SpeedString := []
SpeedValue := []
SpeedDispValue := []
SpeedValueString := []

;------------------------
;Start:
;------------------------

SplashTextOn,250,25,%ScriptName%,% ScriptName " v." ScriptVersion " wird gestartet..."

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
	ExitApp ;ohne admin rechte fortfahren? - hier nein
}

;------------------------
;Create and Read INI File:
;------------------------

#Include inifile.ahk

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
;GUI:
;------------------------

#Include, GUI.ahk

;------------------------
;End Startup:
;------------------------

Gosub, ToolTip
Gosub, InitHotkeys
SplashTextOff
return

;------------------------
;funktions/hotkeys/subroutine:
;------------------------

#Include, hotkeys.ahk
#Include, subroutine.ahk
#Include, hacks.ahk
#Include, funktions.ahk