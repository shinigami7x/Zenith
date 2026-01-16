# ==================
# Icon Hiding Script
# ==================

$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$current = (Get-ItemProperty $key).HideIcons

$new = if ($current -eq 1) { 0 } else { 1 }
Set-ItemProperty $key -Name HideIcons -Value $new

Stop-Process -Name explorer -Force