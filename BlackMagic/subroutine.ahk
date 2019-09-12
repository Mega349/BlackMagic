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
	ToolTip, %ToolTipString%, 0, 0, 1
}
else
{
	ToolTip,,,,1
}
SetTimer, ToolTip, -70
return

CheckTroveWindow:
WinGet, PID, PID, ahk_exe Trove.exe
WinGet, hwnd, ID, ahk_pid %PID%
Base := getProcessBaseAddress(hwnd)

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

IniWrite,%PointerAutoUpdate%,%iniFile%,General,PointerAutoUpdate
IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip
IniWrite,%Speed%,%iniFile%,General,LastSpeed
IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
return

Updateini:
if (ConfigVersion < 2 || ConfigVersion == "" || ConfigVersion == "ERROR")
{
	ConfigVersion := 2
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
}
return

GuiClose:
ExitApp

Restart:
Run %A_ScriptFullPath%
ExitApp

ExitScript: ;wird durch "ExitFunktion()" aufgerufen zum beenden einfach den "ExitApp"-Befehl verwenden
ExitApp