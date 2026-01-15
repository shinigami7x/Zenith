# =========================
# Windows Activation Script
# =========================

$downloadUrls = @(
 "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/da0b2800d9c783e63af33a6178267ac2201adb2a/MAS/All-In-One-Version-KL/MAS_AIO.cmd",
 "https://dev.azure.com/massgrave/Microsoft-Activation-Scripts/_apis/git/repositories/Microsoft-Activation-Scripts/items?path=/MAS/All-In-One-Version-KL/MAS_AIO.cmd&versionType=Commit&version=da0b2800d9c783e63af33a6178267ac2201adb2a",
 "https://git.activated.win/Microsoft-Activation-Scripts/plain/MAS/All-In-One-Version-KL/MAS_AIO.cmd?id=da0b2800d9c783e63af33a6178267ac2201adb2a"
)
$downDir = "$env:USERPROFILE\Documents\Zenith"
$cmdFile = Join-Path $downDir "WinActivate.cmd"

if (-not (Test-Path $downDir)) {
    New-Item -ItemType Directory -Path $downDir | Out-Null
}

$errors = @()
$response = $null

Write-Host "Attempting to download script..."
foreach ($URL in $downloadUrls | Sort-Object { Get-Random }) {
    try {
        if ($PSVersionTable.PSVersion.Major -ge 3) {
            $response = Invoke-RestMethod -Uri $URL -ErrorAction Stop
        } else {
            $wc = New-Object Net.WebClient
            $response = $wc.DownloadString($URL)
        }

        Write-Host "Download succeeded."
        break
    }
    catch {
        $errors += $_
    }
}

if (-not $response) {
    Write-Host "Download failed."
    Read-Host "Press any key to exit."
    exit 1
}

try {
    Set-Content -Path $cmdFile -Value $response -Encoding ASCII
    Write-Host "Saved script to $cmdFile"
}
catch {
    Write-Host "Failed to save script."
    Read-Host "Press any key to exit."
    exit 1
}

try {
    Write-Host "Running script..."
    Start-Process -FilePath $cmdFile -ArgumentList /HWID -Wait
}
catch {
    Write-Host "Failed to run script."
    Read-Host "Press any key to exit."
    exit 1
}

Write-Host "Script complete."