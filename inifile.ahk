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
    IniWrite,%LastSpeed%,%iniFile%,General,LastSpeed
	IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip

	IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
	IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance

	IniWrite,%SpeedKey%,%iniFile%,Hotkeys,SpeedKey
	IniWrite,%FreezeKey%,%iniFile%,Hotkeys,FreezeKey
	IniWrite,%yFreezeKey%,%iniFile%,Hotkeys,yFreezeKey
	IniWrite,%FlyKey%,%iniFile%,Hotkeys,FlyKey
	IniWrite,%SkipKey%,%iniFile%,Hotkeys,SkipKey
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
    IniRead,Speed,%iniFile%,General,LastSpeed
	IniRead,ShowTooltip,%iniFile%,General,ShowTooltip

	IniRead,FlyAccel,%iniFile%,Values,FlyAccel
	IniRead,SkipDistance,%iniFile%,Values,SkipDistance

	IniRead,SpeedKey,%iniFile%,Hotkeys,SpeedKey
	IniRead,FreezeKey,%iniFile%,Hotkeys,FreezeKey
	IniRead,yFreezeKey,%iniFile%,Hotkeys,yFreezeKey
	IniRead,FlyKey,%iniFile%,Hotkeys,FlyKey
	IniRead,SkipKey,%iniFile%,Hotkeys,SkipKey
}