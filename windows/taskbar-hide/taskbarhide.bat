@ECHO OFF
cd C:\Users\%USERPROFILE%\
nircmd.exe win trans class Shell_TrayWnd 256
exit /b