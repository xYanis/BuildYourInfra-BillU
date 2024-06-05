# Chemin du fichier CSV
$csvPath = "path\to\your\CSV_Master.csv"
# Activer la lignes pour le chemin correspondant
$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"
#$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"

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
        Write-Host "Created parent OU: $ou"
    } else {
        Write-Host "Parent OU already exists: $ou"
    }

    # Unique OU enfant pour l'OU parent, et exclure "NA"
    $uniqueChildOUs = $csv | Where-Object { $_.OU -eq $ou -and $_.SousOU -ne "NA" } | Select-Object -ExpandProperty SousOU -Unique

    # Boucle pour chaque OU enfant et création sous l'OU parent
    foreach ($childOU in $uniqueChildOUs) {
        $childOUPath = "OU=$childOU,$ouPath"
        # Vérification OU enfant existe, sinon le créé
        if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $childOU} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $childOU -Path $ouPath
            Write-Host "Created child OU: $childOU under parent OU: $ou"
        } else {
            Write-Host "Child OU already exists: $childOU under parent OU: $ou"
        }
    }
}
