SetWorkingDir %A_ScriptDir%
FileCreateDir, Project
FileReadLine, Ver, Bin\SaRS.ahk, 1
StringRight, Version, Ver, 3

RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
 /in "Bin\SaRS.ahk"
 /out "Project\SaRS %Version% x64.exe"
 /icon "Bin\Restore.ico"
 /base "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin"
 /compress 0

RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
 /in "Bin\SaRS.ahk"
 /out "Project\SaRS %Version% x86.exe"
 /icon "Bin\Restore.ico"
 /base "C:\Program Files\AutoHotkey\Compiler\Unicode 32-bit.bin"
 /compress 0

MsgBox, Compile Done!
