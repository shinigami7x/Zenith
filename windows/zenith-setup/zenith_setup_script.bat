@echo off

:: ====================
:: Zenith setup script
:: ====================
 
choice /C YN /M "Would you like to clone external Zenith files? (Y/N)"
if errorlevel 2 (
    echo User chose not to run the setup. Exiting...
    exit /b 0
)
if errorlevel 1 (
    echo User confirmed. Starting Zenith setup...
)
 
setlocal EnableExtensions EnableDelayedExpansion
 
set REPO_ZIP=https://github.com/shinigami7x/Zenith/archive/refs/heads/main.zip
 
set WORKDIR=%TEMP%\zenith_repo
set USERDIR=%USERPROFILE%
set PICDIR=%USERPROFILE%\Pictures
set YASBDIR=%USERPROFILE%\.config\yasb
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
 
if exist "%REPODIR%\wallpapers" (
    echo Copying wallpapers >> "%LOG%"
    xcopy "%REPODIR%\wallpapers" "%PICDIR%\wallpapers" /E /I /Y >> "%LOG%" 2>&1
)
 
if exist "%REPODIR%\icons" (
    echo Copying icons >> "%LOG%"
    xcopy "%REPODIR%\icons" "%PICDIR%\icons" /E /I /Y >> "%LOG%" 2>&1
)
 
echo Copying komorebi configs >> "%LOG%"
copy /Y "%REPODIR%\windows\komorebi-config\applications.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\komorebi-config\komorebi.bar.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\komorebi-config\komorebi.json" "%USERDIR%\" >> "%LOG%" 2>&1
 
echo Copying YASB configs >> "%LOG%"
copy /Y "%REPODIR%\windows\yasb-config\config.yaml" "%YASBDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\yasb-config\styles.css" "%YASBDIR%\" >> "%LOG%" 2>&1
 
echo OK > "%USERDIR%\ZENITH_SETUP_COMPLETED.txt"
echo === Zenith setup completed %DATE% %TIME% === >> "%LOG%"
 
exit /b 0
 
:error
echo ERROR during Zenith setup >> "%LOG%"
exit /b 1