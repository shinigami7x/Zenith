# =============================
# AppInstaller Bootstrap Script
# =============================

Write-Host "Winget bootstrap starting..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    $ProgressPreference = 'SilentlyContinue'

    $temp = if ($env:TEMP) {
        Join-Path $env:TEMP "winget"
    } else {
        "C:\Windows\Temp\winget"
    }

    $winget = Join-Path $temp "Microsoft.DesktopAppInstaller.msixbundle"

    New-Item -ItemType Directory -Force -Path $temp | Out-Null

    Write-Host "Downloading App Installer bundle..."

    $downloaded = $false

    try {
        $bitsService = Get-Service BITS -ErrorAction Stop
        if ($bitsService.Status -ne 'Running') { Start-Service BITS }

        Start-BitsTransfer -Source "https://aka.ms/getwinget" -Destination $winget -ErrorAction Stop

        $downloaded = $true
        Write-Host "Download completed."
    }
    catch {
        Write-Warning "BITS download failed, falling back to Invoke-WebRequest..."
    }

       if (-not $downloaded) {
        Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile $winget -UseBasicParsing
        Write-Host "Download completed."
    }

    if (-not (Test-Path $winget)) { throw "Download failed: winget bundle not found." }
    if ((Get-Item $winget).Length -eq 0) { throw "Download failed: winget bundle is empty." }

    Write-Host "Installing Winget..."
    Add-AppxPackage -Path $winget -ErrorAction Stop

    Write-Host "Winget installed successfully."
}
else {
    Write-Host "Winget already present."
}