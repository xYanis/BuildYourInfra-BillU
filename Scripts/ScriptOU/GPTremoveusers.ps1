Clear-Host
##################################
#                                #
#   Suppression USER dans l'AD   #
#                                #
##################################

### Paramètres à modifier
# Liste des utilisateurs en bypass
$BypassUsers = @("Administrator", "Guest", "DefaultAccount", "User1",
"User2", "wilder", "krbtgt", "adminlab")

### Main
# Obtenir tous les utilisateurs AD sauf ceux dans la liste de bypass
$ADUsersToRemove = Get-ADUser -Filter * | Where-Object { $BypassUsers
-notcontains $_.SamAccountName }

# Supprimer les utilisateurs filtrés sans confirmation
foreach ($user in $ADUsersToRemove) {
     Remove-ADUser -Identity $user -Confirm:$false
}
