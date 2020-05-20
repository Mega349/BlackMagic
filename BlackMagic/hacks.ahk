;------------------------
;Skip:
;------------------------

ViewSkip:
	Gosub, CheckTroveWindow
	xSkipCurrentPos := HexToFloat(ReadMemory(xSkipAddress, PID, SkipSize))
	ySkipCurrentPos := HexToFloat(ReadMemory(ySkipAddress, PID, SkipSize))
	zSkipCurrentPos := HexToFloat(ReadMemory(zSkipAddress, PID, SkipSize))
	xSkipCurrentView := HexToFloat(ReadMemory(xViewAddress, PID, ViewSize))
	ySkipCurrentView := HexToFloat(ReadMemory(yViewAddress, PID, ViewSize))
	zSkipCurrentView := HexToFloat(ReadMemory(zViewAddress, PID, ViewSize))
	xSkipNewPos := xSkipCurrentPos + (xSkipCurrentView * SkipDistance)
	ySkipNewPos := ySkipCurrentPos + (ySkipCurrentView * SkipDistance)
	zSkipNewPos := zSkipCurrentPos + (zSkipCurrentView * SkipDistance)
	WriteProcessMemory(pid, xSkipAddress, FloatToHex(xSkipNewPos), SkipSize)
	WriteProcessMemory(pid, ySkipAddress, FloatToHex(ySkipNewPos), SkipSize)
	WriteProcessMemory(pid, zSkipAddress, FloatToHex(zSkipNewPos), SkipSize)
	sleep, 100
	return

;------------------------
;Acceleration Fly:
;------------------------

AccelerationFly:
	Gosub, CheckTroveWindow
	xFlyCurrentView := HexToFloat(ReadMemory(xViewAddress, PID, ViewSize))
	yFlyCurrentView := HexToFloat(ReadMemory(yViewAddress, PID, ViewSize))
	zFlyCurrentView := HexToFloat(ReadMemory(zViewAddress, PID, ViewSize))
	xFlyNewAccel := xFlyCurrentView * FlyAccel
	yFlyNewAccel := yFlyCurrentView * FlyAccel
	zFlyNewAccel := zFlyCurrentView * FlyAccel
	WriteProcessMemory(pid, xAccelerationAddress, FloatToHex(xFlyNewAccel), AccelerationSize)
	WriteProcessMemory(pid, yAccelerationAddress, FloatToHex(yFlyNewAccel), AccelerationSize)
	WriteProcessMemory(pid, zAccelerationAddress, FloatToHex(zFlyNewAccel), AccelerationSize)
	sleep, 20
	return

;------------------------
;Freeze:
;------------------------

StartFreeze:
	Gosub, CheckTroveWindow
	xFreezePos := HexToFloat(ReadMemory(xSkipAddress, PID, SkipSize))
	zFreezePos := HexToFloat(ReadMemory(zSkipAddress, PID, SkipSize))
	EnableFreeze := 1
	Gosub, Freeze
	return

StopFreeze:
	EnableFreeze := 0
	return

Freeze:
	if (EnableFreeze == 1)
	{
		WriteProcessMemory(PID, xSkipAddress, FloatToHex(xFreezePos), SkipSize)
		WriteProcessMemory(PID, zSkipAddress, FloatToHex(zFreezePos), SkipSize)
		SetTimer, Freeze, -20
	}
	return

;------------------------
;High Freeze (yFreeze):
;------------------------

StartyFreeze:
	Gosub, CheckTroveWindow
	yFreezePos := HexToFloat(ReadMemory(ySkipAddress, PID, SkipSize))
	EnableyFreeze := 1
	Gosub, yFreeze
	return

StopyFreeze:
	EnableyFreeze := 0
	return

yFreeze:
	if (EnableyFreeze == 1)
	{
		WriteProcessMemory(PID, ySkipAddress, FloatToHex(yFreezePos), SkipSize)
		SetTimer, yFreeze, -20
	}
	return

;------------------------
;Speed:
;------------------------

StartSpeed:
	Gosub, CheckTroveWindow
	Gosub, CalcEncSpeedValue
	EnableSpeed := 1
	Gosub, Speed
	return

StopSpeed:
	EnableSpeed := 0
	return

Speed:
	if (EnableSpeed == 1)
	{
		WriteProcessMemory(PID, SpeedAddress, EncSpeedValue, SpeedSize)

		if (EnableForceAccel || EnableStopIfDontMove)
		{
			Gosub, getBitWiseWASD
		}

		if (EnableForceAccel)
		{
			Gosub, CalcNewSpeedAccel
			if (wasd != 0x0)
			{
				WriteProcessMemory(pid, xAccelerationAddress, FloatToHex(xNewSpeedAccel), AccelerationSize)
				WriteProcessMemory(pid, zAccelerationAddress, FloatToHex(zNewSpeedAccel), AccelerationSize)
			}
		}

		if (wasd == 0x0 && EnableStopIfDontMove)
		{
			WriteProcessMemory(pid, xAccelerationAddress, FloatToHex(0), AccelerationSize)
			WriteProcessMemory(pid, zAccelerationAddress, FloatToHex(0), AccelerationSize)
		}

		SetTimer, Speed, -20
	}
	return

