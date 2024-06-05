#                   #
# The Master Script #
#                   #
#  MERCI BRUBRU <3  #

#Installez le module ImportExcel s'il n'est pas déjà installé
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
  Install-Module -Name ImportExcel -Force
}

#Spécifiez le chemin du fichier Excel d'entrée et du fichier CSV de sortie
$excelFilePath = "C:\Projet_3\s09_BillU.xlsx"
$csvBillUFilePath = "C:\Projet_3\BillU.csv"

$fichierCSV = "C:\Projet_3\CSV_Master.csv"


#Importez les données du fichier Excel
$data = Import-Excel -Path $excelFilePath

#Filtrez les lignes où la colonne "société" contient "BillU"
$filteredData = $data | Where-Object { $_.Societe -match "BillU" }

#Exportez les données filtrées en CSV
$filteredData | Export-Csv -Path $csvBillUFilePath -NoTypeInformation

# Importer les données CSV dans une variable PowerShell
$data = Import-Csv -Path $csvBillUFilePath

# Ajouter une nouvelle colonne "Groupe_Departement" à la variable $data
$data | Add-Member -MemberType NoteProperty -Name 'Groupe_Departement' -Value ''

# Ajouter une nouvelle colonne "Groupe_Service" à la variable $data
$data | Add-Member -MemberType NoteProperty -Name 'Groupe_Service' -Value ''

# Ajouter les nouvelles colonnes "OU" et "SousOU" à la variable $data
$data | Add-Member -MemberType NoteProperty -Name 'OU' -Value ''
$data | Add-Member -MemberType NoteProperty -Name 'SousOU' -Value ''

