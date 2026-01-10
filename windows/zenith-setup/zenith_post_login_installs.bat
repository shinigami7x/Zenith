@echo off
echo Optional application installs

choice /C YN /M "Install Komorebi?"
if errorlevel 2 goto skip_komorebi
winget install LGUG2Z.komorebi
:skip_komorebi

choice /C YN /M "Install WHKD?"
if errorlevel 2 goto skip_whkd
winget install LGUG2Z.whkd
:skip_whkd

choice /C YN /M "Install YASB?"
if errorlevel 2 goto skip_yasb
winget install --id AmN.yasb
:skip_yasb

choice /C YN /M "Install NirCmd?"
if errorlevel 2 goto skip_nircmd
winget install -e --id NirSoft.NirCmd
:skip_nircmd

choice /C YN /M "Install PowerToys?"
if errorlevel 2 goto skip_powertoys
winget install --id Microsoft.PowerToys --source winget
:skip_powertoys

choice /C YN /M "Install Spotify?"
if errorlevel 2 goto skip_spotify
winget install Spotify.Spotify
:skip_spotify

choice /C YN /M "Install Discord?"
if errorlevel 2 goto skip_discord
winget install --id Discord.Discord
:skip_discord

choice /C YN /M "Install VSC?"
if errorlevel 2 goto skip_vsc
winget install Microsoft.VisualStudioCode
:skip_vsc

echo Done.
pause







