@echo off

:: ====================
:: Zenith setup script
:: ====================
 
setlocal EnableExtensions EnableDelayedExpansion
 
set REPO_ZIP=https://github.com/shinigami7x/Zenith/archive/refs/heads/main.zip
 
set WORKDIR=%TEMP%\zenith_repo
set USERDIR=%USERPROFILE%
set PICDIR=%USERPROFILE%\Pictures
set YASBDIR=%USERPROFILE%\.config\yasb
set DTDIR=%USERPROFILE%\Desktop\desktop
set LOG=%TEMP%\zenith_postlogin.log
 
echo === Zenith setup started %DATE% %TIME% === >> "%LOG%"
 
if exist "%WORKDIR%" rmdir /s /q "%WORKDIR%"
mkdir "%WORKDIR%" >> "%LOG%" 2>&1
 
echo Downloading Zenith repo >> "%LOG%"
curl -L "%REPO_ZIP%" -o "%WORKDIR%\zenith.zip" >> "%LOG%" 2>&1
if errorlevel 1 goto :error
 
echo Extracting repo >> "%LOG%"
tar -xf "%WORKDIR%\zenith.zip" -C "%WORKDIR%" >> "%LOG%" 2>&1
if errorlevel 1 goto :error
 
for /d %%D in ("%WORKDIR%\Zenith-*") do set REPODIR=%%D
 
if not exist "%PICDIR%" mkdir "%PICDIR%"
if not exist "%YASBDIR%" mkdir "%YASBDIR%"
if not exist "%DTDIR%" mkdir "%DTDIR%"
 
if exist "%REPODIR%\images\wallpapers" (
    echo Copying wallpapers >> "%LOG%"
    xcopy "%REPODIR%\images\wallpapers" "%PICDIR%\wallpapers" /E /I /Y >> "%LOG%" 2>&1
)
 
if exist "%REPODIR%\images\icons" (
    echo Copying icons >> "%LOG%"
    xcopy "%REPODIR%\images\icons" "%PICDIR%\icons" /E /I /Y >> "%LOG%" 2>&1
)
 
echo Copying komorebi configs >> "%LOG%"
copy /Y "%REPODIR%\dotfiles\komorebi\applications.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\dotfiles\komorebi\komorebi.bar.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\dotfiles\komorebi\komorebi.json" "%USERDIR%\" >> "%LOG%" 2>&1
 
echo Copying YASB configs >> "%LOG%"
copy /Y "%REPODIR%\dotfiles\yasb\config.yaml" "%YASBDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\dotfiles\yasb\styles.css" "%YASBDIR%\" >> "%LOG%" 2>&1

echo Copying desktop folder >> "%LOG%"
copy /Y "%REPODIR%\desktop" "%DTDIR%\" >> "%LOG%" 2>&1
 
echo OK > "%USERDIR%\ZENITH_SETUP_COMPLETED.txt"
echo === Zenith setup completed %DATE% %TIME% === >> "%LOG%"

:: =================
:: YASB setup script
:: =================

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
 
exit /b 0
 
:error
echo ERROR during Zenith setup >> "%LOG%"

exit /b 1