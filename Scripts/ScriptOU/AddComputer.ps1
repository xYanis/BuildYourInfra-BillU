$csvPath = "C:\Users\Administrator\Desktop\CSVfinal2.csv"

$computers = Import-Csv -Path $csvPath -Delimiter ',' -header 'Prenom','Nom','Societe','Site','Departement','Service','fonction','Manager-Prenom','Manager-Nom','Nom de PC' | Select-Object -Skip 1
$domain = "BillU.lan"

 # Construire le Distinguished Name (DN)
    $baseDn = "CN=$computerName,$ou"
    $dn = $baseDn

    # Vérifier l'unicité du CN et générer un CN unique si nécessaire
    $counter = 1
    while (New-ADComputer -LDAPFilter "(distinguishedName=$dn)") {
        $dn = "CN=$computerName $counter,$ou"
        $counter++
    }
    $ou = "OU=$fonction,OU=$Service,OU=$departement,OU=$societe,OU=BillU-Computers,DC=BILLU,DC=LAN"


Foreach ($computer in $computers) {
    $computerName = $computer.'Nom de PC'
   
    New-ADComputer -Name $computerName -Path $ou
}

