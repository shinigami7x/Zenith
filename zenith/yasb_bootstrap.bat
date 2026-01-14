@echo off

:: =================
:: YASB Setup Script
:: =================

setlocal EnableDelayedExpansion

rem Path to YASBC
set "YASB_CMD=C:\Program Files\YASB\yasbc.exe"

if not exist "%YASB_CMD%" (
    echo YASB CLI not found at %YASB_CMD%
    goto :error
)

echo Enabling YASB autostart...
"%YASB_CMD%" enable-autostart || goto :error

rem Declare relevant paths
set "CONFIG_PATH=%USERPROFILE%\.config\yasb\config.yaml"
set "TEMP_FILE=%TEMP%\yasb_config.tmp"

if not exist "%CONFIG_PATH%" goto :error

echo Patching YASB config...
del "%TEMP_FILE%" 2>nul
for /f "usebackq delims=" %%A in ("%CONFIG_PATH%") do (
    set "LINE=%%A"
    set "LINE=!LINE:FakeProfile=%USERNAME%!"
    echo(!LINE!>>"%TEMP_FILE%"
)
echo YASB config patched.

echo Writing patched config...
move /y "%TEMP_FILE%" "%CONFIG_PATH%" >nul
if errorlevel 1 goto :error
echo Patched config written.

echo Reloading YASB...
"%YASB_CMD%" reload --silent
"%YASB_CMD%" start --silent || goto :error

echo YASB bootstrap completed.
exit /b 0

:error
echo YASB bootstrap failed.
pause
exit /b 1
