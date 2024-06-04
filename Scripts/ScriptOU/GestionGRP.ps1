#                   #
# The Master Script #
#                   #


#Installez le module ImportExcel s'il n'est pas déjà installé
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
  Install-Module -Name ImportExcel -Force
}

#Spécifiez le chemin du fichier Excel d'entrée et du fichier CSV de sortie
$excelFilePath = "C:\Projet_3\s09_BillU.xlsx"
$csvFilePath = "C:\Projet_3\CSVtest.csv"

$fichierCSV = "C:\Projet_3\CSV_Master.csv"


#Importez les données du fichier Excel
$data = Import-Excel -Path $excelFilePath

#Filtrez les lignes où la colonne "société" contient "billu"
$filteredData = $data | Where-Object { $_.Societe -match "BillU" }

#Exportez les données filtrées en CSV
$filteredData | Export-Csv -Path $csvFilePath -NoTypeInformation

# Importer les données CSV dans une variable PowerShell
$data = Import-Csv -Path $csvFilePath

# Ajouter une nouvelle colonne "Groupe_Departement" à la variable $data
$data | Add-Member -MemberType NoteProperty -Name 'Groupe_Departement' -Value ''

# Ajouter une nouvelle colonne "Groupe_Service" à la variable $data
$data | Add-Member -MemberType NoteProperty -Name 'Groupe_Service' -Value ''

# Parcourir chaque ligne de la variable $data
foreach ($row in $data) {
    # Extraire la valeur de la colonne "Departement"
    $departement = $row.Departement
    $service = $row.Service
    
    if ($departement -eq "Communication et Relations publiques")
    {
    $groupeDepartement = "GRP_CRP"
    $row.Groupe_Departement = $groupeDepartement
      }

    if ($departement -eq "Département Juridique")
    {
    $groupeDepartement = "GRP_DJ"
    $row.Groupe_Departement = $groupeDepartement
     }

    if ($departement -eq "Développement logiciel")
    {
    $groupeDepartement = "GRP_DEVL"
    $row.Groupe_Departement = $groupeDepartement
     }            

     if ($departement -eq "Direction")
     {
     $groupeDepartement = "GRP_DIR"
     $row.Groupe_Departement = $groupeDepartement
       }

    if ($departement -eq "DSI")
    {
    $groupeDepartement = "GRP_DSI"
    $row.Groupe_Departement = $groupeDepartement
     }

     if ($departement -eq "Finance et Comptabilité")
     {
     $groupeDepartement = "GRP_FC"
     $row.Groupe_Departement = $groupeDepartement
       }

    if ($departement -eq "QHSE")
    {
    $groupeDepartement = "GRP_QHSE"
    $row.Groupe_Departement = $groupeDepartement
     }

    if ($departement -eq "Service Commercial")
    {
    $groupeDepartement = "GRP_SC"
    $row.Groupe_Departement = $groupeDepartement
      }

    if ($departement -eq "Service recrutement")
    {
    $groupeDepartement = "GRP_RECR"
    $row.Groupe_Departement = $groupeDepartement
     }

# Ajouter une valeur à la nouvelle colonne "Groupe_Service"
  #$row.Groupe_Service = "Valeur_exemple"

    if ($service -eq "Communication interne")
    {
    $groupeservice = "GRP_CRP_CI"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Relation Medias")
    {
    $groupeservice = "GRP_CRP_RM"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Gestion des marques")
    {
    $groupeservice = "GRP_CRP_GM"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Protection des données et conformité")
    {
    $groupeservice = "GRP_DJ_DATA"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Propriété intellectuelle")
    {
    $groupeservice = "GRP_DJ_PI"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Développement")
    {
    $groupeservice = "GRP_DEVL_DEV"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Test et qualité")
    {
    $groupeservice = "GRP_DEVL_TQ"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "analyse et conception")
    {
    $groupeservice = "GRP_DEVL_AC"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Recherche et Prototype")
    {
    $groupeservice = "GRP_DEVL_RP"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Exploitation")
    {
    $groupeservice = "GRP_DSI_EXP"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Administration Systèmes et Réseaux")
    {
    $groupeservice = "GRP_DSI_ADMIN"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Support")
    {
    $groupeservice = "GRP_DSI_SUP"
    $row.Groupe_Service = $groupeservice
    }     

    if ($service -eq "Developpement et Intégration")
    {
    $groupeservice = "GRP_DSI_DI"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Service Comptabilité")
    {
    $groupeservice = "GRP_FC_COM"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Finance")
    {
    $groupeservice = "GRP_FC_FIN"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Fiscalite")
    {
    $groupeservice = "GRP_FC_FIS"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Contrôle Qualité")
    {
    $groupeservice = "GRP_QHSE_CQ"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Gestion environnementale")
    {
    $groupeservice = "GRP_QHSE_GE"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Certification")
    {
    $groupeservice = "GRP_QHSE_SER"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Service Client")
    {
    $groupeservice = "GRP_SC_SCL"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "Service achat")
    {
    $groupeservice = "GRP_SC_SA"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "ADV")
    {
    $groupeservice = "GRP_SC_ADV"
    $row.Groupe_Service = $groupeservice
    }

    if ($service -eq "B2B")
    {
    $groupeservice = "GRP_SC_B2B"
    $row.Groupe_Service = $groupeservice
    }


    
    
}

# Exporter les données mis à jour dans un nouveau fichier CSV
$data | Export-Csv -Path $fichierCSV -NoTypeInformation
