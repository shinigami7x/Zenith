@echo off

:: =================================
:: Zenith installation driver script
:: =================================

rem Declare relevant paths
set "DOCUMENTS=%USERPROFILE%\Documents"
set "WEB_SCRIPT=%DOCUMENTS%\Zenith\web_downloads.bat"
set "WINGET_SCRIPT=%DOCUMENTS%\Zenith\winget_bootstrap.ps1"
set "APP_SCRIPT=%DOCUMENTS%\Zenith\app_installs.ps1"
set "YASB_SCRIPT=%DOCUMENTS%\Zenith\yasb_bootstrap.bat"

rem Verify that the files exists
if not exist "%WEB_SCRIPT%" goto :error
if not exist "%WINGET_SCRIPT%" goto :error
if not exist "%APP_SCRIPT%" goto :error
if not exist "%YASB_SCRIPT%" goto :error

echo Launching web download script...
call "%WEB_SCRIPT%"
if errorlevel 1 goto :error
echo Web download script finished running.

echo Please double-click and install the JetBrains Mono Nerd font found on the desktop before continuing...
pause

echo Launching winget bootsrap script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%WINGET_SCRIPT%"
if errorlevel 1 goto :error
echo Winget bootstrap script finished running.

echo Launching app install script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%APP_SCRIPT%"
if errorlevel 1 goto :error
echo App install script finished running.

echo Launching YASB bootstrap script...
call "%YASB_SCRIPT%"
if errorlevel 1 goto :error
echo YASB bootstrap script finished running.

echo Zenith setup completed.
pause
exit /b 0

rem Error statement must remain at the end of the file
:error
echo Zenith setup failed.
pause
exit /b 1
