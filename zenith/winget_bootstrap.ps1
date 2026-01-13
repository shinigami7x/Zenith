# ===================
# Winget Setup Script
# ===================

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "Winget bootstrap starting..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    $temp = Join-Path $env:TEMP "winget"
    New-Item -ItemType Directory -Force -Path $temp | Out-Null

    $winget = Join-Path $temp "winget.msixbundle"

    Write-Host "Downloading dependencies..."
    Invoke-WebRequest "https://aka.ms/getwinget" -OutFile $winget

    Write-Host "Installing Winget (binding dependencies)..."
    Add-AppxPackage -Path $winget -ErrorAction Stop

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "Winget install completed but winget is still unavailable."
    }

    Write-Host "Winget installed successfully."
}
else {
    Write-Host "Winget already present."
}

Write-Host "Winget bootstrap complete."

