;------------------------
;Skip:
;------------------------

ViewSkip:
Gosub, CheckTroveWindow
xSkipCurrentPos := HexToFloat(ReadMemory(xSkipAddress, PID))
ySkipCurrentPos := HexToFloat(ReadMemory(ySkipAddress, PID))
zSkipCurrentPos := HexToFloat(ReadMemory(zSkipAddress, PID))
xSkipCurrentView := HexToFloat(ReadMemory(xViewAddress, PID))
ySkipCurrentView := HexToFloat(ReadMemory(yViewAddress, PID))
zSkipCurrentView := HexToFloat(ReadMemory(zViewAddress, PID))
xSkipNewPos := xSkipCurrentPos + (xSkipCurrentView * SkipDistance)
ySkipNewPos := ySkipCurrentPos + (ySkipCurrentView * SkipDistance)
zSkipNewPos := zSkipCurrentPos + (zSkipCurrentView * SkipDistance)
WriteProcessMemory(pid, xSkipAddress, FloatToHex(xSkipNewPos))
WriteProcessMemory(pid, ySkipAddress, FloatToHex(ySkipNewPos))
WriteProcessMemory(pid, zSkipAddress, FloatToHex(zSkipNewPos))
sleep, 100
return

;------------------------
;Acceleration Fly:
;------------------------

AccelerationFly:
Gosub, CheckTroveWindow
xFlyCurrentView := HexToFloat(ReadMemory(xViewAddress, PID))
yFlyCurrentView := HexToFloat(ReadMemory(yViewAddress, PID))
zFlyCurrentView := HexToFloat(ReadMemory(zViewAddress, PID))
xFlyNewAccel := xFlyCurrentView * FlyAccel
yFlyNewAccel := yFlyCurrentView * FlyAccel
zFlyNewAccel := zFlyCurrentView * FlyAccel
WriteProcessMemory(pid, xAccelerationAddress, FloatToHex(xFlyNewAccel))
WriteProcessMemory(pid, yAccelerationAddress, FloatToHex(yFlyNewAccel))
WriteProcessMemory(pid, zAccelerationAddress, FloatToHex(zFlyNewAccel))
sleep, 20
return

;------------------------
;Freeze:
;------------------------

StartFreeze:
Gosub, CheckTroveWindow
xFreezePos := HexToFloat(ReadMemory(xSkipAddress, PID))
zFreezePos := HexToFloat(ReadMemory(zSkipAddress, PID))
EnableFreeze := 1
Gosub, Freeze
return

StopFreeze:
EnableFreeze := 0
return

Freeze:
if (EnableFreeze == 1)
{
	WriteProcessMemory(PID, xSkipAddress, FloatToHex(xFreezePos))
	WriteProcessMemory(PID, zSkipAddress, FloatToHex(zFreezePos))
	SetTimer, Freeze, -20
}
return

;------------------------
;High Freeze (yFreeze):
;------------------------

StartyFreeze:
Gosub, CheckTroveWindow
yFreezePos := HexToFloat(ReadMemory(ySkipAddress, PID))
EnableyFreeze := 1
Gosub, yFreeze
return

StopyFreeze:
EnableyFreeze := 0
return

yFreeze:
if (EnableyFreeze == 1)
{
	WriteProcessMemory(PID, ySkipAddress, FloatToHex(yFreezePos))
	SetTimer, yFreeze, -20
}
return

;------------------------
;Speed:
;------------------------

StartSpeed:
Gosub, CheckTroveWindow
EnableSpeed := 1
Gosub, Speed
return

StopSpeed:
EnableSpeed := 0
return

Speed:
if (EnableSpeed == 1)
{
	WriteProcessMemory(PID, SpeedAddress, SpeedValue[Speed])
	SetTimer, Speed, -20
}
return

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
	WriteProcessMemory(pid, yAccelerationAddress, FloatToHex(0.6))
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
		ySuperJumpCurrentAccel := HexToFloat(ReadMemory(yAccelerationAddress, PID))
	}
	if (ySuperJumpCurrentAccel > 8) ;dont Jump if Writing in Chat or something else
	{
		WriteProcessMemory(PID, yAccelerationAddress, FloatToHex(SuperJumpAccel))
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
	if (HexToFloat(ReadMemory(yAccelerationAddress, PID)) < 0 )
	{
		WriteProcessMemory(PID, yAccelerationAddress, FloatToHex(FallManipulationAccel))
	}
	SetTimer, FallManipulation, -5
}
return

;------------------------
;Anti AFK:
;------------------------

StartAntiAFK:
EnableAntiAFK := 1
Gosub, AntiAFK
return

StopAntiAFK:
EnableAntiAFK := 0
return

AntiAFK:
if (EnableAntiAFK == 1)
{
	if(WinActive("ahk_exe Trove.exe"))
	{	
		send, %TroveAntiAFKKey%
	}
	SetTimer, AntiAFK, -%AntiAFKDelay%
}
return

;------------------------
;Stop if Address Changed:
;------------------------

DisableHacksAtAddressChanged:
Gosub, StopFloat
Gosub, StopyFreeze
Gosub, StopFreeze
Gosub, StopAntiAFK
return
