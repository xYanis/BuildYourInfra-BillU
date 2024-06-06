# Import-Module ActiveDirectory s'il n'est pas déjà importé
Import-Module ActiveDirectory

# Définir les heures de connexion du lundi au samedi de 7h30 à 20h00
# Chaque heure est représentée par 2 octets (intervalles de 30 minutes)
# Il y a 21 intervalles de 7h30 à 20h00 (42 demi-heures) pour chaque jour (42 * 6 jours = 252 intervalles)
# Total de 336 intervalles par semaine (7 jours * 24 heures * 2 intervalles par heure)


$logonHours = @(
    # Lundi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Mardi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Mercredi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Jeudi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Vendredi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Samedi
    0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    0,0,0,0,0,0,
    # Dimanche (tous les zéros, pas d'accès)
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
)

# Convertir le tableau logonHours en tableau d'octets
$logonHoursBytes = [byte[]]$logonHours

# Obtenez tous les utilisateurs dans BillU-Users
$users = Get-ADUser -SearchBase "OU=YourUsersOU,DC=YourDomain,DC=com" -Filter *

# Mettre à jour les heures de connexion pour chaque utilisateur
foreach ($user in $users) {
    try {
        Set-ADUser -Identity $user -Replace @{logonHours = $logonHoursBytes}
        Write-Output "Updated logon hours for $($user.SamAccountName)"
    } catch {
        Write-Output "Failed to update logon hours for $($user.SamAccountName): $_"
    }
}
