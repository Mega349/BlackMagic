GUI:
Gui,Add,Tab,w300 h340, Settings|BlackMagic Hotkeys|Trove Hotkeys

Gui,Show,,%ScriptName% v%ScriptVersion% | %LastUpdateSupport%

Gui,Tab,1
if(PointerAutoUpdate == 1)
{
	Gui, Add, Checkbox, x22 y40 checked vPointerAutoUpdate gSave, Pointer Auto Update
}
else
{
	Gui, Add, Checkbox, x22 y40 vPointerAutoUpdate gSave, Pointer Auto Update
}

if(EnableUpdateCheck == 1)
{
	Gui, Add, Checkbox, xp yp+20 checked vEnableUpdateCheck gSave, Check for Update at Start
}
else
{
	Gui, Add, Checkbox, xp yp+20 vEnableUpdateCheck gSave, Check for Update at Start
}

if(ShowTooltip == 1)
{
	Gui, Add, Checkbox, xp yp+20 checked vShowTooltip gSave, Show Tooltip
}
else
{
	Gui, Add, Checkbox, xp yp+20 vShowTooltip gSave, Show Tooltip
}


Gui, Add, Text, x22 yp+13,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Speed Value:
Gui, Add, Edit, xp+94 yp-3 vDecSpeedValue gSave, %DecSpeedValue%
Gui, Add, Text, xp+35 yp+3 cgreen, Speed for Speedhack.

Gui, Add, Text, x22 yp+20,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Fly Acceleration:
Gui, Add, Edit, xp+94 yp-3 vFlyAccel gSave, %FlyAccel%
Gui, Add, Text, xp+35 yp+3 cgreen, For the best result, use wings.

Gui, Add, Text, x22 yp+20,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Skip Distance:
Gui, Add, Edit, xp+94 yp-2 vSkipDistance gSave, %SkipDistance%
Gui, Add, Text, xp+35 yp+2 cgreen, Teleport over a few blocks.

Gui, Add, Text, x22 yp+20,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Super Jump Accel.:
Gui, Add, Edit, xp+94 yp-2 vSuperJumpAccel gSave, %SuperJumpAccel%
Gui, Add, Text, xp+35 yp+2 cgreen, up speed while Jumping.

Gui, Add, Text, x22 yp+20,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Fall man. Accel.:
Gui, Add, Edit, xp+94 yp-2 vFallManipulationAccel gSave, %FallManipulationAccel%
Gui, Add, Text, xp+35 yp+2 cgreen, down speed while Falling.

Gui, Add, Text, x22 yp+20,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+20, Cam. Distance limit:
Gui, Add, Edit, xp+94 yp-2 vminCamDistance gSave, %minCamDistance%
Gui, Add, Text, xp+35 yp+2, to
Gui, Add, Edit, xp+15 yp-2 vmaxCamDistance gSave, %maxCamDistance%
Gui, Add, Text, xp+35 yp+2 cgreen, self explanatory.


Gui,Tab,2
Gui, Add, Text, x22 y35, Skip (Teleport):
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vSkipKey, %SkipKey%
Gui, Add, Text, xp+85 yp+2, default = MButton

Gui, Add, Text, x22 yp+25, Speed Hack:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vSpeedKey, %SpeedKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + K

Gui, Add, Text, x22 yp+25, Freeze Position:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vFreezeKey, %FreezeKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + P

Gui, Add, Text, x22 yp+25, Freeze High:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vyFreezeKey, %yFreezeKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + L

Gui, Add, Text, x22 yp+25, Free Fly: ( hold )
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vFlyKey, %FlyKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + W

Gui, Add, Text, x22 yp+25, Float:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vFloatKey, %FloatKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + F

Gui, Add, Text, x22 yp+25, Super Jump:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vSuperJumpKey, %SuperJumpKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + M

Gui, Add, Text, x22 yp+25, Fall manipulation:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vFallManipulationKey, %FallManipulationKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + G

Gui, Add, Text, x22 yp+25, Anti AFK:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vAntiAFKKey, %AntiAFKKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + H

Gui, Add, Button, x112 yp+25 gSaveHotkeys, Save
Gui, Add, Button, x+3 yp gResetHotkeys, Reset

Gui, Add, Text,x22 yp+35 cgreen, MButton = Pressed Mouse Wheel
Gui, Add, Text,x22 yp+15 cred, Controller or Mouse Buttons cant be set or displayed here!
Gui, Add, Text,x22 yp+15 cred, set/change "special Buttons" at "%Inifile%"


Gui,Tab,3
Gui, Add, Text, x22 y35, Default Jump Key:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vTroveJumpKey, %TroveJumpKey%
Gui, Add, Text, xp+85 yp+2, default = Space

Gui, Add, Text, x22 yp+25, Anti AFK Key:
Gui, Add, Hotkey,xp+90 yp-2 w80 h20 vTroveAntiAFKKey, %TroveAntiAFKKey%
Gui, Add, Text, xp+85 yp+2, default = M

Gui, Add, Button, x112 yp+25 gSaveTroveHotkeys, Save
Gui, Add, Button, x+3 yp gResetTroveHotkeys, Reset

Gui, Add, Text,x22 yp+35 cblue, Default Jump Key is required by Super Jump
Gui, Add, Text,x22 yp+15 cblue, "Space" cant be set but displayed here!
Gui, Add, Text,x22 yp+15 cred, Controller or Mouse Buttons cant be set or displayed here!
Gui, Add, Text,x22 yp+15 cred, set/change "special Buttons" at "%Inifile%"
return

refreshInputBox:
GuiControl, move, FlyAccel, w30
GuiControl, move, SkipDistance, w30
GuiControl, move, SuperJumpAccel, w30
GuiControl, move, FallManipulationAccel, w30
GuiControl, move, minCamDistance, w30
GuiControl, move, maxCamDistance, w30
GuiControl, move, DecSpeedValue, w30
return
