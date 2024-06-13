# Définir le chemin du dossier Logs
$logFilePath = "C:\Logs\DeleteUser.log"

# Commencer la transcryption
Start-Transcript -Path $logFilePath -Append

Get-ADUser -Filter * -SearchBase "OU=BillU-Users,DC=BILLU,DC=LAN" | Remove-ADUser -Confirm

# Fin de la transcryption
Stop-Transcript
