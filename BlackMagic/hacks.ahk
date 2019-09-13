;------------------------
;Skip:
;------------------------

ViewSkip:
Gosub, CheckTroveWindow
xcurrentpos := HexToFloat(ReadMemory(xSkipAddress, PID))
ycurrentpos := HexToFloat(ReadMemory(ySkipAddress, PID))
zcurrentpos := HexToFloat(ReadMemory(zSkipAddress, PID))
xcurrentView := HexToFloat(ReadMemory(xViewAddress, PID))
ycurrentView := HexToFloat(ReadMemory(yViewAddress, PID))
zcurrentView := HexToFloat(ReadMemory(zViewAddress, PID))
xnewpos := xcurrentpos + (xcurrentView * SkipDistance)
ynewpos := ycurrentpos + (ycurrentView * SkipDistance)
znewpos := zcurrentpos + (zcurrentView * SkipDistance)
WriteProcessMemory(pid, xSkipAddress, FloatToHex(xnewpos))
WriteProcessMemory(pid, ySkipAddress, FloatToHex(ynewpos))
WriteProcessMemory(pid, zSkipAddress, FloatToHex(znewpos))
sleep, 100
return

;------------------------
;Acceleration Fly:
;------------------------

AccelerationFly:
Gosub, CheckTroveWindow
xcurrentView := HexToFloat(ReadMemory(xViewAddress, PID))
ycurrentView := HexToFloat(ReadMemory(yViewAddress, PID))
zcurrentView := HexToFloat(ReadMemory(zViewAddress, PID))
xnewAccel := xcurrentView * FlyAccel
ynewAccel := ycurrentView * FlyAccel
znewAccel := zcurrentView * FlyAccel
WriteProcessMemory(pid, xAccelerationAddress, FloatToHex(xnewAccel))
WriteProcessMemory(pid, yAccelerationAddress, FloatToHex(ynewAccel))
WriteProcessMemory(pid, zAccelerationAddress, FloatToHex(znewAccel))
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
