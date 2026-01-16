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
 
Write-Host "Required app installs starting..."
 
& $Winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
& $Winget install --id LGUG2Z.komorebi -e --accept-source-agreements --accept-package-agreements
& $Winget install --id LGUG2Z.whkd -e --accept-source-agreements --accept-package-agreements
& $Winget install --id AmN.yasb -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Zen-Team.Zen-Browser -e --accept-source-agreements --accept-package-agreements
& $Winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements --accept-package-agreements
 
Write-Host "Required app installs complete."
 
Write-Host "Optional app installs starting..."
 
$runInstall = Read-Host "Do you want to install Spotify? (y/n)"
 
if ($runInstall -ieq "y") {
 
    $installScript = "$env:USERPROFILE\Documents\Zenith\optional-apps\spotify_install.bat"
    $explorer = Get-Process explorer -ErrorAction SilentlyContinue | Select-Object -First 1
 
    if (-not $explorer) {
        Write-Error "No logged-in user detected. Cannot run Spotify installer."
        exit 1
    }
 
    $username = $explorer.StartInfo.EnvironmentVariables['USERNAME']
    $userProfile = [System.Environment]::ExpandEnvironmentVariables("%SystemDrive%\Users\$username")
 
    Write-Host "Launching Spotify installation script as user '$username'..."
 
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$installScript`"" -WorkingDirectory "$userProfile" -WindowStyle Normal
 
    Write-Host "Spotify installation script launched."

} else {
    Write-Host "Skipping Spotify installation."
}
 
Write-Host "Zenith app installs finished."