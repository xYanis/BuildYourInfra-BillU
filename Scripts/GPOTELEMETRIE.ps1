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


# Définir les noms de packages à supprimer avec DISM
$packages = @(
    "Microsoft.549981C3F5F10_4.2308.1005.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.BingWeather_4.53.60911.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.DesktopAppInstaller_2024.506.2113.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.GetHelp_10.2403.20861.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Getstarted_2021.2312.1.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.HEIFImageExtension_1.1.861.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Microsoft3DViewer_2024.2401.29012.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftEdge.Stable_122.0.2365.66_neutral__8wekyb3d8bbwe",
    "Microsoft.MicrosoftOfficeHub_18.2405.1221.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftSolitaireCollection_4.19.5100.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MicrosoftStickyNotes_6.0.2.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MixedReality.Portal_2000.21051.1282.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.MSPaint_2024.2402.12017.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Office.OneNote_16001.14326.21886.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.People_2021.2202.100.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.ScreenSketch_2021.2008.3001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.SkypeApp_15.119.3201.0_neutral_~_kzf8qxf38zg5c",
    "Microsoft.StorePurchaseApp_22403.1401.1.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.VCLibs.140.00_14.0.33519.0_x64__8wekyb3d8bbwe",
    "Microsoft.VP9VideoExtensions_1.1.451.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Wallet_2.4.18324.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WebMediaExtensions_1.1.1295.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WebpImageExtension_1.1.1221.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Windows.Photos_2024.11030.15001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsAlarms_2021.2403.8.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsCalculator_2021.2403.6.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsCamera_2022.2404.4.0_neutral_~_8wekyb3d8bbwe",
    "microsoft.windowscommunicationsapps_16005.14326.21904.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsFeedbackHub_2024.510.1505.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsMaps_2022.2403.4.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsSoundRecorder_2021.2103.28.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.WindowsStore_22404.1401.2.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.Xbox.TCUI_1.24.10001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxApp_48.104.4001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGameOverlay_1.54.4001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxGamingOverlay_7.124.3191.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxIdentityProvider_12.95.3001.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.YourPhone_1.24042.107.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.ZuneMusic_11.2403.5.0_neutral_~_8wekyb3d8bbwe",
    "Microsoft.ZuneVideo_2019.22091.10061.0_neutral_~_8wekyb3d8bbwe"
)

# Supprimer chaque package avec DISM
foreach ($package in $packages) {
    Write-Output "Suppression de $package ..."
    $result = Start-Process -FilePath "dism.exe" -ArgumentList "/Online /Remove-ProvisionedAppxPackage /PackageName:$package" -Wait -PassThru
    if ($result.ExitCode -eq 0) {
        Write-Host "Package $package supprimé avec succès." -ForegroundColor Green
    } else {
        Write-Host "Échec de la suppression du package $package. Code d'erreur: $($result.ExitCode)" -ForegroundColor Red
    }
}

