SetWorkingDir %A_ScriptDir%
FileCreateDir, Project
FileReadLine, Ver, Bin\SaRS.ahk, 1
StringRight, Version, Ver, 3

RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
 /in "Bin\Mini Cleaner.ahk"
 /out "Project\Mini Cleaner %Version% x64.exe"
 /icon "Bin\Cleaner.ico"
 /base "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin"
 /compress 0

RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
 /in "Bin\Mini Cleaner.ahk"
 /out "Project\Mini Cleaner %Version% x86.exe"
 /icon "Bin\Cleaner.ico"
 /base "C:\Program Files\AutoHotkey\Compiler\Unicode 32-bit.bin"
 /compress 0

MsgBox, Compile Done!
