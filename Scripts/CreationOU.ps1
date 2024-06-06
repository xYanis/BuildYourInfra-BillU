Import-Module ActiveDirectory #(commenter si le module Active Directory est déjà importer)
# Chemin du fichier CSV
$csvPath = "path\to\your\CSV_Master.csv"
# Activer la lignes pour le chemin correspondant
$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"
#$baseOU = "OU=BillU-Computers,DC=BillU,DC=lan"

# Importation du fichier CSV
$csv = Import-Csv -Path $csvPath

# Unique OU parents, et exclure "NA"
$uniqueOUs = $csv | Where-Object { $_.OU -ne "NA" } | Select-Object -ExpandProperty OU -Unique

# Boucle unique OU parent
foreach ($ou in $uniqueOUs) {
    $ouPath = "OU=$ou,$baseOU"
    # Check if the OU already exists, if not, create it
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $ou} -SearchBase $baseOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path $baseOU
        Write-Host "L'OU parent $ou a été créée"
    } else {
        Write-Host "L'OU parent $ou existe déjà"
    }

    # Unique OU enfant pour l'OU parent, et exclure "NA"
    $uniqueChildOUs = $csv | Where-Object { $_.OU -eq $ou -and $_.SousOU -ne "NA" } | Select-Object -ExpandProperty SousOU -Unique

    # Boucle pour chaque OU enfant et création sous l'OU parent
    foreach ($childOU in $uniqueChildOUs) {
        $childOUPath = "OU=$childOU,$ouPath"
        # Vérification OU enfant existe, sinon le créé
        if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $childOU} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $childOU -Path $ouPath
            Write-Host "L'OU enfant $childOU a été créée sous l'OU parent $ou"
        } else {
            Write-Host "L'OU enfant $childOU existe déjà sous l'OU parent $ou"
        }
    }
}
