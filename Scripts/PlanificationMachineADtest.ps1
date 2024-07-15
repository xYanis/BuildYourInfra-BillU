# Dernière écriture sur le fichier CSV_Master
$lastWriteTime = (Get-Item "C:\Users\Administrator\Desktop\CSV_Master.csv").LastWriteTime

# Wait for 5 seconds
Start-Sleep -Seconds 5

# Vérifier si le fichier a été modifié
$currentWriteTime = (Get-Item "C:\Users\Administrator\Desktop\CSV_Master.csv").LastWriteTime
if ($currentWriteTime -ne $lastWriteTime) {
    Write-Host "Le fichier a été modifié!"
# Executer la commande de mise à jour de l'AD
-ExecutionPolicy Bypass -File "C:\Script\scriptADDComputer.ps1"

}
