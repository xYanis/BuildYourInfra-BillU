# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# Objectifs

## 1 - DOSSIERS PARTAGES - Mettre en place des dossiers réseaux pour les utilisateurs  

### 1.1 Stockage des données sur un volume spécifique de l'AD

Dans un premier temps, nous allons ajouter un disque dur virtuel à la VM `Windows Server`, qui sera préalablement formaté, et nommé `Stockage`

![2024-06-03 18_31_02-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/19cfa9b0-0665-4e7e-97b0-ad3d39da7e41)

### 1.2 Mappage d'un lecteur réseau "I", correspondant à un dossier individuel sécurisé et accessible uniquement par cet utilisateur

Procédons maintenant au partage du dossier nommé `Individuels`, qui correspondra au lecteur réseau utilisé par un utilisateur pour stocker ses fichiers personnels.  
  
Dans un premier temps, faire un clic-droit, puis cliquer sur `Properties` sur le dossier `Individuels`

![2024-06-03 18_32_03-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/16142eef-1687-44d5-9158-e9ff98f90d82)

Se rendre dans l'onglet `Sharing`, puis cliquer sur `Advanced Sharing ...`

![2024-06-03 18_32_24-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/7bddd7a3-46d8-487f-983b-a3f9d57b752e)

Remplacer le contenu de la case `Share Name` par `Individuels$` *(Le symbole `$` permettra de masquer ce dossier dans le cas d'une découverte du réseau)*

![2024-06-03 18_33_08-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/84b0b231-dc7a-4e36-b1bc-3512252e16d0)

Cliquer ensuite sur `Permissions`

![2024-06-03 18_33_49-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/0f1ac9a5-1505-4a2c-9a97-12c039150327)

Cliquer sur la case `Remove` afin de supprimer les utilisateurs ayant accès à ce dossier, puis appuyer sur `Add` afin d'affiner les règles de partage de ce dossier

![2024-06-03 18_33_59-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/635d3881-65de-43a4-a362-f3aa79f36fce)

Choisir uniquement `Administrator` et `Authenticated Users`, en cochant bien la case `Full Control` pour chacun d'entre-eux  

![2024-06-03 18_35_16-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/8ace21ee-863c-4d47-9ba7-bc898db06e4f)

Puis cliquer sur `Apply`, et enfin sur `OK`

![2024-06-03 18_35_47-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/be7a3b2a-efa6-4973-9184-8dd820ee8203)

Se rendre ensuite dans l'onglet `Security`, afin de configurer les droits NTFS sur le dossier, puis cliquer sur `Advanced`

![2024-06-03 18_36_11-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1356d353-8aa8-460d-927b-17294c45f4a1)

Cliquer sur `Disable Inheritance` pour désactiver l'héritage des droits sur le dossier

![2024-06-03 18_36_24-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/a004d46d-aa97-4c33-a781-185c2d003899)

Confirmer ce choix en cliquant sur `Remove all inherited permissions from this object`

![2024-06-03 18_36_43-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/deebb0fa-4053-483d-b755-f4a8b8c7b1f8)

Dès la révocation de tous les droits, nous allons ajouter les utilisateurs suivants : `CREATOR OWNER`, `SYSTEM`, `Authenticated Users`, et `Administrator`, en leur donnant à tous le `Full control` sur les dossiers, sous-dossiers, et fichiers.  

Une fois cela fait, cliquer sur `Apply`, puis sur `OK`

![2024-06-03 18_41_21-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/30b5b8cc-1818-4f7e-b8c7-0c5596834c77)

Nous allons maintenant nous rendre sur le `Server Manager`, et plus précisément dans la console `Group Policy Management`

![2024-06-03 18_42_07-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/e3a7698f-7bcc-48e7-bd20-82979334b620)

Nous allons créer une nouvelle GPO, directement dans le domaine `BillU.lan`

![2024-06-03 18_42_26-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/8b45cbc3-c10f-4e27-ab12-217b8c2e5173)

Nous allons appeller cette GPO : `GPO_InstallSharedFolder_Letter_I`

![2024-06-03 18_43_10-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ee7624bf-6569-4015-bad1-2d87d3922583)

Faire un clic-droit sur cette GPO, puis cliquer sur `Edit`

![2024-06-03 18_43_29-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/30ce6413-dc9d-41e7-8e56-a99df51d852e)

En 1er, nous allons nous rendre dans `Users Configuration` -> ` Preferences` -> `Windows Settings` -> `Drive Maps`

![2024-06-03 18_43_45-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/c941ed7b-09be-4446-be9c-8b6ebd260f79)

Faire un clic droit dans la partie droite de la fenêtre, puiss `New` -> `Mapped Drive`

![2024-06-03 18_44_00-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/d0f76341-110c-4091-9baa-2a16e2b99c62)

Entrer les informations comme indiqué ci-dessous : 
- `%LogonUser%` permet de créer un dossier partagé avec l'identifiant de l'utilisateur
- Cocher la case `Reconnect` permet de reconnecter automatiquement le lecteur en cas de déconnexion de celui-çi
- La lettre `I` sera bien celle utilisée pour mapper le lecteur réseau
- `Show this drive` / `Show all drives` permettra d'afficher le(s) lecteur(s) dans l'arborescence de fichiers

![2024-06-03 18_45_28-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/cf50f489-390c-4ec5-ade6-5605061b6935)

Ne pas oublier de se rendre dans l'onglet `Common`, et de cocher la case `Run in logged-on user's security context (user policy option)`  
Cela permettra de créer le dossier partagé uniquement en cas de 1ère connexion de l'utilisateur

![2024-06-03 18_46_42-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/0b506f37-ee60-4388-9ccc-594bf019d762)

Faire de même avec la catégorie `Folders`  
Clic-droit, puis `New` -> `Folder`

![2024-06-03 18_46_05-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/43cf4486-c686-4df2-a4a7-281fe3943811)

Entrer les informations comme indiqué ci-dessous :

![2024-06-03 18_47_41-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/7160d98f-c715-4ce6-aefb-edd99022ba8e)

Comme précédemment : Ne pas oublier de se rendre dans l'onglet `Common`, et de cocher la case `Run in logged-on user's security context (user policy option)`  

![2024-06-03 18_47_51-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/d65007dd-15fb-4944-9be5-ad458d348c30)

![2024-06-03 18_48_08-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/f5101a66-1ff4-4644-8b74-876db7401254)

Et enfin, faire de même avec la catégorie `Shortcuts`  
Clic-droit, puis `New` -> `Shortcut`

![2024-06-03 18_48_19-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/53c0f1c0-2e99-49c5-84f4-637e3dd283be)

- Name : `Mes Fichiers Personnels`
- Location : `Desktop`
- Nous avons personnalisé l'icône du raccourci du bureau
- Comme précédemment, nous avons coché la case `Run in logged-on user's security context (user policy option)` dans l'onglet `Common`
- Cliquer sur `Apply`, puis sur `OK`

![2024-06-03 18_49_26-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ee1625c7-d2dd-46bc-9fce-791f57eae24e)

![2024-06-03 18_50_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/c6c14a15-7f7f-44a7-bf78-7fa31db2b22a)

![2024-06-03 18_50_50-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/2ffdbca8-a824-439a-9c49-7c705eaec61a)

![2024-06-03 18_51_04-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/e2b01427-c704-4107-b0c8-852dbc30627a)

Nous allons ensuite exécuter la commande `gpupdate /force` dans une invite de commande pour forcer l'application de la nouvelle GPO

![2024-06-03 18_52_27-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/5e13ef8b-5058-47c9-a85c-075b97b3c6cc)

Maintenant que la GPO a été appliquée, nous allons la tester en nous connectant avec un utilisateur de l'AD, sur une machine client  
Ici, ce sera l'utilisateur `Aurélien Brunet`

Nous nous aperçevons que le raccourci du dossier partagé apparaît bien comme prévu sur le bureau de cet utilisateur

![2024-06-03 18_59_07-QEMU (G1-WIN10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/a9d3a5a0-3ca9-4c3f-8306-e15e858431c8)

Nous allons créer un fichier dans ce dossier

![2024-06-03 19_00_57-QEMU (G1-WIN10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/3cd50e6d-34b7-45ed-90cb-3621150bf83d)

La fichier est également présent sur le dossier du serveur avec le bon chemin : `E:\Individuels\<ID_Utilisateur>\`

![2024-06-03 19_01_34-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/392052f9-d0c6-484c-8da6-d78a5e4d7205)

**La GPO mise en place fonctionne correctement !**


## 2 - SAUVEGARDE

## 2.1 Sauvegarde sur un volume spécifique 

Nous avons rajouté un volume spécifique de 10 GB pour prendre en charge la sauvegarde


![2024-06-06_15_00_15-wcs-cyber-node05_-_Proxmox_Virtual_Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/acbc0515-1449-4c00-bb75-2dbc793a8e78)


Nous allons ensuite ajouter le rôle `Windows Server Backup` dans le **SERVER MANAGER**

![2024-06-06 15_03_16-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1fa10dd8-b1c5-4b17-8b72-7afbb5798793)




![2024-06-06 15_03_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/97f26073-86ae-4b58-8bce-da4d8e48293e)


Une fois l'installation fini nous allons nous rendre sur le `Computer Management` pour initialiser le disque


![2024-06-06 15_04_59-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/47bafb2e-0f56-44dc-bf7f-5418f6a2f8aa)





![2024-06-06 15_05_09-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/22101a0a-d4de-4551-8148-db483f86c84c)



![2024-06-06 15_06_04-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/d72ba985-f9c2-4f75-a82e-92b64d684e0e)



![2024-06-06 15_06_25-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/f8b0c9d0-07e5-415e-bd2c-3ebc0b6ed103)




![2024-06-06 15_06_40-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/8f75b57b-24be-4fa1-b2e3-d222f843c5b0)


Nous pouvons  maintenant constater que le volume est bien au format attendu


![2024-06-06 15_07_44-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/fa9ae358-0e8c-4968-80ab-b5ebc2a5c88b)


Nous allons maintenant nous rendre sur le `Windows Server Backup`

![2024-06-06 15_08_06-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/39e85641-49af-45ec-bfd0-c377872ba1c1)


Nous allons programmer les horaires pour les sauvegardes en nous rendant `Backup Shedule Wizard` 


![2024-06-06 15_09_07-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ef272449-2dc5-4114-aa3e-fbae4170f211)


On séléctionne `Custom` pour configurer manuellement la configuration la sauvegarde


![2024-06-06 15_09_22-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/6bb6115e-05e3-4a27-a9f7-bffa99400f0f)


On séléctionne ensuite les fichiers concernés par la sauvegarde


![2024-06-06 15_09_52-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/3cb3ac1e-76d3-4e43-840c-df3e268aa868)


On définit l'heure dans la journée pour faire la sauvergarde.


![2024-06-06 15_11_18-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/f1761385-a520-4c97-9d02-073d11b2d570)


On va définir la destination pour la sauvegarde et en suivant les captures d'écran ci dessous le volume sera bien configuré.


![2024-06-06 15_12_28-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1bbd2938-fdc7-42c7-9bb9-61d9248bd504)



![2024-06-06 15_12_57-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/c11d1092-5e50-4531-839e-bfacc80017b7)




![2024-06-06 15_13_09-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1441b045-690e-4761-8420-a5d020236e03)




![2024-06-06 15_13_21-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ff753861-62ee-43b1-9333-841cebda9aa2)




![2024-06-06 15_13_35-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/7408bd8f-a317-4951-af44-101b9885a909)

































## 3 - MOT DE PASSE ADMINISTRATEUR LOCAL - Mise en place de LAPS

### 1 - Configuration de Windows LAPS

Tout d'abord, ouvrir une invite de commandes en `Mode Administrateur` afin d'éxécuter une commande pour lister l'ensemble des commandes disponibles pour LAPS, et de vérifier que ce dernier est bien accessible depuis votre serveur : 
```powershell
Get-Command -Module LAPS
```

![2024-06-06 15_34_01-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/9850cea6-d3b4-4407-b7bf-4ae3266c4e00)

Exécuter ensuite les deux commandes suivantes : 
```powershell
Import-Module LAPS
Update-LapsADSSchema -Verbose
```

*La 1ère commande sert à importer le module LAPS*  
*La 2eme commande sert à mettre à jour le schéma de l'Active Directory*

Vérifier ensuite dans les `Properties` d'un poste sur l'Active Directory que les lignes `mSLAPS- ...` sont bien présentes

![2024-06-06 17_46_51-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/32f4eb43-ef0b-4b57-97f4-e8c96dc841fd)

### 2 - Attribution des droits d'écriture aux postes

Quand un poste va effectuer une rotation du mot de passe du compte `Admnistrateur local`, il va devoir sauvegarder ce nouveau mot de passe dans l'Active Directory.  
Nous allons donc éxécuter la commande ci-dessous pour donner cette autorisation aux postes situés dans l'OU `BillU-Computers` : 

```powershell
Set-LapsADComputerSelfPermission -Identity "OU=BillU-Computers,DC=BillU,DC=lan"
```

![2024-06-06 17_57_34-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/c2d7d76e-1510-4539-928b-0ccef03b37cb)

### 3 - Configuration de la GPO Windows LAPS

Nous devons créer une GPO pour définir la politique de mots de passe à appliquer sur le compte `Administrateur` géré, nous lui donnerons le nom de `Security_WindowsLAPS_Config`

Puis l'éditer en se rendant dans `Computer Configuration` > `Administrative Templates : Policy definitions ...` > `System` > `LAPS`

Double-cliquer sur `Configure password backup directory`, puis cocher l'option `Enabled`

![2024-06-06 18_12_54-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/bb778bfe-16b6-4fe1-a926-630e5dedafd4)

Double-cliquer sur `Password Settings`, puis cocher l'option `Enabled`, et en indiquant les mêmes paramètres que l'image ci-dessous : 

![2024-06-06 18_20_32-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/65d44a26-9939-4705-b7ad-b696472dffce)


Double-cliquer sur `Configure size of encrypted password history`, puis cocher l'option `Enabled`, et en indiquant les mêmes paramètres que l'image ci-dessous : 
*(Cette dernière option est facultative, mais nécéssaire en cas de compromission de la mise à jour de l'Active Directory, afin de pouvoir accéder au mot de passe précédent)*

![2024-06-06 18_22_09-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1e439445-2539-4504-9318-c4ccb9e7a7f7)

Double-cliquer sur `Enable password encryption`, puis cocher l'option `Enabled`

![2024-06-06 18_25_52-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/ed884736-1d2b-486b-8a21-5fd5d4dd690d)

Une dernière étape est à réaliser pour activer les administrateux locaux : 

![2024-06-06 18_55_10-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d87aeafd-90cb-45a8-a12a-965e319fcc80)

La stratégie de groupe est prête : 

![2024-06-06 18_27_53-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/2766e8ea-6e30-4911-9800-1f3cb95726ee)

Ne pas oublier de lier la GPO à L'OU contenant les ordinateurs de l'AD : 

![2024-06-06 18_29_09-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1c951b55-10d5-43b4-8db9-d80004a853d8)


Pour tester cette GPO, nous nous rendons sur un ordinateur contenu dans l'AD, nous éxécutons la commande suivante pour forcer la mise à jours des GPO
```
gpupdate /force
```

Nous redémarrons ensuite cet ordinateur.  

Puis nous retournons sur le serveur afin de confirmer l'action de la GPO : 
 - Soit par l'Active Directory
 - Soit en éxécutant la commande suivante sous PowerShell :
```powershell
Get-LapsADPassword "<Nom_PC> -AsPlainText
```

![2024-06-06 18_40_02-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/2045578b-925a-450e-bc92-d07a46f96e38)



## 5. DÉPLACEMENT DES MACHINES DANS L'AD - Automatisation du placement dans la bonne OU
  
### Création d'une tache planifiée
![Capture d'écran 2024-06-06 141148](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/6c5976ab-006c-4822-8729-36091c8a0b8a)
Ouvrir le planificateur de tache et cliquez sur 'Create Task...'

![Capture d'écran 2024-06-06 141322](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/f7d8208a-197d-476a-8719-1be861c848f6)
Ajoutez un nom et une description , selectionnez 'Run whether user is logged on or not','Run with highest privileges et la version du serveur.
Ensuite allez sur l'onglet Triggers

![Capture d'écran 2024-06-06 141423](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/96504b6f-3240-4151-ae32-45d4ea1caebc)
Dans notre cas , on selectionne une tache journalière.

![Capture d'écran 2024-06-06 141525](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/8522955a-cd0a-43ef-9622-548042a15402)
Qui executera un script tous les jours à minuit, pour verifier des modifications à notre fichier CSV et le cas échéant lancer un autre script pour appliquer ces modifications.

La tache planifiée est créée sous forme de fichier XML dans Windows\System32\Tasks.



