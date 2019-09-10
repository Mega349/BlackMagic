Gui,Add,Tab,w300 h260, Settings|Hotkeys

Gui,Show,,%ScriptName% v.%ScriptVersion% | %LastUpdateSupport%

Gui,Tab,1
if(PointerAutoUpdate == 1)
{
	Gui, Add, Checkbox, x22 y35 checked vPointerAutoUpdate gSave, Pointer Auto Update
}
else
{
	Gui, Add, Checkbox, x22 y35 vPointerAutoUpdate gSave, Pointer Auto Update
}
if(ShowTooltip == 1)
{
	Gui, Add, Checkbox, xp yp+17 checked vShowTooltip gSave, Show Tooltip
}
else
{
	Gui, Add, Checkbox, xp yp+17 vShowTooltip gSave, Show Tooltip
}


Gui, Add, Text, x22 yp+17,--------------------------------------------------------------------------------------------

Gui, Add, Text, x22 yp+17 cred, You have to update after an Trove update.
Gui, Add, Text, xp yp+20 cgreen, You can add valid values to "SpeedValue" if you know how.
Gui, Add, Text, xp yp+25, Speed Value:
Gui, Add, DropDownList, xp+80 yp-2 w50 AltSubmit Choose%Speed% vSpeed gSave, %SpeedValueString%
Gui, Add, Button,xp+55 yp-1 gUpdateSpeedFile, Update list
Gui, Add, Button,xp+66 yp gRestoreSpeedFile, Restore list

Gui, Add, Text, x22 yp+22,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+17, Fly Acceleration:
Gui, Add, Edit, xp+85 yp-3 w30 vFlyAccel gSave, %FlyAccel%
Gui, Add, Text, xp+35 yp+3 cgreen, For the best result, use wings.

Gui, Add, Text, x22 yp+19,--------------------------------------------------------------------------------------------

Gui, Add, Text, xp yp+17, Skip Distance:
Gui, Add, Edit, xp+85 yp-2 w30 vSkipDistance gSave, %SkipDistance%
Gui, Add, Text, xp+35 yp+2 cgreen, Teleport over a few blocks

Gui, Add, Text, x22 yp+19,--------------------------------------------------------------------------------------------

Gui, Add, Text, x22 yp+17 cgreen, Freeze High is useful for infinite flying

Gui,Tab,2
Gui, Add, Text, x22 y40, Speed Hack:
Gui, Add, Hotkey,xp+80 yp-2 w80 h20 vSpeedKey, %SpeedKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + K

Gui, Add, Text, x22 yp+28, Freeze Position:
Gui, Add, Hotkey,xp+80 yp-2 w80 h20 vFreezeKey, %FreezeKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + P

Gui, Add, Text, x22 yp+28, Freeze High:
Gui, Add, Hotkey,xp+80 yp-2 w80 h20 vyFreezeKey, %yFreezeKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + L

Gui, Add, Text, x22 yp+28, Fly Hack:
Gui, Add, Hotkey,xp+80 yp-2 w80 h20 vFlyKey, %FlyKey%
Gui, Add, Text, xp+85 yp+2, default = CTRL + W

Gui, Add, Text, x22 yp+28, Skip (Teleport):
Gui, Add, Hotkey,xp+80 yp-2 w80 h20 vSkipKey, %SkipKey%
Gui, Add, Text, xp+85 yp+2, default = MButton

Gui, Add, Button, x102 yp+25 gSaveHotkeys, Save

Gui, Add, Text,x22 yp+35 cgreen, MButton = Pressed Mouse Wheel
Gui, Add, Text,x22 yp+15 cred, Controller or Mouse Buttons cant be set or displayed here!
Gui, Add, Text,x22 yp+15 cred, set/change "special Buttons" at "%Inifile%"