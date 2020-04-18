loadINI:
if !FileExist(PointerFile)
{
	WritePointertoini(PointerFile)
}

if !FileExist(iniFile)
{
	IniWrite,1,%iniFile%,Version,ConfigVersion

	IniWrite,%PointerAutoUpdate%,%iniFile%,General,PointerAutoUpdate
	IniWrite,%EnableUpdateCheck%,%iniFile%,General,EnableUpdateCheck
    IniWrite,%DecSpeedValue%,%iniFile%,General,LastSpeed
	IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip

	IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
	IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
	IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel
	IniWrite,%FallManipulationAccel%,%iniFile%,Values,FallManipulationAccel
	IniWrite,%minCamDistance%,%iniFile%,Values,minCamDistance
	IniWrite,%maxCamDistance%,%iniFile%,Values,maxCamDistance
	IniWrite,%FloatAccel%,%iniFile%,Values,FloatAccel

	Gosub, SaveHotkeysToINI
	Gosub, SaveTroveHotkeysToINI
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
    IniRead,DecSpeedValue,%iniFile%,General,LastSpeed
	IniRead,ShowTooltip,%iniFile%,General,ShowTooltip

	IniRead,FlyAccel,%iniFile%,Values,FlyAccel
	IniRead,SkipDistance,%iniFile%,Values,SkipDistance
	IniRead,SuperJumpAccel,%iniFile%,Values,SuperJumpAccel
	IniRead,FallManipulationAccel,%iniFile%,Values,FallManipulationAccel
	IniRead,minCamDistance,%iniFile%,Values,minCamDistance
	IniRead,maxCamDistance,%iniFile%,Values,maxCamDistance
	IniRead,FloatAccel,%iniFile%,Values,FloatAccel

	Gosub, LoadHotkeysFromINI
	Gosub, LoadTroveHotkeysFromINI
}
Return

WritePointertoini(ini)
{
	if (LastUpdateSupport != "ERROR")
	{
		IniWrite,%LastUpdateSupport%,%ini%,date,LastUpdateSupport

		IniWrite,%SkipBase%,%ini%,skip,Base
		IniWrite,%xSkipOffsetString%,%ini%,skip,xOffsets
		IniWrite,%ySkipOffsetString%,%ini%,skip,yOffsets
		IniWrite,%zSkipOffsetString%,%ini%,skip,zOffsets
		IniWrite,%AccelerationBase%,%ini%,acceleration,Base
		IniWrite,%xAccelerationOffsetString%,%ini%,acceleration,xOffsets
		IniWrite,%yAccelerationOffsetString%,%ini%,acceleration,yOffsets
		IniWrite,%zAccelerationOffsetString%,%ini%,acceleration,zOffsets
		IniWrite,%ViewBase%,%ini%,view,Base
		IniWrite,%xViewOffsetString%,%ini%,view,xOffsets
		IniWrite,%yViewOffsetString%,%ini%,view,yOffsets
		IniWrite,%zViewOffsetString%,%ini%,view,zOffsets
		IniWrite,%SpeedBase%,%ini%,speed,Base
		IniWrite,%SpeedOffsetString%,%ini%,speed,Offsets
		IniWrite,%CDBase%,%ini%,camera_Distance,Base
		IniWrite,%minCDOffsetString%,%ini%,camera_Distance,minOffset
		IniWrite,%maxCDOffsetString%,%ini%,camera_Distance,maxOffset
		IniWrite,%EncKeyBase%,%ini%,StatEncKey,Base
		IniWrite,%EncKeyOffsetString%,%ini%,StatEncKey,Offsets

		state := TRUE
	}
	else
	{
		state := FALSE
	}
	
	return state
}

ReadPointerfromini(ini)
{
	IniRead,LastUpdateSupport,%ini%,date,LastUpdateSupport

	IniRead,SkipBase,%ini%,skip,Base
	IniRead,xSkipOffsetString,%ini%,skip,xOffsets
	IniRead,ySkipOffsetString,%ini%,skip,yOffsets
	IniRead,zSkipOffsetString,%ini%,skip,zOffsets
	IniRead,AccelerationBase,%ini%,acceleration,Base
	IniRead,xAccelerationOffsetString,%ini%,acceleration,xOffsets
	IniRead,yAccelerationOffsetString,%ini%,acceleration,yOffsets
	IniRead,zAccelerationOffsetString,%ini%,acceleration,zOffsets
	IniRead,ViewBase,%ini%,view,Base
	IniRead,xViewOffsetString,%ini%,view,xOffsets
	IniRead,yViewOffsetString,%ini%,view,yOffsets
	IniRead,zViewOffsetString,%ini%,view,zOffsets
	IniRead,SpeedBase,%ini%,speed,Base
	IniRead,SpeedOffsetString,%ini%,speed,Offsets
	IniRead,CDBase,%ini%,camera_Distance,Base
	IniRead,minCDOffsetString,%ini%,camera_Distance,minOffset
	IniRead,maxCDOffsetString,%ini%,camera_Distance,maxOffset
	IniRead,EncKeyBase,%ini%,StatEncKey,Base
	IniRead,EncKeyOffsetString,%ini%,StatEncKey,Offsets
}

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
if (ConfigVersion < 5)
{
	ConfigVersion := 5
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%minCamDistance%,%iniFile%,Values,minCamDistance
	IniWrite,%maxCamDistance%,%iniFile%,Values,maxCamDistance
}
if (ConfigVersion < 6)
{
	ConfigVersion := 6
	IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion
	IniWrite,%FloatAccel%,%iniFile%,Values,FloatAccel
}
return
