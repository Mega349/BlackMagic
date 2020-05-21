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
	IniWrite,%ShowTooltip%,%iniFile%,General,ShowTooltip

  	IniWrite,%DecSpeedValue%,%iniFile%,Values,Speed
	IniWrite,%FlyAccel%,%iniFile%,Values,FlyAccel
	IniWrite,%SkipDistance%,%iniFile%,Values,SkipDistance
	IniWrite,%SuperJumpAccel%,%iniFile%,Values,SuperJumpAccel
	IniWrite,%FallManipulationAccel%,%iniFile%,Values,FallManipulationAccel
	IniWrite,%minCamDistance%,%iniFile%,Values,minCamDistance
	IniWrite,%maxCamDistance%,%iniFile%,Values,maxCamDistance
	IniWrite,%FloatAccel%,%iniFile%,Values,FloatAccel

	IniWrite,%EnableForceAccel%,%iniFile%,Modifier,EnableForceAccel
	IniWrite,%EnableStopIfDontMove%,%iniFile%,Modifier,EnableStopIfDontMove

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
	IniRead,ShowTooltip,%iniFile%,General,ShowTooltip

	IniRead,DecSpeedValue,%iniFile%,Values,Speed
	IniRead,FlyAccel,%iniFile%,Values,FlyAccel
	IniRead,SkipDistance,%iniFile%,Values,SkipDistance
	IniRead,SuperJumpAccel,%iniFile%,Values,SuperJumpAccel
	IniRead,FallManipulationAccel,%iniFile%,Values,FallManipulationAccel
	IniRead,minCamDistance,%iniFile%,Values,minCamDistance
	IniRead,maxCamDistance,%iniFile%,Values,maxCamDistance
	IniRead,FloatAccel,%iniFile%,Values,FloatAccel

	IniRead,EnableForceAccel,%iniFile%,Modifier,EnableForceAccel
	IniRead,EnableStopIfDontMove,%iniFile%,Modifier,EnableStopIfDontMove

	Gosub, LoadHotkeysFromINI
	Gosub, LoadTroveHotkeysFromINI
}
Return

