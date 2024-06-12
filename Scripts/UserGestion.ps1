# Importer le module Active Directory
Import-Module ActiveDirectory

# Chemin vers le fichier CSV
$csvPath = "C:\Projet_3\CSV_Master.csv"

# Lire le fichier CSV
$users = Import-Csv -Path $csvPath -Delimiter ','

# Boucle sur chaque ligne du CSV
foreach ($user in $users) {
    # Vérifier si les champs Prenom et Nom existent et ne sont pas vides
    if (-not $user.Prenom -or -not $user.Nom) {
        Write-Host "L'utilisateur avec des informations manquantes (Prenom ou Nom) ne peut pas être ajouté. Ligne: $($user | Out-String)" -ForegroundColor DarkRed
        continue
    }

    $prenom = $user.Prenom.Trim()
    $nom = $user.Nom.Trim()
    if ($nom.Length -ge 10) {
        $nom = $nom.Substring(0, 5)
    }
    
    if (-not $prenom -or -not $nom) {
        Write-Host "L'utilisateur avec des informations manquantes après nettoyage (Prenom ou Nom) ne peut pas être ajouté. Ligne: $($user | Out-String)" -ForegroundColor DarkRed
        continue
    }

    $societe = $user.Societe
    $departement = $user.OU
    $Service = $user.SousOU
    $groupDep = $user.Groupe_Departement
    $groupServ = $user.Groupe_Service
    $telephoneFixe = $user."Telephone fixe"
    $telephonePortable = $user."Telephone portable"
    $birthday          = $user."Date de naissance"

    # Définir l'OU
    if ($Service -eq "NA") {
        $ouPath = "OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
    } else {
        $ouPath = "OU=$service,OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
    }

    # Générer des noms d'utilisateur uniques
    $samAccountName = ($prenom + "." + $nom).ToLower()
    $userPrincipalName = ([string] ($user.Prenom.ToLower() + "." + $user.Nom.ToLower() + "@billu.lan"))

    # Vérifier l'unicité du SamAccountName
    $counter = 1
    while (Get-ADUser -Filter { SamAccountName -eq $samAccountName }) {
        $samAccountName = ($prenom + "." + $nom + $counter).ToLower()

        $userPrincipalName = ([string] ($user.Prenom.ToLower() + "." + $user.Nom.ToLower() + $counter + "@billu.lan"))
        $counter++
    }

    # Attributs de l'utilisateur
    $userParams = @{
        SamAccountName    = $samAccountName
        UserPrincipalName = $userPrincipalName
        Name              = $user.Prenom + " " + $user.Nom
        Surname           = $user.Nom
        GivenName         = $user.Prenom
        DisplayName       = ([string] ($user.Prenom + " " + $user.Nom))
        Path              = $ouPath
        Description       = $birthday
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
            Write-Host "Utilisateur $prenom $nom mis à jour avec succès à $ouPath" -ForegroundColor DarkGreen
        } catch {
            Write-Host "Erreur lors de la mise à jour de $prenom $nom : $_" -ForegroundColor DarkRed
        }
    } else {
        # Ajouter l'utilisateur et ajouter au groupes du département et du service
        try {
            New-ADUser @userParams
            Add-ADGroupMember -Identity $groupDep -Members $samAccountName
            if ($groupServ -eq 'NA') {
                continue
             else   
            Add-ADGroupMember -Identity $groupServ -Members $samAccountName }
            Write-Host "Utilisateur $prenom $nom ajouté avec succès à $ouPath" -ForegroundColor DarkGreen
        } catch {
            Write-Host "Erreur lors de l'ajout de $prenom $nom : $_" -ForegroundColor DarkRed
        }
    }
}

# Déplacer les utilisateurs qui ne sont pas présents dans le fichier CSV mais présents dans l'Active Directory

$adUsers = Get-ADUser -Filter * -SearchBase "OU=BillU-Users,DC=BILLU,DC=LAN" -Properties Surname, GivenName, Description

foreach ($adUser in $adUsers) {
    $samAccountName = ($adUser.GivenName + " " + $adUser.Surname + " " + $adUser.Description)

    # Vérifier si l'utilisateur est présent dans le fichier CSV en utilisant prénom, nom et date de naissance
    $csvUser = $users | Where-Object {
        $csvPrenom = $_.Prenom
        $csvNom = $_.Nom
        $csvDescription = $_."Date de naissance"
        $csvSamAccountName = ($csvPrenom + " " + $csvNom + " " + $csvDescription)


        $csvSamAccountName -eq $samAccountName
    }
$samAccountNameLite = ($adUser.GivenName + " " + $adUser.Surname)
    if (-not $csvUser) {
        # Désactiver et déplacer l'utilisateur vers l'OU Corbeille
        try {
            Disable-ADAccount -Identity $adUser.DistinguishedName
            Move-ADObject -Identity $adUser.DistinguishedName -TargetPath "OU=Corbeille,OU=BillU-Users,DC=BillU,DC=lan"
            Write-Host "Utilisateur $samAccountNameLite désactivé et déplacé vers l'OU Corbeille" -ForegroundColor DarkGreen
        } catch {
            Write-Host "Erreur lors du déplacement de $samAccountNameLite : $_" -ForegroundColor DarkRed
        }
    }
}
