Ver := 1.2
FileInstall, Clean.png, %TEMP%\Clean.png, 1

Gui, Add, Text,, Windows System Cleaner
Gui, Add, CheckBox, vTemp, Clean Temp Folder's
Gui, Add, CheckBox, vRecycle, Clean Recycle Bin
Gui, Add, CheckBox, vDownload , Clean Download Folder
Gui, Add, Button, x12 y90 w60 h20 , Start
Gui, Add, Progress, x82 y90 w170 h20 vMyProgress, 0
Gui, Add, Picture, x180 y18 w70 h70 , %TEMP%\Clean.png
Gui, Show, , Windows Mini Tool : Mini Cleaner
Return

ButtonStart:
Gui, Submit
Gui, Show, , Windows Mini Tool

if Temp = 1 
	RunWait, CMD /с rd /S /Q C:\Windows\Temp\ & rd /S /Q C:\Temp\ & rd /S /Q %TEMP%, , Hide
GuiControl, , MyProgress, 40

if Recycle = 1 
	RunWait, CMD /с rd /s /q %systemdrive%\$Recycle.bin, , Hide
GuiControl, , MyProgress, 70

if Download = 1
	RunWait, CMD /c Del "%userprofile%\Downloads\*.*" /F /S /Q /A, , Hide
GuiControl, , MyProgress, 100
MsgBox, Done!

END:
GuiClose:
GuiEscape:
ExitApp