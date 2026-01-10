@echo off
echo Zenith startup script (first boot):
 
:: ---- Prompt the user to start ----
choice /C YN /M "Do you want to run the Zenith setup now? (Y/N)"
if errorlevel 2 (
    echo User chose not to run the setup. Exiting...
    exit /b 0
)
if errorlevel 1 (
    echo User confirmed. Starting Zenith setup...
)
 
:: Optional wait for other post-login tasks
echo Please wait for post login installs to finish before running this script...
timeout /t 10 /nobreak
setlocal EnableExtensions EnableDelayedExpansion
 
:: ===============================
:: Zenith post-login setup script
:: ===============================
 
:: ---- Repo info ----
set REPO_ZIP=https://github.com/shinigami7x/Zenith/archive/refs/heads/main.zip
 
:: ---- Paths ----
set WORKDIR=%TEMP%\zenith_repo
set USERDIR=%USERPROFILE%
set PICDIR=%USERPROFILE%\Pictures
set YASBDIR=%USERPROFILE%\.config\yasb
set LOG=%TEMP%\zenith_postlogin.log
 
echo === Zenith setup started %DATE% %TIME% === >> "%LOG%"
 
:: ---- Clean working directory ----
if exist "%WORKDIR%" rmdir /s /q "%WORKDIR%"
mkdir "%WORKDIR%" >> "%LOG%" 2>&1
 
:: ---- Download repo ----
echo Downloading Zenith repo >> "%LOG%"
curl -L "%REPO_ZIP%" -o "%WORKDIR%\zenith.zip" >> "%LOG%" 2>&1
if errorlevel 1 goto :error
 
:: ---- Extract repo ----
echo Extracting repo >> "%LOG%"
tar -xf "%WORKDIR%\zenith.zip" -C "%WORKDIR%" >> "%LOG%" 2>&1
if errorlevel 1 goto :error
 
:: ---- Locate extracted folder ----
for /d %%D in ("%WORKDIR%\Zenith-*") do set REPODIR=%%D
 
:: ---- Ensure destination directories exist ----
if not exist "%PICDIR%" mkdir "%PICDIR%"
if not exist "%YASBDIR%" mkdir "%YASBDIR%"
 
:: ---- Copy wallpapers ----
if exist "%REPODIR%\wallpapers" (
    echo Copying wallpapers >> "%LOG%"
    xcopy "%REPODIR%\wallpapers" "%PICDIR%\wallpapers" /E /I /Y >> "%LOG%" 2>&1
)
 
:: ---- Copy icons ----
if exist "%REPODIR%\icons" (
    echo Copying icons >> "%LOG%"
    xcopy "%REPODIR%\icons" "%PICDIR%\icons" /E /I /Y >> "%LOG%" 2>&1
)
 
:: ---- Copy komorebi configs to user root ----
echo Copying komorebi configs >> "%LOG%"
copy /Y "%REPODIR%\windows\komorebi-config\applications.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\komorebi-config\komorebi.bar.json" "%USERDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\komorebi-config\komorebi.json" "%USERDIR%\" >> "%LOG%" 2>&1
 
:: ---- Copy YASB configs ----
echo Copying YASB configs >> "%LOG%"
copy /Y "%REPODIR%\windows\yasb-config\config.yaml" "%YASBDIR%\" >> "%LOG%" 2>&1
copy /Y "%REPODIR%\windows\yasb-config\styles.css" "%YASBDIR%\" >> "%LOG%" 2>&1
 
:: ---- Success marker ----
echo OK > "%USERDIR%\ZENITH_SETUP_COMPLETED.txt"
echo === Zenith setup completed %DATE% %TIME% === >> "%LOG%"
 
exit /b 0
 
:error
echo ERROR during Zenith setup >> "%LOG%"
exit /b 1