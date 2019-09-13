;------------------------
;Pressed Hotkeys:
;------------------------

PressedSpeedKey:
if (EnableSpeed != 1)
{
    gosub, StartSpeed
}
Else
{
    gosub, StopSpeed
}
return

PressedFlyKey:
gosub, AccelerationFly
return

PressedSkipKey:
gosub, ViewSkip
return

PressedFreezeKey:
if (EnableFreeze != 1)
{
    gosub, StartFreeze
}
Else
{
    gosub, StopFreeze
}
return

PressedyFreezeKey:
if (EnableyFreeze != 1)
{
    gosub, StartyFreeze
}
Else
{
    gosub, StopyFreeze
}
return

PressedFloatKey:
if (EnableFloat != 1)
{
    Gosub, StartFloat
}
Else
{
    Gosub, StopFloat
}
return

;------------------------
;Subs for Hotkeys at GUI:
;------------------------


SaveHotkeysToINI:
IniWrite,%SkipKey%,%iniFile%,Hotkeys,SkipKey
IniWrite,%SpeedKey%,%iniFile%,Hotkeys,SpeedKey
IniWrite,%FreezeKey%,%iniFile%,Hotkeys,FreezeKey
IniWrite,%yFreezeKey%,%iniFile%,Hotkeys,yFreezeKey
IniWrite,%FlyKey%,%iniFile%,Hotkeys,FlyKey
IniWrite,%FloatKey%,%iniFile%,Hotkeys,FloatKey
return

LoadHotkeysFromINI:
IniRead,SkipKey,%iniFile%,Hotkeys,SkipKey
IniRead,SpeedKey,%iniFile%,Hotkeys,SpeedKey
IniRead,FreezeKey,%iniFile%,Hotkeys,FreezeKey
IniRead,yFreezeKey,%iniFile%,Hotkeys,yFreezeKey
IniRead,FlyKey,%iniFile%,Hotkeys,FlyKey
IniRead,FloatKey,%iniFile%,Hotkeys,FloatKey
return

SaveHotkeys:
Gosub, DisableHotkeys

GuiControlGet,SkipKey,,SkipKey
GuiControlGet,SpeedKey,,SpeedKey
GuiControlGet,FreezeKey,,FreezeKey
GuiControlGet,yFreezeKey,,yFreezeKey
GuiControlGet,FlyKey,,FlyKey
GuiControlGet,FloatKey,,FloatKey

Gosub, SaveHotkeysToINI
Gosub, LoadHotkeysFromINI
Gosub, InitHotkeys
return

InitHotkeys:
If !A_IsCompiled
{
    Hotkey, ^R, Restart
    Hotkey, ^T, ExitScript
}
if (SkipKey != "")
{
    Hotkey, %SkipKey%, PressedSkipKey, on
}


if (SpeedKey != "")
{
    Hotkey, %SpeedKey%, PressedSpeedKey, on
}

if (FreezeKey != "")
{
    Hotkey, %FreezeKey%, PressedFreezeKey, on
}

if (yFreezeKey != "")
{
    Hotkey, %yFreezeKey%, PressedyFreezeKey, on
}

if (FlyKey != "")
{
    Hotkey, %FlyKey%, PressedFlyKey, on
}

if (FloatKey != "")
{
    Hotkey, %FloatKey%, PressedFloatKey, on
}
return

DisableHotkeys:
if (SkipKey != "")
{
    Hotkey, %SkipKey%, PressedSkipKey, off
}

if (SpeedKey != "")
{
    Hotkey, %SpeedKey%, PressedSpeedKey, off
}

if (FreezeKey != "")
{
    Hotkey, %FreezeKey%, PressedFreezeKey, off
}

if (yFreezeKey != "")
{
    Hotkey, %yFreezeKey%, PressedyFreezeKey, off
}

if (FlyKey != "")
{
    Hotkey, %FlyKey%, PressedFlyKey, off
}

if (FloatKey != "")
{
    Hotkey, %FloatKey%, PressedFloatKey, off
}
return
