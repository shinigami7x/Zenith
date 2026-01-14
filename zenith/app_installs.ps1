# ==================
# App Install Script
# ==================

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "Resolving winget executable..."

$WingetPath = (Get-AppxPackage Microsoft.DesktopAppInstaller -ErrorAction Stop).InstallLocation
$Winget = Join-Path $WingetPath "winget.exe"

if (-not (Test-Path $Winget)) {
    throw "winget.exe not found."
}

& $Winget --info

Write-Host "Required app installs starting..."

& $Winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
& $Winget install --id LGUG2Z.komorebi -e --accept-source-agreements --accept-package-agreements
& $Winget install --id LGUG2Z.whkd -e --accept-source-agreements --accept-package-agreements
& $Winget install --id AmN.yasb -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Zen-Team.Zen-Browser -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Discord.Discord -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Spotify.Spotify -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements --accept-package-agreements

Write-Host "Required app installs complete."