CalcEncSpeedValue:
	Gosub, CheckTroveWindow
	EncSpeedValue := FloatToHex(DecSpeedValue) ^ ReadMemory(EncKeyAddress, PID, EncKeySize)
	return

CalcNewSpeedAccel:
	SpeedBaseAccel := (DecSpeedValue/10)
	SpeedCurrentCameraWidth := HexToFloat(ReadMemory(cViewWidthAddress, PID, cViewSize))
	SpeedCurrentCameraAngel := (360/(2*PI)) * SpeedCurrentCameraWidth

	switch wasd
	{
		case 0x8,0xD,0xF: 	SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel, 360)  		;w,wad,wasd
		case 0xC,0xE:		SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 45, 360)	;wa,was
		case 0x4:			SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 90, 360)	;a
		case 0x6:			SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 135, 360)	;as
		case 0x2,0x7:		SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 180, 360)	;s,asd
		case 0x3:			SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 225, 360)	;sd
		case 0x1:			SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 270, 360)	;d
		case 0x9,0xB:		SpeedNewCameraAngel := mod(SpeedCurrentCameraAngel + 315, 360)	;wd,wsd
	}

	xNewSpeedAccel := SpeedBaseAccel * sin(SpeedNewCameraAngel * (PI / 180))
	zNewSpeedAccel := SpeedBaseAccel * cos(SpeedNewCameraAngel * (PI / 180))
	return

; angelInDegree = (360/(2*PI)) * CameraWidth
; angelInRadian = angelInDegree * (PI/180)
; xView = sin(angelInRadian)
; zView = cos(angelInRadian)

;------------------------
;Float:
;------------------------

StartFloat:
	Gosub, CheckTroveWindow
	EnableFloat := 1
	Gosub, Float
	return

StopFloat:
	EnableFloat := 0
	return

Float:
	if (EnableFloat == 1)
	{
		WriteProcessMemory(pid, yAccelerationAddress, FloatToHex(FloatAccel), AccelerationSize)
		SetTimer, Float, -10
	}
	return

;------------------------
;Super Jump:
;------------------------

StartSuperJump:
	Gosub, CheckTroveWindow
	EnableSuperJump := 1
	Gosub, SuperJump
	return

StopSuperJump:
	EnableSuperJump := 0
	return

SuperJump:
	if (EnableSuperJump == 1)
	{
		if (GetKeyState(TroveJumpKey, P))
		{
			ySuperJumpCurrentAccel := HexToFloat(ReadMemory(yAccelerationAddress, PID, AccelerationSize))
		}
		if (ySuperJumpCurrentAccel > 8) ;dont jump if writing in chat or something else
		{
			WriteProcessMemory(PID, yAccelerationAddress, FloatToHex(SuperJumpAccel), AccelerationSize)
			ySuperJumpCurrentAccel := 0
		}
		SetTimer, SuperJump, -5
	}
	return

;------------------------
;Fall Manipulation:
;------------------------

StartFallManipulation:
	Gosub, CheckTroveWindow
	EnableFallManipulation := 1
	Gosub, FallManipulation
	return

StopFallManipulation:
	EnableFallManipulation := 0
	return

FallManipulation:
	if (EnableFallManipulation == 1)
	{
		if (HexToFloat(ReadMemory(yAccelerationAddress, PID, AccelerationSize)) < 0 )
		{
			WriteProcessMemory(PID, yAccelerationAddress, FloatToHex(FallManipulationAccel), AccelerationSize)
		}
		SetTimer, FallManipulation, -5
	}
	return

;------------------------
;Anti AFK:
;------------------------

StartAntiAFK:
	Gosub, CheckTroveWindow
	EnableAntiAFK := 1
	Gosub, AntiAFK
	return

StopAntiAFK:
	EnableAntiAFK := 0
	return

AntiAFK:
	if (EnableAntiAFK == 1)
	{
		ControlSend, ahk_parent, {%TroveAntiAFKKey%}, ahk_pid %PID%
		SetTimer, AntiAFK, -%AntiAFKDelay%
	}
	return

;------------------------
;Custom Cam Distance Limit:
;------------------------

CustomCamDistanceLimit:
	WriteProcessMemory(PID, minCDAddress, FloatToHex(minCamDistance), CDSize)
	WriteProcessMemory(PID, maxCDAddress, FloatToHex(maxCamDistance), CDSize)
	return

;------------------------
;Run once at Address Change:
;------------------------

runAtAddressChange:
	Gosub, StopFloat
	Gosub, StopyFreeze
	Gosub, StopFreeze
	Gosub, StopAntiAFK

	Gosub, CustomCamDistanceLimit
	return
