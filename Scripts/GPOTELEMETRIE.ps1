# Désactiver les fonctionnalités de télémétrie Windows avec les clés de registre

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowDeviceNameInTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Write-Host "Les clés de registre pour désactiver la télémétrie ont été modifiées avec succès." -ForegroundColor Green

# Désactiver les services de tracking et autres services inutiles

$services = @("DiagTrack", "dmwappushservice", "Wsearch", "WerSvc")

foreach ($service in $services) {
    $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($serviceStatus -eq $null) {
        Write-Host "Le service $service n'existe pas." -ForegroundColor Red
    } elseif ($serviceStatus.Status -eq 'Stopped' -and (Get-Service $service).StartType -eq 'Disabled') {
        Write-Host "Le service $service est déjà arrêté et désactivé." -ForegroundColor Red
    } else {
        Stop-Service -Name $service -NoWait -Force
        Set-Service -Name $service -StartupType Disabled
        Write-Host "Service $service arrêté et désactivé." -ForegroundColor Green
    }
}

# Désactiver OneDrive

Write-Host "Désactivation du service OneDrive" -ForegroundColor Green
try {
    Get-Process -Name OneDrive -ErrorAction SilentlyContinue | Stop-Process -ErrorAction SilentlyContinue
    Write-Host "Le service OneDrive est désactivé." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de la désactivation du service OneDrive." -ForegroundColor Red
}

# Désinstaller Cortana

Write-Host "Désinstallation de Cortana" -ForegroundColor Green
try {
    Get-AppxPackage -PackageTypeFilter Bundle -Name "*Microsoft.549981C3F5F10*" | Remove-AppxPackage
    Write-Host "Cortana a été désinstallée." -ForegroundColor Green
} catch {
    Write-Host "Erreur lors de la désinstallation de Cortana." -ForegroundColor Red
}
