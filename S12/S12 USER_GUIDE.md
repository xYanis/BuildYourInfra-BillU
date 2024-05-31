## Script GPO télémétrie

# Fonctionnement du script

Le script se compose en quatres parties : 

1 Désactivation des fonctionnalités de la télémetrie Windows avec les clés de registre 

![2024-05-31 11_40_05-Clone de Template Windows 10 Neutre  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/07e45525-4a30-4d78-bb5a-588a6bc8541f)


2 Désactiver les services de tracking et autres services inutiles

![2024-05-31 11_41_20-Clone de Template Windows 10 Neutre  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1b42687a-dd43-48ea-b4e9-cc7a636b4ecd)


3 Désactiver OneDrive et Désinstaller Cortana



![2024-05-31 11_42_11-Clone de Template Windows 10 Neutre  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/60dc9695-f12b-4334-9f96-2db9a6e8710a)


4 Définir les noms de packages à supprimer avec DISM

Pour obtenir la liste des packages provisionnés en ligne avec DISM
DISM.exe /Online /Get-ProvisionedAppxPackages

Pour les supprimer 
DISM.exe /Online /Remove-ProvisionedAppxPackage /Package-Name:NomPkg

Désinstaller un package d'application pour tous les utilisateurs
Get-AppxPackage -AllUsers -Name Editeur.NomDePackage | Remove-AppxPackage


![2024-05-31 11_43_55-Clone de Template Windows 10 Neutre  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/91c3c466-f694-4d17-99f2-e477a6f05d5f)
