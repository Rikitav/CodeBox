If %1 == SSN Sfc /scannow
If %1 == DSH Dism /Online /Cleanup-Image /ScanHealth
If %1 == DRH Dism /Online /Cleanup-Image /RestoreHealth
REG add HKCU\SOFTWARE\SaRS /v %1 /t REG_SZ /d %ERRORLEVEL%