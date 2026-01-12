@echo off

:: =======================
:: Winget bootstrap script
:: =======================

set "DESKTOP=%USERPROFILE%\Desktop"
set "PS_SCRIPT=%DESKTOP%\zenith-bootstrap.ps1"

if not exist "%PS_SCRIPT%" (
    echo ERROR: zenith-bootstrap.ps1 not found on Desktop
    echo Expected path:
    echo %PS_SCRIPT%
    pause
    exit /b 1
)

echo Launching PowerShell bootstrap from Desktop...
echo.

powershell.exe ^
  -NoProfile ^
  -ExecutionPolicy Bypass ^
  -NoExit ^
  -File "%PS_SCRIPT%"

echo.
echo PowerShell exited.
pause