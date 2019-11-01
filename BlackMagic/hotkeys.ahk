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

PressedSuperJumpKey:
if (EnableSuperJump != 1)
{
    Gosub, StartSuperJump
}
Else
{
    Gosub, StopSuperJump
}
return

PressedFallManipulationKey:
if (EnableFallManipulation != 1)
{
    Gosub, StartFallManipulation
}
Else
{
    Gosub, StopFallManipulation
}
return

PressedAntiAFKKey:
if (EnableAntiAFK != 1)
{
    Gosub, StartAntiAFK
}
Else
{
    Gosub, StopAntiAFK
}
return

;------------------------
;Subs for Hotkeys at GUI:
;------------------------

SaveHotkeys:
Gosub, DisableHotkeys

GuiControlGet,SkipKey,,SkipKey
GuiControlGet,SpeedKey,,SpeedKey
GuiControlGet,FreezeKey,,FreezeKey
GuiControlGet,yFreezeKey,,yFreezeKey
GuiControlGet,FlyKey,,FlyKey
GuiControlGet,FloatKey,,FloatKey
GuiControlGet,SuperJumpKey,,SuperJumpKey
GuiControlGet,FallManipulationKey,,FallManipulationKey
GuiControlGet,AntiAFKKey,,AntiAFKKey

Gosub, SaveHotkeysToINI
Gosub, LoadHotkeysFromINI
Gosub, InitHotkeys
return


ResetHotkeys:
MsgBox, 4, %ScriptName%,% "Reset BlackMagic Hotkeys?"
IfMsgBox, Yes
{
    SpeedKey := defaultSpeedKey
    FreezeKey := defaultFreezeKey
    yFreezeKey := defaultyFreezeKey
    FlyKey := defaultFlyKey
    SkipKey := defaultSkipKey
    FloatKey := defaultFloatKey
    SuperJumpKey := defaultSuperJumpKey
    FallManipulationKey := defaultFallManipulationKey
    AntiAFKKey := defaultAntiAFKKey

    Gosub, SaveHotkeysToINI
    Gosub, Restart
}
return


SaveTroveHotkeys:
GuiControlGet,TroveJumpKey,,TroveJumpKey
GuiControlGet,TroveAntiAFKKey,,TroveAntiAFKKey

Gosub, SaveTroveHotkeysToINI
Gosub, LoadTroveHotkeysFromINI
return


ResetTroveHotkeys:
MsgBox, 4, %ScriptName%,% "Reset Trove Hotkeys?"
IfMsgBox, Yes
{
    TroveJumpKey := defaultTroveJumpKey
    TroveAntiAFKKey := defaultTroveAntiAFKKey

    Gosub, SaveTroveHotkeysToINI
    Gosub, Restart
}
return


SaveTroveHotkeysToINI:
IniWrite,%TroveJumpKey%,%iniFile%,TroveHotkeys,TroveJumpKey
IniWrite,%TroveAntiAFKKey%,%iniFile%,TroveHotkeys,TroveAntiAFKKey
return


LoadTroveHotkeysFromINI:
IniRead,TroveJumpKey,%iniFile%,TroveHotkeys,TroveJumpKey
IniRead,TroveAntiAFKKey,%iniFile%,TroveHotkeys,TroveAntiAFKKey
return


SaveHotkeysToINI:
IniWrite,%SkipKey%,%iniFile%,Hotkeys,SkipKey
IniWrite,%SpeedKey%,%iniFile%,Hotkeys,SpeedKey
IniWrite,%FreezeKey%,%iniFile%,Hotkeys,FreezeKey
IniWrite,%yFreezeKey%,%iniFile%,Hotkeys,yFreezeKey
IniWrite,%FlyKey%,%iniFile%,Hotkeys,FlyKey
IniWrite,%FloatKey%,%iniFile%,Hotkeys,FloatKey
IniWrite,%SuperJumpKey%,%iniFile%,Hotkeys,SuperJumpKey
IniWrite,%FallManipulationKey%,%iniFile%,Hotkeys,FallManipulationKey
IniWrite,%AntiAFKKey%,%iniFile%,Hotkeys,AntiAFKKey
return


LoadHotkeysFromINI:
IniRead,SkipKey,%iniFile%,Hotkeys,SkipKey
IniRead,SpeedKey,%iniFile%,Hotkeys,SpeedKey
IniRead,FreezeKey,%iniFile%,Hotkeys,FreezeKey
IniRead,yFreezeKey,%iniFile%,Hotkeys,yFreezeKey
IniRead,FlyKey,%iniFile%,Hotkeys,FlyKey
IniRead,FloatKey,%iniFile%,Hotkeys,FloatKey
IniRead,SuperJumpKey,%iniFile%,Hotkeys,SuperJumpKey
IniRead,FallManipulationKey,%iniFile%,Hotkeys,FallManipulationKey
IniRead,AntiAFKKey,%iniFile%,Hotkeys,AntiAFKKey
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

if (SuperjumpKey != "")
{
    Hotkey, %SuperJumpKey%, PressedSuperJumpKey, on
}

if (FallManipulationKey != "")
{
    Hotkey, %FallManipulationKey%, PressedFallManipulationKey, on
}

if (AntiAFKKey != "")
{
    Hotkey, %AntiAFKKey%, PressedAntiAFKKey, on
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

if (SuperjumpKey != "")
{
    Hotkey, %SuperJumpKey%, PressedAntiAFKKey, off
}
return