WritePointertoini(ini)
{
	if (LastUpdateSupport != "ERROR")
	{
		IniWrite,%LastUpdateSupport%,%ini%,date,LastUpdateSupport

		IniWrite,%SkipSize%,%ini%,skip,Size 
		IniWrite,%SkipBase%,%ini%,skip,Base
		IniWrite,%xSkipOffsetString%,%ini%,skip,xOffsets
		IniWrite,%ySkipOffsetString%,%ini%,skip,yOffsets
		IniWrite,%zSkipOffsetString%,%ini%,skip,zOffsets
		
		IniWrite,%AccelerationSize%,%ini%,acceleration,Size
		IniWrite,%AccelerationBase%,%ini%,acceleration,Base
		IniWrite,%xAccelerationOffsetString%,%ini%,acceleration,xOffsets
		IniWrite,%yAccelerationOffsetString%,%ini%,acceleration,yOffsets
		IniWrite,%zAccelerationOffsetString%,%ini%,acceleration,zOffsets
		
		IniWrite,%ViewSize%,%ini%,view,Size
		IniWrite,%ViewBase%,%ini%,view,Base
		IniWrite,%xViewOffsetString%,%ini%,view,xOffsets
		IniWrite,%yViewOffsetString%,%ini%,view,yOffsets
		IniWrite,%zViewOffsetString%,%ini%,view,zOffsets
		
		IniWrite,%SpeedSize%,%ini%,speed,Size
		IniWrite,%SpeedBase%,%ini%,speed,Base
		IniWrite,%SpeedOffsetString%,%ini%,speed,Offsets
		
		IniWrite,%CDBase%,%ini%,camera_Distance,Size
		IniWrite,%CDBase%,%ini%,camera_Distance,Base
		IniWrite,%minCDOffsetString%,%ini%,camera_Distance,minOffset
		IniWrite,%maxCDOffsetString%,%ini%,camera_Distance,maxOffset
		
		IniWrite,%cViewSize%,%ini%,cView,Size
		IniWrite,%cViewBase%,%ini%,cView,Base
		IniWrite,%cViewHightSOffsetString%,%ini%,cView,Hight
		IniWrite,%cViewWidthOffsetString%,%ini%,cView,Width

		IniWrite,%EncKeySize%,%ini%,StatEncKey,Size
		IniWrite,%EncKeyBase%,%ini%,StatEncKey,Base
		IniWrite,%EncKeyOffsetString%,%ini%,StatEncKey,Offsets

		IniWrite,%InputBoxSize%,%ini%,InputBox,Size
		IniWrite,%InputBoxBase%,%ini%,InputBox,Base

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

	IniRead,SkipSize,%ini%,skip,Size 
	IniRead,SkipBase,%ini%,skip,Base
	IniRead,xSkipOffsetString,%ini%,skip,xOffsets
	IniRead,ySkipOffsetString,%ini%,skip,yOffsets
	IniRead,zSkipOffsetString,%ini%,skip,zOffsets
	
	IniRead,AccelerationSize,%ini%,acceleration,Size
	IniRead,AccelerationBase,%ini%,acceleration,Base
	IniRead,xAccelerationOffsetString,%ini%,acceleration,xOffsets
	IniRead,yAccelerationOffsetString,%ini%,acceleration,yOffsets
	IniRead,zAccelerationOffsetString,%ini%,acceleration,zOffsets
	
	IniRead,ViewSize,%ini%,view,Size
	IniRead,ViewBase,%ini%,view,Base
	IniRead,xViewOffsetString,%ini%,view,xOffsets
	IniRead,yViewOffsetString,%ini%,view,yOffsets
	IniRead,zViewOffsetString,%ini%,view,zOffsets
	
	IniRead,SpeedSize,%ini%,speed,Size
	IniRead,SpeedBase,%ini%,speed,Base
	IniRead,SpeedOffsetString,%ini%,speed,Offsets
	
	IniRead,CDBase,%ini%,camera_Distance,Size
	IniRead,CDBase,%ini%,camera_Distance,Base
	IniRead,minCDOffsetString,%ini%,camera_Distance,minOffset
	IniRead,maxCDOffsetString,%ini%,camera_Distance,maxOffset
	
	IniRead,cViewSize,%ini%,cView,Size
	IniRead,cViewBase,%ini%,cView,Base
	IniRead,cViewHightSOffsetString,%ini%,cView,Hight
	IniRead,cViewWidthOffsetString,%ini%,cView,Width

	IniRead,EncKeySize,%ini%,StatEncKey,Size
	IniRead,EncKeyBase,%ini%,StatEncKey,Base
	IniRead,EncKeyOffsetString,%ini%,StatEncKey,Offsets

	IniRead,InputBoxSize,%ini%,InputBox,Size
	IniRead,InputBoxBase,%ini%,InputBox,Base
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
	if (ConfigVersion < 7)
	{
		ConfigVersion := 7
		IniWrite,%ConfigVersion%,%iniFile%,Version,ConfigVersion

		IniWrite,%TroveMoveForwardKey%,%iniFile%,TroveHotkeys,TroveMoveForwardKey
		IniWrite,%TroveMoveLeftKey%,%iniFile%,TroveHotkeys,TroveMoveLeftKey
		IniWrite,%TroveMoveBackwardKey%,%iniFile%,TroveHotkeys,TroveMoveBackwardKey
		IniWrite,%TroveMoveRightKey%,%iniFile%,TroveHotkeys,TroveMoveRightKey

		IniWrite,%EnableForceAccel%,%iniFile%,Modifier,EnableForceAccel
		IniWrite,%EnableStopIfDontMove%,%iniFile%,Modifier,EnableStopIfDontMove

		IniWrite,%DecSpeedValue%,%iniFile%,Values,Speed
	}
	return
