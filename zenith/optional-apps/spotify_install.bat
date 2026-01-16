@echo off
:: =================
:: Spotify Installer
:: =================

setlocal enabledelayedexpansion

echo Starting Spotify installation...

rem Path to YASBC
set "YASB_CMD=C:\Program Files\YASB\yasbc.exe"

set "INSTALL_DIR=%TEMP%\spotify"
mkdir "%INSTALL_DIR%" 2>nul

if not exist "%YASB_CMD%" (
    echo YASB CLI not found at %YASB_CMD%
    goto :error
)

winget download --id Spotify.Spotify --source winget --download-directory "%INSTALL_DIR%" --accept-source-agreements --accept-package-agreements
if %ERRORLEVEL% NEQ 0 (
    echo Failed to download Spotify installer.
    pause
    exit /b 1
)

for /R "%INSTALL_DIR%" %%I in (*.exe) do set "INSTALLER=%%I"

if not defined INSTALLER (
    echo No installer found in %INSTALL_DIR%.
    pause
    exit /b 1
)

echo Running installer...
"%INSTALLER%" /S
if %ERRORLEVEL% NEQ 0 (
    echo Installer failed with code %ERRORLEVEL%.
    pause
    exit /b 1
)

echo Spotify installed successfully!

set "CONFIG_FILE=%USERPROFILE%\.config\yasb\config.yaml"
set "TEMP_FILE=%TEMP%\yasb_app_patch.tmp"

if not exist "%CONFIG_FILE%" (
    echo YASB config not found: %CONFIG_FILE%
    exit /b 1
)

echo Patching YASB config to add Spotify...

del "%TEMP_FILE%" 2>nul
set "INSERTED=0"

for /f "usebackq delims=" %%A in ("%CONFIG_FILE%") do (
    set "LINE=%%A"

    echo !LINE! | findstr /R /C:"^[ ]*label_shadow:" >nul
    if not errorlevel 1 if "!INSERTED!"=="0" (
        echo(        - {icon: %USERPROFILE%\Pictures\icons\spotify_256x256.png, launch: '%USERPROFILE%\AppData\Roaming\Spotify\Spotify.exe', name: "Spotify"}>>"%TEMP_FILE%"
        set "INSERTED=1"
    )

    echo(!LINE!>>"%TEMP_FILE%"
)

move /y "%TEMP_FILE%" "%CONFIG_FILE%" >nul || (
    echo Failed to write patched YASB config.
    exit /b 1
)

"%YASB_CMD%" reload --silent

echo YASB config patched for spotify.

endlocal