# Parcourir chaque ligne de la variable $data
foreach ($row in $data) {
  # Extraire la valeur des colonnes "Departement" et "Service"
  $departement = $row.Departement
  $service = $row.Service

  # Déterminer la valeur de "Groupe_Departement" basée sur "Departement"
  switch ($departement) {
      "Communication et Relations publiques" { $row.Groupe_Departement = "GRP_CRP" }
      "Département Juridique" { $row.Groupe_Departement = "GRP_DJ" }
      "Développement logiciel" { $row.Groupe_Departement = "GRP_DEVL" }
      "Direction" { $row.Groupe_Departement = "GRP_DIR" }
      "DSI" { $row.Groupe_Departement = "GRP_DSI" }
      "Finance et Comptabilité" { $row.Groupe_Departement = "GRP_FC" }
      "QHSE" { $row.Groupe_Departement = "GRP_QHSE" }
      "Service Commercial" { $row.Groupe_Departement = "GRP_SC" }
      "Service recrutement" { $row.Groupe_Departement = "GRP_RECR" }
      "" { $row.Groupe_Departement = "NA" }
      default { $row.Groupe_Departement = "" }
  }

  # Déterminer la valeur de "Groupe_Service" basée sur "Service"
  switch ($service) {
      "Communication interne" { $row.Groupe_Service = "GRP_CRP_CI" }
      "Relation Médias" { $row.Groupe_Service = "GRP_CRP_RM" }
      "Gestion des marques" { $row.Groupe_Service = "GRP_CRP_GM" }
      "Protection des données et conformité" { $row.Groupe_Service = "GRP_DJ_DATA" }
      "Propriété intellectuelle" { $row.Groupe_Service = "GRP_DJ_PI" }
      "Développement" { $row.Groupe_Service = "GRP_DEVL_DEV" }
      "Test et qualité" { $row.Groupe_Service = "GRP_DEVL_TQ" }
      "analyse et conception" { $row.Groupe_Service = "GRP_DEVL_AC" }
      "Recherche et Prototype" { $row.Groupe_Service = "GRP_DEVL_RP" }
      "Exploitation" { $row.Groupe_Service = "GRP_DSI_EXP" }
      "Administration Systèmes et Réseaux" { $row.Groupe_Service = "GRP_DSI_ADMIN" }
      "Support" { $row.Groupe_Service = "GRP_DSI_SUP" }
      "Développement et Intégration" { $row.Groupe_Service = "GRP_DSI_DI" }
      "Service Comptabilité" { $row.Groupe_Service = "GRP_FC_COM" }
      "Finance" { $row.Groupe_Service = "GRP_FC_FIN" }
      "Fiscalité" { $row.Groupe_Service = "GRP_FC_FIS" }
      "Contrôle Qualité" { $row.Groupe_Service = "GRP_QHSE_CQ" }
      "Gestion environnementale" { $row.Groupe_Service = "GRP_QHSE_GE" }
      "Certification" { $row.Groupe_Service = "GRP_QHSE_SER" }
      "Service Client" { $row.Groupe_Service = "GRP_SC_SCL" }
      "Service achat" { $row.Groupe_Service = "GRP_SC_SA" }
      "ADV" { $row.Groupe_Service = "GRP_SC_ADV" }
      "B2B" { $row.Groupe_Service = "GRP_SC_B2B" }
      "" { $row.Groupe_Service = "NA" }
      default { $row.Groupe_Service = "" }
  }
}


  # Parcourir chaque ligne de la variable $data
  foreach ($row in $data) {
    # Extraire la valeur des colonnes "Departement" et "Service"
    $departement = $row.Departement
    $service = $row.Service

    # Déterminer la valeur de "OU" basée sur "Departement"
    switch ($departement) {
        "Communication et Relations publiques" { $row.OU = "Communication-Relations-Publiques" }
        "Département Juridique" { $row.OU = "Departement-Juridique" }
        "Développement logiciel" { $row.OU = "Developpement-Logiciel" }
        "Direction" { $row.OU = "Direction" }
        "DSI" { $row.OU = "DSI" }
        "Finance et Comptabilité" { $row.OU = "Finance-Comptabilite" }
        "QHSE" { $row.OU = "QHSE" }
        "Service Commercial" { $row.OU = "Service-Commercial" }
        "Service recrutement" { $row.OU = "Recrutement" }
        "" { $row.OU = "NA" }
        default { $row.OU = "" }
    }

    # Déterminer la valeur de "SousOU" basée sur "Service"
    switch ($service) {
        "Communication interne" { $row.SousOU = "Communication-Interne" }
        "Relation Médias" { $row.SousOU = "Relations-Medias" }
        "Gestion des marques" { $row.SousOU = "Gestion-Marques" }
        "Protection des données et conformité" { $row.SousOU = "Protection-DATA" }
        "Propriété intellectuelle" { $row.SousOU = "Prop-Int" }
        "Développement" { $row.SousOU = "Developpement" }
        "Test et qualité" { $row.SousOU = "Test-Qualite" }
        "analyse et conception" { $row.SousOU = "Analyse-Conception" }
        "Recherche et Prototype" { $row.SousOU = "Recherche-Prototype" }
        "Exploitation" { $row.SousOU = "Exploitation" }
        "Administration Systèmes et Réseaux" { $row.SousOU = "Admin-Systemes-Reseaux" }
        "Support" { $row.SousOU = "Support" }
        "Développement et Intégration" { $row.SousOU = "Developpement-Integration" }
        "Service Comptabilité" { $row.SousOU = "Comptabilite" }
        "Finance" { $row.SousOU = "Finance" }
        "Fiscalité" { $row.SousOU = "Fiscalite" }
        "Contrôle Qualité" { $row.SousOU = "Controle-Qualite" }
        "Gestion environnementale" { $row.SousOU = "Gestion-Environnementale" }
        "Certification" { $row.SousOU = "Certification" }
        "Service Client" { $row.SousOU = "Service-Clients" }
        "Service achat" { $row.SousOU = "Service-Achats" }
        "ADV" { $row.SousOU = "ADV" }
        "B2B" { $row.SousOU = "B2B" }
        "" { $row.SousOU = "NA" }
        default { $row.SousOU = "" }
    }
}

# Exporter les données mis à jour dans un nouveau fichier CSV
$data | Export-Csv -Path $fichierCSV -NoTypeInformation
