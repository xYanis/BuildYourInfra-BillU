$csvPath = "C:\Users\Administrator\Desktop\CSVfinal2.csv"

$computers = Import-Csv -Path $csvPath -Delimiter ',' -header 'Prenom','Nom','Societe','Site','Departement','Service','fonction','Manager-Prenom','Manager-Nom','Nom de PC' | Select-Object -Skip 1
$domain = "BillU.lan"

# Parcourir chaque ligne du fichier CSV
foreach ($row in $computerData) {
    $computerName = $row.computerName
    $fonction = $row.fonction
    $service = $row.service
    $departement = $row.departement
    $societe = $row.societe

    # Construire le chemin de l'OU
    $ouPath = "OU=$fonction,OU=$service,OU=$departement,OU=$societe,OU=BillU-Computers,DC=BILLU,DC=LAN"

    # Vérifier si l'OU existe déjà
    $ouExists = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouPath'" -ErrorAction SilentlyContinue

    if (-not $ouExists) {
        # Créer l'OU si elle n'existe pas
        New-ADOrganizationalUnit -Name $fonction -Path "OU=$service,OU=$departement,OU=$societe,OU=BillU-Computers,DC=BILLU,DC=LAN"
        Write-Host "OU $ouPath created."
    } else {
        Write-Host "OU $ouPath already exists."
    }

    # Vérifier si l'ordinateur existe déjà
    $computerExists = Get-ADComputer -Filter "Name -eq '$computerName'" -SearchBase $ouPath -ErrorAction SilentlyContinue

    if (-not $computerExists) {
        # Créer l'objet ordinateur
        New-ADComputer -Name $computerName -Path $ouPath
        Write-Host "Computer $computerName created in $ouPath."
    } else {
        Write-Host "Computer $computerName already exists in $ouPath."
    }
}