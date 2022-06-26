Ver = 1.4
HP = 1
SNW = 1
Block = 0

IfExist %SystemDrive%\Windows\SaRS.txt
{
	FileRead, Date, %SystemDrive%\Windows\SaRS.txt
} Else {
	Date = Never
}

RegDelete, HKEY_CURRENT_USER\Software\SaRS, SSN
RegDelete, HKEY_CURRENT_USER\Software\SaRS, DSH
RegDelete, HKEY_CURRENT_USER\Software\SaRS, DRH

If A_IsAdmin = 0
{
	MsgBox, Пожалуйста, перезапустите программу от имени Администратора
	Goto End
}

SSN = Sfc /ScanNow
DSH = Dism /ScanHealth
DRH = Dism /RestoreHealth
CBS = Scanning CBS.log

DoSSN = 
DoDSH = 
DoDRH = 

Done = Done
Error = !ERROR!
Skip = Skipped

Anim1 = \
Anim2 = -
Anim3 = /
Anim4 = |

FileCreateDir, %SystemDrive%\ProgramData\SaRS
FileInstall, SaRS.png, %Temp%\SaRS.png, 1
FileInstall, Scan.png, %Temp%\Scan.png, 1

IfExist %AppData%\SaRS.ini
{
	IniRead, HP, %AppData%\SaRS.ini, SaRS, HidePrompt
	IniRead, IniVersion, %AppData%\SaRS.ini, SaRS, Ver
	if IniVersion < %Ver%
		FileDelete, %AppData%\SaRS.ini
}

IfNotExist %AppData%\SaRS.ini
{
	FileAppend,
	(
[SaRS]
HidePrompt=%HP%
Ver=%Ver%
	), %AppData%\SaRS.ini

}

If HP = 1
{
	HPM = Hide
} else {
	HPM = Min
}

GUI:
Gui, Add, Button, x12 y199 w320 h20 , Scan Now
Gui, Add, GroupBox, x12 y99 w320 h90 , Task List :
Gui, Add, CheckBox, x22 y119 w300 h20 vSfc, Sfc /Scannow
Gui, Add, CheckBox, x22 y139 w300 h20 vScan, Dism /ScanHealth
Gui, Add, CheckBox, x22 y159 w300 h20 vRestore, Dism /RestoreHealth
Gui, Add, Picture, x12 y9 w320 h60 , %Temp%\SaRS.png
Gui, Add, Text, x12 y79 w320 h20 , Last Scanning : %Date%
Gui, Show, x127 y87 h233 w346, Windows Mini Tools : SaRS
Return

ButtonScanNow:
Block = 1
Gui, Submit
Gui, Destroy
Gui, Add, Progress, x12 y129 w360 h20 vMyProgress, 0
Gui, Add, Picture, x282 y9 w90 h90 , %Temp%\Scan.png
Gui, Add, ListView, x12 y9 w260 h110 , Task|Status
Gui, Show, x127 y87 h161 w389, SaRS : Working...

LV_Add("", SSN, None)
LV_Add("", DSH, None)
LV_Add("", DRH, None)

LV_ModifyCol()
LV_ModifyCol(2, 100)

SFC:
if Sfc = 1 
{
	do = 1
	IfExist %windir%\Logs\CBS\CBS.log
		FileDelete, %windir%\Logs\CBS\CBS.log
	
	Run, cmd.exe /c sfc /scannow & REG add HKCU\SOFTWARE\SaRS /v SSN /t REG_SZ /d `%ERRORLEVEL`%, , %HPM%
	
	Loop
	{
		LV_Modify(1, , SSN, Anim1)
		Sleep, 200
		LV_Modify(1, , SSN, Anim2)
		Sleep, 200
		LV_Modify(1, , SSN, Anim3)
		Sleep, 200
		LV_Modify(1, , SSN, Anim4)
		Sleep, 200

		RegRead, RunSSN, HKEY_CURRENT_USER\Software\SaRS, SSN
		If RunSSN = 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, SSN
			GuiControl,, MyProgress, 35
			LV_Modify(1, , SSN, Done)
			Goto ScanHealth
		}
		
		If RunSSN > 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, SSN
			GuiControl,, MyProgress, 35
			LV_Modify(1, , SSN, Error)
			Goto ScanHealth
		}
	}
} else {
	LV_Modify(1, , SSN, Skip)
}

