# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# Objectifs

## 1 - DOSSIERS PARTAGES - Mettre en place des dossiers réseaux pour les utilisateurs  

### 1.1 Stockage des données sur un volume spécifique de l'AD

Dans un premier temps, nous allons ajouter un disque dur virtuel à la VM Windows Server, qui sera préalablement formatté, et nommé "Stockage"

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
- Comme précédemment, nous avons cocheé la case `Run in logged-on user's security context (user policy option)` dans l'onglet `Common`
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

La fichier est également présent sur le dossier du serveur avec le bon chemin : `E:\Individuels\<ID_Utilisateur>`

![2024-06-03 19_01_34-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/392052f9-d0c6-484c-8da6-d78a5e4d7205)

La GPO mise en place fonctionne correctement !
















