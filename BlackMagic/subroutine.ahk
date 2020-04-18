CheckTroveWindow:
WinGet, PID, PID, ahk_exe Trove.exe
WinGet, hwnd, ID, ahk_pid %PID%
Base := getProcessBaseAddress(hwnd)

Gosub, getAddress
oldySkipAddress := ySkipAddress
return

getAddress:
xSkipAddress := GetAddress(PID, Base, SkipBase, xSkipOffsetString)
ySkipAddress := GetAddress(PID, Base, SkipBase, ySkipOffsetString)
zSkipAddress := GetAddress(PID, Base, SkipBase, zSkipOffsetString)

xAccelerationAddress := GetAddress(PID, Base, AccelerationBase, xAccelerationOffsetString)
yAccelerationAddress := GetAddress(PID, Base, AccelerationBase, yAccelerationOffsetString)
zAccelerationAddress := GetAddress(PID, Base, AccelerationBase, zAccelerationOffsetString)

xViewAddress := GetAddress(PID, Base, ViewBase, xViewOffsetString)
yViewAddress := GetAddress(PID, Base, ViewBase, yViewOffsetString)
zViewAddress := GetAddress(PID, Base, ViewBase, zViewOffsetString)

SpeedAddress := GetAddress(PID, Base, SpeedBase, SpeedOffsetString)

currentCDAddress := GetAddress(PID, Base, CDBase, currentCDOffsetString)
minCDAddress := GetAddress(PID, Base, CDBase, minCDOffsetString)
maxCDAddress := GetAddress(PID, Base, CDBase, maxCDOffsetString)

EncKeyAddress := GetAddress(PID, Base, EncKeyBase, EncKeyOffsetString)
return

Save:
GuiControlGet,PointerAutoUpdate,,PointerAutoUpdate
GuiControlGet,EnableUpdateCheck,,EnableUpdateCheck
GuiControlGet,ShowTooltip,,ShowTooltip
GuiControlGet,DecSpeedValue,,DecSpeedValue
GuiControlGet,FlyAccel,,FlyAccel
GuiControlGet,SkipDistance,,SkipDistance
GuiControlGet,SuperJumpAccel,,SuperJumpAccel
GuiControlGet,FallManipulationAccel,,FallManipulationAccel
GuiControlGet,minCamDistance,,minCamDistance
GuiControlGet,maxCamDistance,,maxCamDistance

IniWrite,%PointerAutoUpdate%,%iniFile%,General,PointerAutoUpdate
IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip
IniWrite,%DecSpeedValue%,%iniFile%,General,LastSpeed
IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel
IniWrite,%FallManipulationAccel%,%iniFile%,Values,FallManipulationAccel
IniWrite,%minCamDistance%,%iniFile%,Values,minCamDistance
IniWrite,%maxCamDistance%,%iniFile%,Values,maxCamDistance

Gosub, CustomCamDistanceLimit ;Set after change
Gosub, CalcEncSpeedValue ;re-calculate Speedvalue after Dec. Value changed
return

GuiClose:
ExitApp

Restart:
Run %A_ScriptFullPath%
ExitApp

ExitScript: ;called through "ExitFunktion()" use "ExitApp" to run that code on exit.
ExitApp

;------------------------
;SetTimer Subs:
;------------------------

ToolTip:
if(WinActive("ahk_exe Trove.exe") && ShowTooltip == 1)
{
    ToolTipString := "PID = " PID
	if (EnableSpeed == 1)
	{
        ToolTipString := ToolTipString "`n" "Speed Hack = " DecSpeedValue "ms"
	}
	if (EnableyFreeze == 1)
	{
        ToolTipString := ToolTipString "`n" "Freeze High = ON"
	}
	if (EnableFreeze == 1)
	{
        ToolTipString := ToolTipString "`n" "Freeze Position = ON"
	}
	if (EnableFloat == 1)
	{
        ToolTipString := ToolTipString "`n" "Float = ON"
	}
	if (EnableSuperJump == 1)
	{
        ToolTipString := ToolTipString "`n" "Super Jump = ON"
	}
	if (EnableFallManipulation == 1)
	{
        ToolTipString := ToolTipString "`n" "Fall manipulation = ON"
	}
	if (EnableAntiAFK == 1)
	{
    	ToolTipString := ToolTipString "`n" "Anti AFK = ON"
	}
	ToolTip, %ToolTipString%, 0, 0, 1
}
else
{
	ToolTip,,,,1
}
SetTimer, ToolTip, -70
return

refreshAddress:
Gosub, getAddress

if (oldySkipAddress != ySkipAddress || oldPID != PID)
{
	Gosub, runAtAddressChange
}

oldPID := PID
oldySkipAddress := ySkipAddress

SetTimer, refreshAddress, -1000
return
