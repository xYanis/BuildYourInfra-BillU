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
      # Construire le chemin de l'OU
     # D�finir l'OU
    if ($Service -eq "NA") {
        $ouPath = "OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
        }
    else {
        $ouPath = "OU=$service,OU=$departement,OU=BillU-Users,DC=BILLU,DC=LAN"
    }
    # Vérifier si l'OU existe déjà
    #$ouExists = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouPath'" -ErrorAction SilentlyContinue

    #if (-not $ouExists) {
        # Créer l'OU si elle n'existe pas
     #   New-ADOrganizationalUnit -Name $fonction -Path "OU=$service,OU=$departement,OU=$societe,OU=BillU-Users,DC=BILLU,DC=LAN"
      #  Write-Host "OU $ouPath created."
   # } else {
    #    Write-Host "OU $ouPath already exists."
    #}

    # Construire le Distinguished Name (DN)
    $baseDn = "CN=$prenom $nom,$ou"
    $dn = $baseDn

    # Vérifier l'unicité du CN et générer un CN unique si nécessaire
    $counter = 1
    while (Get-ADUser -LDAPFilter "(distinguishedName=$dn)") {
        $dn = "CN=$prenom $nom $counter,$ou"
        $counter++
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
        Title             = $fonction
        OfficePhone       = $telephoneFixe
        MobilePhone       = $telephonePortable
    }

    # Ajout de l'utilisateur
    try {
        New-ADUser @userParams
        Add-ADGroupMember -Identity $groupDep -Members $samAccountName
        Add-ADGroupMember -Identity $groupServ -Members $samAccountName
        Write-Output "Utilisateur $prenom $nom ajouté avec succès à $ou"
    } catch {
        Write-Output "Erreur lors de l'ajout de $prenom $nom : $_"
    }
}
