# Importer le module Active Directory
Import-Module ActiveDirectory

# Chemin vers le fichier CSV
$csvPath = "C:\Users\Administrator\Desktop\CSV_Master.csv"

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ','

# Boucle sur chaque ligne du CSV
foreach ($user in $users) {
    # Vérifier si les champs Prenom et Nom existent et ne sont pas vides
    if (-not $user.Prenom -or -not $user.Nom) {
        Write-Output "L'utilisateur avec des informations manquantes (Prenom ou Nom) ne peut pas être ajouté. Ligne: $($user | Out-String)"
        continue
    }

    $prenom = $user.Prenom.Trim()
    $nom = $user.Nom.Trim()

    if (-not $prenom -or -not $nom) {
        Write-Output "L'utilisateur avec des informations manquantes après nettoyage (Prenom ou Nom) ne peut pas être ajouté. Ligne: $($user | Out-String)"
        continue
    }

    $societe = $user.Societe
    $departement = $user.OU
    $Service = $user.SousOU
    $groupDep = $user.Groupe_Departement
    $groupServ = $user.Groupe_Service
    $telephoneFixe = $user."Telephone fixe"
    $telephonePortable = $user."Telephone portable"

    # Définir l'OU
    if ($Service -eq "NA") {
        $ouPath = "OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
    } else {
        $ouPath = "OU=$service,OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
    }

    # Générer des noms d'utilisateur uniques
    $samAccountName = ($prenom + "." + $nom).ToLower()
    $userPrincipalName = "$samAccountName@billu.lan"

    # Vérifier l'unicité du SamAccountName
    $counter = 1
    while (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
        $samAccountName = ($prenom + "." + $nom + $counter).ToLower()
        $userPrincipalName = "$samAccountName@billu.lan"
        $counter++
    }

    # Attributs de l'utilisateur
    $userParams = @{
        SamAccountName    = $samAccountName
        UserPrincipalName = $userPrincipalName
        Name              = "$prenom $nom"
        Surname           = $nom
        GivenName         = $prenom
        DisplayName       = "$prenom $nom"
        Path              = $ouPath
        AccountPassword   = (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force)
        Enabled           = $true
        EmailAddress      = $userPrincipalName
        Company           = $societe
        Department        = $departement
        Title             = $user.Fonction
        OfficePhone       = $telephoneFixe
        MobilePhone       = $telephonePortable
    }

    # Vérifier si l'utilisateur existe dans l'Active Directory
    $existingUser = Get-ADUser -Filter { SamAccountName -eq $samAccountName } -ErrorAction SilentlyContinue

    if ($existingUser) {
        # Mettre à jour l'utilisateur existant
        try {
            Set-ADUser @userParams
            Write-Output "Utilisateur $prenom $nom mis à jour avec succès à $ou"
        } catch {
            Write-Output "Erreur lors de la mise à jour de $prenom $nom : $_"
        }
    } else {
        # Ajouter l'utilisateur et ajouter au groupes du département et du service
        try {
            New-ADUser @userParams
            Add-ADGroupMember -Identity $groupDep -Members $samAccountName
            Add-ADGroupMember -Identity $groupServ -Members $samAccountName
            Write-Output "Utilisateur $prenom $nom ajouté avec succès à $ou"
        } catch {
            Write-Output "Erreur lors de l'ajout de $prenom $nom : $_"
        }
    }
}

# Déplacer les utilisateurs qui ne sont pas présents dans le fichier CSV mais présents dans l'Active Directory
$adUsers = Get-ADUser -Filter * -SearchBase "OU=BillU-Users,DC=BILLU,DC=LAN" -Properties SamAccountName

foreach ($adUser in $adUsers) {
    $samAccountName = $adUser.SamAccountName

    # Vérifier si l'utilisateur est présent dans le fichier CSV en utilisant SamAccountName
    $csvUser = $users | Where-Object {
        $csvPrenom = $_.Prenom.Trim().ToLower()
        $csvNom = $_.Nom.Trim().ToLower()
        $csvSamAccountName = ($csvPrenom + "." + $csvNom).ToLower()

        $counter = 1
        while (Get-ADUser -Filter { SamAccountName -eq $csvSamAccountName }) {
            $csvSamAccountName = ($csvPrenom + "." + $csvNom + $counter).ToLower()
            $counter++
        }

        $csvSamAccountName -eq $samAccountName
    }

    if (-not $csvUser) {
        # Déplacer l'utilisateur vers l'OU spécifiée
        try {
            Move-ADObject -Identity $adUser.DistinguishedName -TargetPath "OU=Corbeille,OU=User-BillU,DC=BillU,DC=lan"
            Write-Output "Utilisateur $samAccountName déplacé vers l'OU Corbeille"
        } catch {
            Write-Output "Erreur lors du déplacement de $samAccountName : $_"
        }
    }
}
