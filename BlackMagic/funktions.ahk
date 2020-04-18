;------------------------
;own Functions:
;------------------------

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

ReadMemory(MADDRESS, pid, size = 4)
{
	VarSetCapacity(MVALUE,size,0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory", "UInt", ProcessHandle, "Ptr", MADDRESS, "Ptr", &MVALUE, "Uint",size)
	Loop %size%
	result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)
	Return, result
}

WriteProcessMemory(pid,address,wert, size = 4)
{
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
