@echo off

:: ========================
:: YASB setup script
:: ========================

setlocal EnableExtensions EnableDelayedExpansion

echo USERPROFILE=%USERPROFILE%
echo USERNAME=%USERNAME%
echo.

set "CONFIG_PATH=%USERPROFILE%\.config\yasb\config.yaml"
echo Looking for:
echo %CONFIG_PATH%
echo.

if not exist "%CONFIG_PATH%" (
    echo YASB config not found.
    pause
    exit /b
)

echo Patching YASB config...

set "TEMP_FILE=%TEMP%\yasb_config.tmp"
del "%TEMP_FILE%" 2>nul

for /f "usebackq delims=" %%A in ("%CONFIG_PATH%") do (
    set "LINE=%%A"
    set "LINE=!LINE:FakeProfile=%USERNAME%!"
    echo(!LINE!>>"%TEMP_FILE%"
)

move /y "%TEMP_FILE%" "%CONFIG_PATH%" >nul

echo YASB config patched successfully.
echo Enabling autostart...

yasbc enable-autostart

echo Starting YASB...
yasbc start

endlocal