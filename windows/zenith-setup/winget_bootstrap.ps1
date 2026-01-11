# -------------------------------
# Zenith Winget Bootstrap
# -------------------------------

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "=== Zenith winget bootstrap starting ==="

# 1. Ensure winget exists
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget not found, installing..."

    $bundle = "$env:TEMP\winget.msixbundle"

    invoke-WebRequest -Uri "https://aka.ms/getwinget" -outFile $bundle

    if (-Not (Test-Path $bundle)) {throw "Winget bundle not found"}

    # Install App Installer
    Add-AppxPackage $bundle

    # Hard verify
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "winget installation failed"
    }

    Write-Host "Winget installed successfully"
} else {
    Write-Host "Winget already present"
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

winget install --id Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements

Write-Host "=== Komorebi + YASB installs starting ==="

winget install LGUG2Z.komorebi

winget install LGUG2Z.whkd

winget install --id AmN.yasb

Write-Host "=== Zenith post-install complete ==="
Read-Host "Press any key to exit"