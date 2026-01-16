@echo off

:: ====================
:: Taskbar Setup Script
:: ====================

set "SOURCE=%USERPROFILE%\Documents\Zenith\taskbar\taskbarhide.bat"
set "STARTUP=%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
set "DEST=%STARTUP%\taskbarhide.bat"

if not exist "%SOURCE%" (
    echo ERROR: taskbarhide.bat not found.
    pause
    exit /b 1
)

copy /Y "%SOURCE%" "%DEST%" >nul

call "%DEST%"

echo Script moved to startup.