ScanHealth:
if Scan = 1 
{
	do = 1
	Run, cmd.exe /c Dism /Online /Cleanup-Image /ScanHealth & REG add HKCU\SOFTWARE\SaRS /v DSH /t REG_SZ /d `%ERRORLEVEL`%, , %HPM%
	
	Loop
	{
		LV_Modify(2, , DSH, Anim1) 
		Sleep, 200
		LV_Modify(2, , DSH, Anim2)
		Sleep, 200
		LV_Modify(2, , DSH, Anim3)
		Sleep, 200
		LV_Modify(2, , DSH, Anim4)
		Sleep, 200

		RegRead, RunDSH, HKEY_CURRENT_USER\Software\SaRS, DSH
		If RunDSH = 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, DSH
			GuiControl,, MyProgress, 60
			LV_Modify(2, , DSH, Done)
			Goto RestoreHealth
		}
		
		If RunDSH > 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, DSH
			GuiControl,, MyProgress, 60
			LV_Modify(2, , DSH, Error)
			Goto RestoreHealth
		}
	}
} Else {
	LV_Modify(2, , DSH, Skip)
}

RestoreHealth:
if Restore = 1 
{
	do = 1
	Run, cmd.exe /c Dism /Online /Cleanup-Image /RestoreHealth & REG add HKCU\SOFTWARE\SaRS /v DRH /t REG_SZ /d `%ERRORLEVEL`%, , %HPM%
	
	Loop
	{
		LV_Modify(3, , DRH, Anim1)
		Sleep, 200
		LV_Modify(3, , DRH, Anim2)
		Sleep, 200
		LV_Modify(3, , DRH, Anim3)
		Sleep, 200
		LV_Modify(3, , DRH, Anim4)
		Sleep, 200

		RegRead, RunDRH, HKEY_CURRENT_USER\Software\SaRS, DRH
		If RunDRH = 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, DRH
			GuiControl,, MyProgress, 100
			LV_Modify(3, , DRH, Done)
			Goto Done
		}
		
		If RunDRH > 0
		{
			RegDelete, HKEY_CURRENT_USER\Software\SaRS, DRH
			GuiControl,, MyProgress, 100
			LV_Modify(3, , DRH, Error)
			Goto Done
		}
	}
} else {
	LV_Modify(3, , DRH, Skip)
}

Done:
Block = 0

if Sfc = 1 
{
	LV_Add("", CBS, None)
	Needle = Cannot
	Loop
	{
		LV_Modify(4, , CBS, Anim1)
		Sleep, 200
		LV_Modify(4, , CBS, Anim2)
		Sleep, 200
		LV_Modify(4, , CBS, Anim3)
		Sleep, 200
		LV_Modify(4, , CBS, Anim4)
		Sleep, 200
		
		FileReadLine, line, %windir%\Logs\CBS\CBS.log, %A_Index%
		if ErrorLevel
			break
		
		If InStr(Line, Needle)
		{
			CbsError = 1
			FileAppend,
			(
%A_Index%,
			), %Temp%\CbsError.txt
		}
	}
	
	If CbsError = 1
	{
		MsgBox, 4, , При выполнении Sfc /Scannow некоторые файлы не удалось востанновить`nХотите открыть CBS.log?
		IfMsgBox, Yes
		{
			FileRead, CbsErrorList, %Temp%\CbsError.txt
			run, %windir%\Logs\CBS\CBS.log, , UseErrorLevel
			If ERRORLEVEL = 1
			{
				MsgBox, Лог Файл Был потерян!`nВозможно он был удалён
				Goto END
			} Else {
				MsgBox, Ошибки были найдены строках %CbsErrorList%
			}
		}
	}
}

If do = 1
{
FileDelete, %SystemDrive%\Windows\SaRS.txt
FormatTime, Date, , dd
FileAppend, %Date%., %SystemDrive%\Windows\SaRS.txt
FormatTime, Date, , MM
FileAppend, %Date%., %SystemDrive%\Windows\SaRS.txt
FormatTime, Date, , yyyy
FileAppend, %Date%, %SystemDrive%\Windows\SaRS.txt
}

END:
GuiClose:
GuiEscape:
If Block = 0
	ExitApp