@echo off

:: =================================
:: Zenith installation driver script
:: =================================

rem Declare relevant paths
set "DOCUMENTS=%USERPROFILE%\Documents"
set "APPINSTALLER_SCRIPT=%DOCUMENTS%\Zenith\appinstaller_bootstrap.ps1"
set "APP_SCRIPT=%DOCUMENTS%\Zenith\app_installs.ps1"
set "YASB_SCRIPT=%DOCUMENTS%\Zenith\yasb_bootstrap.bat"
set "ACTIVATION_SCRIPT=%DOCUMENTS%\Zenith\windows_activate.ps1"

rem Verify that the files exists
if not exist "%APPINSTALLER_SCRIPT%" goto :error
if not exist "%APP_SCRIPT%" goto :error
if not exist "%YASB_SCRIPT%" goto :error
if not exist "%ACTIVATION_SCRIPT%" goto :error

echo Launching AppInstaller bootstrap script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%APPINSTALLER_SCRIPT%" || goto :error
echo AppInstaller bootstrap script finished running.

echo Launching app install script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%APP_SCRIPT%" || goto :error
echo App install script finished running.

echo Launching activation script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%ACTIVATION_SCRIPT%" || goto :error
echo Activation script finished running.

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


