$ErrorActionPreference = "Stop"

$ProgressPreference = "SilentlyContinue"

Write-Host "Winget bootstrap starting..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    $temp = Join-Path $env:TEMP "winget"
    $winget = Join-Path $temp "winget.msixbundle"

    New-Item -ItemType Directory -Force -Path $temp | Out-Null

    Write-Host "Downloading dependencies..."

    Invoke-WebRequest "https://aka.ms/getwinget" -OutFile $winget

    Write-Host "Installing Winget..."

    Add-AppxPackage -Path $winget -InstallAllUsers -ErrorAction Stop

    Write-Host "Winget installed successfully."

} else { Write-Host "Winget already present." }