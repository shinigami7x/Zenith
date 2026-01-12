@echo off

rem Change this path to wherever nircmd.exe is installed
cd C:\Users\%USERPROFILE%\
nircmd.exe win trans class Shell_TrayWnd 256
exit /b