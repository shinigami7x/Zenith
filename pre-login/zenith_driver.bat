@echo off

:: ==========================
:: Zenith Setup Driver Script
:: ==========================

rem Declare relevant paths
set "DOCUMENTS=%USERPROFILE%\Documents"
set "APPINSTALLER_SCRIPT=%DOCUMENTS%\Zenith\appinstaller_bootstrap.ps1"
set "APP_SCRIPT=%DOCUMENTS%\Zenith\app_installs.ps1"
set "VISUAL_SCRIPT=%DOCUMENTS%\Zenith\visual_bootstrap.bat"
set "TASKBAR_SCRIPT=%DOCUMENTS%\Zenith\taskbar_setup.bat"
set "ACTIVATION_SCRIPT=%DOCUMENTS%\Zenith\windows_activate.ps1"

rem Verify that the files exists
if not exist "%APPINSTALLER_SCRIPT%" goto :error
if not exist "%APP_SCRIPT%" goto :error
if not exist "%VISUAL_SCRIPT%" goto :error
if not exist "%TASKBAR_SCRIPT%" goto :error
if not exist "%ACTIVATION_SCRIPT%" goto :error

echo Launching AppInstaller bootstrap script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%APPINSTALLER_SCRIPT%" || goto :error
echo AppInstaller bootstrap script finished running.

echo Launching app install script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%APP_SCRIPT%" || goto :error
echo App install script finished running.

echo Launching visual bootstrap script...
call "%VISUAL_SCRIPT%"
if errorlevel 1 goto :error
echo Visual bootstrap script finished running.

echo Launching taskbar setup script...
call "%TASKBAR_SCRIPT%"
if errorlevel 1 goto :error
echo Taskbar setup script finished running.

echo Launching activation script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%ACTIVATION_SCRIPT%" || goto :error
echo Activation script finished running.

echo Zenith setup completed.
exit /b 0

rem Error statement must remain at the end of the file
:error
echo Zenith setup failed.
pause
exit /b 1



