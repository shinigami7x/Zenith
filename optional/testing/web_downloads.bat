@echo off

:: =============
:: Web Downloads
:: =============

setlocal EnableExtensions EnableDelayedExpansion

rem Declare relevant paths
set REPO_ZIP=https://github.com/shinigami7x/Zenith/archive/refs/heads/main.zip
set WORKDIR=%TEMP%\zenith_repo
set USERDIR=%USERPROFILE%
set PICDIR=%USERPROFILE%\Pictures
set YASBDIR=%USERPROFILE%\.config\yasb
set ZDIR=%USERPROFILE%\Documents\Zenith
set DTDIR=%USERPROFILE%\Desktop

echo Creating working directory...
if exist "%WORKDIR%" rmdir /s /q "%WORKDIR%"
mkdir "%WORKDIR%"
if errorlevel 1 goto :error
echo Working directory created.

echo Downloading Zenith repository...
curl -L "%REPO_ZIP%" -o "%WORKDIR%\zenith.zip"
if errorlevel 1 goto :error
echo Zenith respository downloaded.

echo Exctracting Zenith repository...
tar -xf "%WORKDIR%\zenith.zip" -C "%WORKDIR%"
if errorlevel 1 goto :error
echo Zenith respository extracted.

rem Declare local repository directory
for /d %%D in ("%WORKDIR%\Zenith-*") do set REPODIR=%%D

rem Ensure the existence of relevant paths
if not exist "%PICDIR%" mkdir "%PICDIR%"
if not exist "%YASBDIR%" mkdir "%YASBDIR%"
if not exist "%ZDIR%" mkdir "%ZDIR%"

echo Copying icons...
robocopy "%REPODIR%\images\icons" "%PICDIR%\Icons" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo Icons copied.

echo Copying wallpapers...
robocopy "%REPODIR%\images\wallpapers" "%PICDIR%\Wallpapers" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo Wallpapers copied.

echo Copying Komorebi dotfiles...
robocopy "%REPODIR%\dotfiles\komorebi" "%USERDIR%" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo Komorebi dotfiles copied.

echo Copying YASB dotfiles...
robocopy "%REPODIR%\dotfiles\yasb" "%YASBDIR%" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo YASB dotfiles copied.

echo Copying Zenith folder...
robocopy "%REPODIR%\zenith" "%ZDIR%" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo Zenith folder copied.

echo Copying JetBrains Mono Nerd font...
robocopy "%REPODIR%\fonts" "%DTDIR%" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo JetBrains Mono Nerd font copied.

echo Copying VCRuntime...
robocopy "%REPODIR%\optional\testing\deps" "%DTDIR%" /E /IS /IT /R:0 /W:0
if errorlevel 8 goto :error
echo VCRuntime copied.

echo Web downloads completed.
pause
exit /b 0

rem Error statement must remain at the end of the file
:error
echo Web downloads failed.
pause
exit /b 1




