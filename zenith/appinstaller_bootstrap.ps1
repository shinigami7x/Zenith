Write-Host "Winget bootstrap starting..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    $temp = Join-Path $env:TEMP "winget"
    if (-not $env:TEMP) { $temp = "C:\Windows\Temp\winget" }
    $winget = Join-Path $temp "Microsoft.DesktopAppInstaller.msixbundle"

    New-Item -ItemType Directory -Force -Path $temp | Out-Null

    Write-Host "Downloading App Installer bundle..."
    Invoke-WebRequest "https://aka.ms/getwinget" -OutFile $winget

    if (-not (Test-Path $winget)) { throw "Download failed: winget bundle not found." }
    if ((Get-Item $winget).Length -eq 0) { throw "Download failed: winget bundle is empty." }

    Write-Host "Installing Winget..."
    Add-AppxPackage -Path $winget -ErrorAction Stop

    Write-Host "Winget installed successfully."
} else {
    Write-Host "Winget already present."
}