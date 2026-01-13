# ==================
# App Install Script
# ==================

Write-Host "Required app installs starting..."

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

Write-Host "Required app installs complete."
# Write-Host "Optional installs starting..."

# Ask-And-Install Microsoft PowerToys "Microsoft.PowerToys"

Write-Host "Application installs complete."


