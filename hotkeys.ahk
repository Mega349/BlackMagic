;------------------------
;Pressed Hotkeys:
;------------------------

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

;------------------------
;Subs for Hotkeys at GUI:
;------------------------

SaveHotkeys:
Gosub, DisableHotkeys

GuiControlGet,SpeedKey,,SpeedKey
IniWrite,%SpeedKey%,%iniFile%,Hotkeys,SpeedKey

GuiControlGet,FreezeKey,,FreezeKey
IniWrite,%FreezeKey%,%iniFile%,Hotkeys,FreezeKey

GuiControlGet,yFreezeKey,,yFreezeKey
IniWrite,%yFreezeKey%,%iniFile%,Hotkeys,yFreezeKey

GuiControlGet,FlyKey,,FlyKey
IniWrite,%FlyKey%,%iniFile%,Hotkeys,FlyKey

GuiControlGet,SkipKey,,SkipKey
IniWrite,%SkipKey%,%iniFile%,Hotkeys,SkipKey

Gosub, InitHotkeys
return

InitHotkeys:
If !A_IsCompiled
{
    Hotkey, ^R, Restart
    Hotkey, ^T, ExitScript
}
if (SpeedKey != "")
{
    Hotkey, %SpeedKey%, PressedSpeedKey
}

if (FreezeKey != "")
{
    Hotkey, %FreezeKey%, PressedFreezeKey
}

if (yFreezeKey != "")
{
    Hotkey, %yFreezeKey%, PressedyFreezeKey
}

if (FlyKey != "")
{
    Hotkey, %FlyKey%, PressedFlyKey
}

if (SkipKey != "")
{
    Hotkey, %SkipKey%, PressedSkipKey
}
return

DisableHotkeys:
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

if (SkipKey != "")
{
    Hotkey, %SkipKey%, PressedSkipKey, off
}
return