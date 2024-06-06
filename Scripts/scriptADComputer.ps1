Import-Module ActiveDirectory
$csvPath = "C:\Users\Administrator\Desktop\CSV_Master.csv"

$computers = Import-Csv -Path $csvPath -Delimiter ',' | Select-Object -Skip 1
$domain = "BillU.lan"

# Parcourir chaque ligne du fichier CSV
foreach ($row in $computers) {
    $nom = $row.Nom
    $computerName = $row.'Nom de PC' + '-' + $nom
    $fonction = $row.fonction
    $service = $row.SousOU
    $departement = $row.OU
    $societe = $row.societe

    # Construire le chemin de l'OU
            if ($Service -eq "NA") {
        $ouPath = "OU=$departement,OU=BillU-Computers,DC=BILLU,DC=LAN"
        }
    else {
        $ouPath = "OU=$service,OU=$departement,OU=BillU-Computers,DC=BILLU,DC=LAN"
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