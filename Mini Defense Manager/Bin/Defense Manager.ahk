Ver = 2.1

FileCreateDir, %SystemDrive%\ProgramData\WSDM
FileInstall, Protection.zip, %Temp%\Protection.zip, 1
FileInstall, 7za.exe, %Temp%\7za.exe, 1
IfNotExist, %SystemDrive%\ProgramData\WSDM\Defender\Disable.exe
	RunWait, %Temp%\7za.exe x -o%SystemDrive%\ProgramData\WSDM -y %Temp%\Protection.zip, , Hide

If A_IsAdmin = 0
{
MsgBox, Пожалуйста запустите программу от имени администратора!
Goto END
}

Gui, Add, Button, x22 y189 w120 h20 , Eanble WD
Gui, Add, Button, x22 y209 w120 h20 , Disable WD
Gui, Add, Button, x22 y119 w120 h20 , Enable SS
Gui, Add, Button, x22 y139 w120 h20 , Disable SS
Gui, Add, Button, x172 y189 w120 h20 , Enable FW
Gui, Add, Button, x172 y209 w120 h20 , Disable FW
Gui, Add, Button, x172 y119 w120 h20 , Enable UAC
Gui, Add, Button, x172 y139 w120 h20 , Disable UAC
Gui, Add, Text, x42 y249 w230 h20 , Windows System Defense Manager by Timchik
Gui, Add, GroupBox, x12 y169 w140 h70 , Windows Defender
Gui, Add, GroupBox, x162 y169 w140 h70 , FireWall
Gui, Add, GroupBox, x12 y99 w140 h70 , Smart Screen
Gui, Add, GroupBox, x162 y99 w140 h70 , UAC
Gui, Add, Picture, x12 y9 w290 h80 , %SystemDrive%\ProgramData\WSDM\WSDM.png
Gui, Show, x127 y87 h272 w319, Windows Mini Tools : WSDM
Return

ButtonEnableWD:
RunWait, %SystemDrive%\ProgramData\WSDM\Defender\Enable.exe
Return

ButtonDisableWD:
RunWait, %SystemDrive%\ProgramData\WSDM\Defender\Disable.exe
Return

ButtonEnableSS:
RunWait, %SystemDrive%\ProgramData\WSDM\SmartScreen\Enable.exe
Return

ButtonDisableSS:
RunWait, %SystemDrive%\ProgramData\WSDM\SmartScreen\Disable.exe
Return

ButtonEnableFW:
RunWait, %SystemDrive%\ProgramData\WSDM\FireWall\Enable.exe
Return

ButtonDisableFW:
RunWait, %SystemDrive%\ProgramData\WSDM\FireWall\Disable.exe
Return

ButtonEnableUAC:
RunWait, %SystemDrive%\ProgramData\WSDM\UAC\Enable.exe
Return

ButtonDisableUAC:
RunWait, %SystemDrive%\ProgramData\WSDM\UAC\Disable.exe
Return

END:
GuiClose:
ExitApp