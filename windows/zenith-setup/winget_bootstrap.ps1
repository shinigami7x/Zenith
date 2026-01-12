# =======================
# Zenith Winget Bootstrap
# =======================

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

Write-Host "=== Zenith winget bootstrap starting ==="

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget not found, installing..."

    $bundle = "$env:TEMP\winget.msixbundle"

    invoke-WebRequest -Uri "https://aka.ms/getwinget" -outFile $bundle

    Add-AppxPackage https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx

    if (-Not (Test-Path $bundle)) {throw "Winget bundle not found."}

    Add-AppxPackage $bundle

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "Winget installation failed."
    }

    Write-Host "Winget installed successfully."
} else {
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

function Ask-And-Install($Name, $Id) {
    Write-Host ""
    Write-Host "Install $Name?"
    $response = Read-Host "(y/n)"
    if ($response -match '^[Yy]$') {
        winget install --id $Id -e --accept-source-agreements --accept-package-agreements
    }
}

winget install --id Microsoft.WindowsTerminal --accept-source-agreements --accept-package-agreements

Write-Host "=== Komorebi + YASB installs starting ==="

winget install LGUG2Z.komorebi

winget install LGUG2Z.whkd

winget install --id AmN.yasb

winget install --id Discord.Discord -e --accept-source-agreements --accept-package-agreements

winget install --id Spotify.Spotify -e --accept-source-agreements --accept-package-agreements

winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements --accept-package-agreements

Write-Host "=== Optional installs starting ==="

Ask-And-Install "Microsoft PowerToys" "Microsoft.PowerToys"

Write-Host "=== Zenith post-install complete ==="

Read-Host "Press any key to exit..."