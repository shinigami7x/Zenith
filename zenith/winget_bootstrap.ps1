# ===================
# Winget Setup Script
# ===================

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "Winget bootstrap starting..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    $temp = Join-Path $env:TEMP "winget"
    New-Item -ItemType Directory -Force -Path $temp | Out-Null

    $vclibs = Join-Path $temp "Microsoft.VCLibs.x64.14.00.Desktop.appx"
    $winget = Join-Path $temp "winget.msixbundle"

    Write-Host "Downloading dependencies..."
    Invoke-WebRequest "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile $vclibs
    Invoke-WebRequest "https://aka.ms/getwinget" -OutFile $winget

    Write-Host "Installing VCLibs..."
    Add-AppxPackage -Path $vclibs -ErrorAction Stop

    Write-Host "Installing Winget (binding dependencies)..."
    Add-AppxPackage `
    -Path $winget `
    -DependencyPath $vclibs `
    -ErrorAction Stop

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "Winget install completed but winget is still unavailable."
    }

    Write-Host "Winget installed successfully."
}
else {
    Write-Host "Winget already present."
}

Write-Host "Verifying winget responsiveness..."

for ($i = 0; $i -lt 10; $i++) {
    try {
        winget --version | Out-Null
        break
    } catch {
        Start-Sleep 2
    }
}

Write-Host "Winget bootstrap complete."

Read-Host "Press any key to exit..."