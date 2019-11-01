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
return

RestoreSpeedFile:
if FileExist(SpeedFileBackup)
{
    MsgBox, 4, %ScriptName%,% "Are you sure you want to restore the backup?"
	IfMsgBox, Yes
    {
	    FileCopy, %SpeedFileBackup%, %SpeedFile%, TRUE
	    Gosub, Restart
    }
}
else
{
	msgbox, no Backup found!
}
return

UpdateSpeedFile:
if FileExist(SpeedFileBackup)
{
	MsgBox, 4, %ScriptName%,% "A backup already exists.`nshould " SpeedFileBackup " be overwritten?"
	IfMsgBox, Yes
	{
		FileCopy, %SpeedFile%, %SpeedFileBackup%, TRUE
	}
}
else if FileExist(SpeedFile)
{
	FileCopy, %SpeedFile%, %SpeedFileBackup%, TRUE
}
try
{
	UrlDownloadToFile, %SpeedHostFile% , %SpeedFile%
}
Gosub, Restart
return

Save:
GuiControlGet,PointerAutoUpdate,,PointerAutoUpdate
GuiControlGet,EnableUpdateCheck,,EnableUpdateCheck
GuiControlGet,ShowTooltip,,ShowTooltip
GuiControlGet,Speed,,Speed
GuiControlGet,FlyAccel,,FlyAccel
GuiControlGet,SkipDistance,,SkipDistance
GuiControlGet,SuperJumpAccel,,SuperJumpAccel
GuiControlGet,FallManipulationAccel,,FallManipulationAccel

IniWrite,%PointerAutoUpdate%,%iniFile%,General,PointerAutoUpdate
IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip
IniWrite,%Speed%,%iniFile%,General,LastSpeed
IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel
IniWrite,%FallManipulationAccel%,%iniFile%,Values,FallManipulationAccel
return

Updateini:
if (ConfigVersion < 2 || ConfigVersion == "" || ConfigVersion == "ERROR")
{
	ConfigVersion := 2
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
	IniWrite,%FloatKey%,%iniFile%,Hotkeys,FloatKey
}
if (ConfigVersion < 3)
{
	ConfigVersion := 3
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%SuperJumpKey%,%iniFile%,Hotkeys,SuperJumpKey
	IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel
}
if (ConfigVersion < 4)
{
	ConfigVersion := 4
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%TroveJumpKey%,%iniFile%,TroveHotkeys,TroveJumpKey
	IniWrite,%TroveAntiAFKKey%,%iniFile%,TroveHotkeys,TroveAntiAFKKey
	IniWrite,%FallManipulationKey%,%iniFile%,Hotkeys,FallManipulationKey
	IniWrite,%AntiAFKKey%,%iniFile%,Hotkeys,AntiAFKKey
	IniWrite,%FallManipulationAccel%,%iniFile%,Values,FallManipulationAccel
}
return

GuiClose:
ExitApp

Restart:
Run %A_ScriptFullPath%
ExitApp

ExitScript: ;wird durch "ExitFunktion()" aufgerufen zum beenden einfach den "ExitApp"-Befehl verwenden
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
        ToolTipString := ToolTipString "`n" "Speed Hack = " SpeedDispValue[Speed] "ms"
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

if (oldySkipAddress != ySkipAddress)
{
	Gosub, DisableHacksAtAddressChanged
}

oldySkipAddress := ySkipAddress

SetTimer, refreshAddress, -1000
return
