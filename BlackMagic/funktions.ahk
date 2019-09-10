;------------------------
;own Functions:
;------------------------

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
}

ReadFiletoArray(file) ;Index 0 = Anzahl Zeilen | Index 1 = Zeile 1 usw...
{
    Array := []
    line = 0
    counter := 0

    fileObjekt := FileOpen(file, "r")
    while (line != "")
    {
        counter++
        line := fileObjekt.ReadLine()

        if (line != "")
        {
            Array[counter] := RTrim(line,"`n")
        }
    }
    Array[0] := Array.Length()
    fileObjekt.Close()

    return Array
}

ExitFunktion()
{
    gosub,ExitScript
}

;------------------------
;other Functions:
;------------------------

getProcessBaseAddress(Handle)
{
	Return DllCall( A_PtrSize = 4
	? "GetWindowLong"
	: "GetWindowLongPtr"
    , "Ptr", Handle
    , "Int", -6
    , "Int64")
}
	
GetAddress(PID, Base, Address, Offset)
{
	pointerBase := base + Address
	y := ReadMemory(pointerBase,PID)
	OffsetSplit := StrSplit(Offset, "+")
	OffsetCount := OffsetSplit.MaxIndex()
	Loop, %OffsetCount%
	{
		if (a_index = OffsetCount)
		{
			Address := (y + OffsetSplit[a_index])
		}
		Else if(a_index = 1) 
		{
			y := ReadMemory(y + OffsetSplit[a_index],PID)
		}
		Else
		{
			y := ReadMemory(y + OffsetSplit[a_index],PID)
		}
	}
	Return Address
}

ReadMemory(MADDRESS, pid)
{
	VarSetCapacity(MVALUE,4,0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory", "UInt", ProcessHandle, "Ptr", MADDRESS, "Ptr", &MVALUE, "Uint",4)
	Loop 4
	result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
	Return, result
}

WriteProcessMemory(pid,address,wert)
{
	size=4 ;changeable
	VarSetCapacity(processhandle,32,0)
	VarSetCapacity(value, 32, 0)
	NumPut(wert,value,0,Uint)
	processhandle:=DllCall("OpenProcess","Uint",0x38,"int",0,"int",pid)
	Bvar:=DllCall("WriteProcessMemory","Uint",processhandle,"Uint",address+0,"Uint",&value,"Uint",size,"Uint",0)
}

HexToFloat(d)
{
	Return (1-2*(d>>31)) * (2**((d>>23 & 255)-127)) * (1+(d & 8388607)/8388608)
}

FloatToHex(f)
{
   form := A_FormatInteger
   SetFormat Integer, HEX
   v := DllCall("MulDiv", Float,f, Int,1, Int,1, UInt)
   SetFormat Integer, %form%
   Return v
}
