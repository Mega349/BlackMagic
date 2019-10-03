if !FileExist(PointerFile)
{
	WritePointertoini(PointerFile)
}

if !FileExist(SpeedFile)
{
	Gosub, UpdateSpeedFile
}

if !FileExist(iniFile)
{
	IniWrite,1,%iniFile%,Version,ConfigVersion

	IniWrite,%PointerAutoUpdate%,%iniFile%,General,PointerAutoUpdate
	IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
    IniWrite,%LastSpeed%,%iniFile%,General,LastSpeed
	IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip

	IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
	IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
	IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel

	Gosub, SaveHotkeysToINI
}

;------------------------

if FileExist(PointerFile)
{
	ReadPointerfromini(PointerFile)
}

if FileExist(iniFile)
{
	IniRead,ConfigVersion,%iniFile%,Version,ConfigVersion

	Gosub, Updateini

	IniRead,PointerAutoUpdate,%iniFile%,General,PointerAutoUpdate
	IniRead,EnableUpdateCheck,%iniFile%,General,EnableUpdateCheck
    IniRead,Speed,%iniFile%,General,LastSpeed
	IniRead,ShowTooltip,%iniFile%,General,ShowTooltip

	IniRead,FlyAccel,%iniFile%,Values,FlyAccel
	IniRead,SkipDistance,%iniFile%,Values,SkipDistance
	IniRead,SuperJumpAccel,%iniFile%,Values,SuperJumpAccel

	Gosub, LoadHotkeysFromINI
}
