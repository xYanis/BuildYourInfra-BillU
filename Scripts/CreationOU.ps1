# Import-Module ActiveDirectory (Uncomment this line if the Active Directory module is not already imported)
$csvPath = "path\to\your\CSV_Master.csv"
$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"

# Import the CSV file
$csv = Import-Csv -Path $csvPath

# Get unique OU parents, excluding "NA"
$uniqueOUs = $csv | Where-Object { $_.OU -ne "NA" } | Select-Object -ExpandProperty OU -Unique

# Loop through each unique OU parent
foreach ($ou in $uniqueOUs) {
    $ouPath = "OU=$ou,$baseOU"
    # Check if the OU already exists, if not, create it
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $ou} -SearchBase $baseOU -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path $baseOU
        Write-Host "Created parent OU: $ou"
    } else {
        Write-Host "Parent OU already exists: $ou"
    }

    # Get unique child OUs for the current parent OU, excluding "NA"
    $uniqueChildOUs = $csv | Where-Object { $_.OU -eq $ou -and $_.SousOU -ne "NA" } | Select-Object -ExpandProperty SousOU -Unique

    # Loop through each child OU and create it under the parent OU
    foreach ($childOU in $uniqueChildOUs) {
        $childOUPath = "OU=$childOU,$ouPath"
        # Check if the child OU already exists, if not, create it
        if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $childOU} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $childOU -Path $ouPath
            Write-Host "Created child OU: $childOU under parent OU: $ou"
        } else {
            Write-Host "Child OU already exists: $childOU under parent OU: $ou"
        }
    }
}
