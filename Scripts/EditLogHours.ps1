# A tester sur GUY!!!!!
# Importation du module active directory
Import-Module ActiveDirectory

# Défini les heures de connexion du lundi au samedi de 7h30 à 20h
$logonHours = @(
    # Dimanche: 24 hours * 0 (no access)
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    # Lundi: 7:30 à 20:00  (30 minutes intervals, 1 means access, 0 means no access)
    0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,
    # Pépéte le même pattern pour mardi à samedi
    0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,0,0,
    # Dimanche: 24 hours * 0 (no access)
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
)

# Convertir le tableau logonHours en tableau d'octets
$logonHoursBytes = [byte[]]$logonHours

# Obtenez tous les utilisateurs sauf ceux du groupe "Administrateurs du domaine"
$users = Get-ADUser -Filter * -SearchBase "OU=BillU-Users,DC=BillU,DC=lan" -Properties MemberOf #| Where-Object { $_.MemberOf -notcontains "CN=Domain Admins,CN=Users,DC=BillU,DC=lan" }

# Mettre à jour les heures de connexion pour chaque utilisateur
foreach ($user in $users) {
    Set-ADUser -Identity $user -Replace @{logonHours = $logonHoursBytes}
    Write-Output "Mise à jour logon hours pour $($user.SamAccountName)"
}
