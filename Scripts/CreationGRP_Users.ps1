Import-Module ActiveDirectory #(commenter si le module Active Directory est déjà importer)

$csvPath = "path\to\your\CSV_Master.csv"
$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"

# Import the CSV file
$csv = Import-Csv -Path $csvPath

# Get unique combinations of OU and Groupe_Departement, excluding rows with "NA"
# $uniqueDeptGroups = $csv | Where-Object { $_.OU -ne "NA" -and $_.Groupe_Departement -ne "NA" } | Select-Object -Property OU, Groupe_Departement -Unique

# Loop through each unique combination of OU and Groupe_Departement
foreach ($item in $uniqueDeptGroups) {
    $ou = $item.OU
    $groupDept = $item.Groupe_Departement
    $ouPath = "OU=$ou,$baseOU"
    
    # Check if the group already exists, if not, create it
    if (-not (Get-ADGroup -Filter {Name -eq $groupDept} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupDept -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Created group: $groupDept in OU: $ou"
    } else {
        Write-Host "Group already exists: $groupDept in OU: $ou"
    }
}

# Get unique combinations of SousOU and Groupe_Service, excluding rows with "NA"
$uniqueServiceGroups = $csv | Where-Object { $_.SousOU -ne "NA" -and $_.Groupe_Service -ne "NA" } | Select-Object -Property OU, SousOU, Groupe_Service -Unique

# Loop through each unique combination of SousOU and Groupe_Service
foreach ($item in $uniqueServiceGroups) {
    $ou = $item.OU
    $sousOU = $item.SousOU
    $groupService = $item.Groupe_Service
    $ouPath = "OU=$sousOU,OU=$ou,$baseOU"
    
    # Check if the group already exists, if not, create it
    if (-not (Get-ADGroup -Filter {Name -eq $groupService} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupService -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Created group: $groupService in OU: $sousOU under parent OU: $ou"
    } else {
        Write-Host "Group already exists: $groupService in OU: $sousOU under parent OU: $ou"
    }
}
