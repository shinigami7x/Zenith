@echo off

:: ============
:: Hide Taskbar
:: ============

cd %USERPROFILE%
nircmd.exe win trans class Shell_TrayWnd 256
exit /b