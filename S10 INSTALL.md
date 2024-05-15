# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

#### 1 - Création d'un domaine Active Directory
  - Mise en place d'un serveur Windows Serveur 2022 GUI avec les rôles AD-DS, DHCP, DNS
  - Mise en place d'un serveur Windows Serveur 2022 Core avec le rôle AD-DS
  - Les deux serveurs sont des contrôleurs de domaine et ont une réplication complète gérée

#### 2 - Gestion de l'arborescence Active Directory
  - Création des unités organisationnelles (OU)
  - Création des groupes
  - Création des comptes

#### 3 - Création d'un VM Serveur Linux Debian, mise sur le domaine Active Directory et accessible en SSH

#### 4 - Création d'une VM client Ubuntu, mise sur le domaine Active Directory et ayant un accès SSH sur le serveur Linux

## 1 - Création d'un domaine Active Directory

### A - Pré-requis

Nous avons besoin de : 
- Une VM Windows Server 2022 (GUI)
  - Nom de compte : `Administrator`
  - Mot de passe : `Azerty1*`
  - Adresse IP : `172.19.5.2`

- Une VM Windows Server 2022 (Core)
  - Nom de compte : `Administrator`
  - Mot de passe : `Azerty1*`
  - Adresse IP : `172.19.5.3`

Les différentes VM seront installées sur ProxMox, à partir de templates pré-configurés

Pour l'installation d'une VM : 
 - Selectionner le template voulu dans l'arborescence située sur la gauche de l'écran
 - Faire un clic-droit desus, puis cliquer sur `Clone`
 - Dans la rubrique `VM ID`, indiquer un nombre dans la plage **540-559**
 - Dans la rubrique `Name`, indiquer un nom avec la nomenclature suivante : `G1-"Nom de la VM"`
 - Dans la rubrique `Ressource Pool`, selectionner `TSSR-2402-G1`
 - Dans la rubrique `Mode`, selectionner `Full Clone`
 - Et enfin, cliquer sur `Clone`

**ATTENTION : Les VM ainsi créées ne diposent pas nativement de cartes réseaux, nous devons l'ajouter manuellement :**
 - Selectionner la VM située sur l'arborescence à gauche de l'écran
 - Se rendre dans la rubrique Hardware
 - Cliquer sur `Add`, puis sur `Network Device`
 - Une nouvelle fenêtre apparaît
 - Dans la rubrique `Bridge`, selectionner `vmbr4`
 - Dans la rubrique `Model`, selectionner `Intel E1000`
 - Décocher la case `Firewall`
 - Et enfin, cliquer sur `Add`

![Capture d'écran 2024-05-14 155222](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/69f092bf-8f46-46f2-bbc9-cdb8a984a476)

## *Installation de la VM Windows Server 2022 (GUI)*

### *Nom et configuration IP du serveur Windows Server 2022 (GUI)*

Dans un premier temps, nous allons remplacer le nom du serveur, et lui attribuer celui de `BillU-Files`

![2024-05-14 14_41_21-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/bec4c117-c93f-403a-a82d-32d01c3c71c9)

Ensuite, nous allons lui indiquer la configuration IP suivante : 
 - IP Address : `172.19.5.2`
 - Subnet mask : `255.255.255.0`
 - Default gateway : `172.19.5.254`
 - Preferred DNS Server : `172.19.5.254`
 - Alternate DNS Server : Laisser vide

![2024-05-14 14_43_40-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a19b9313-66bc-4b3c-9fac-f26b8a64f3bb)


### *Installation des rôles sur le serveur Windows Server 2022 (GUI)*

Se rendre dans l'application `Server Manager`, puis cliquer sur `Manage`, et enfin sur `Add Roles and Features`

![2024-05-14 14_44_35-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/371b03f7-b108-43d7-9927-d7c8053a4507)

Cliquer sur Next aux rubriques `Before Yor Begin`, `Installation Type`, et `Server Selection` : 

![2024-05-14 14_44_51-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4f1e3279-7e0b-4bb3-bb85-0e440aa2fd49)

![2024-05-14 14_45_07-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/e652a0e3-b6e6-48f5-a4eb-9d9ed659f887)

![2024-05-14 14_46_45-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/5b648cf0-5066-433e-bc3e-b405ebf83e18)

A la rubrique `Server Roles`, cocher les cases `Active Directory Domain Services`, `DHCP Server`, et `DNS Server` ; Puis cliquer sur `Next`

![2024-05-14 14_47_21-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d1a2199c-d68c-4160-99ec-18dd13c4955e)

Cliquer sur Next aux rubriques `Features`, `AD DS`, `DHCP Server`, et `DNS Server` ; Puis cliquer sur `Install` à la rubrique `Confirmation`

Une fois l'installation terminée, appuyer sur `Close`

![2024-05-14 14_49_47-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/e94358e6-8c68-4d76-bffa-ed075e25e0e6)

### *Configuration de l'Active Directory*

Se rendre dans l'application `Server Manager`, puis cliquer sur le drapeau en haut de la fenêtre, et enfin sur `Promote this server to a domain controller`

![2024-05-14 14_50_10-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/37bb87e0-0e3d-4307-892b-cfa88ec6349e)

A la rubrique `Deployment Configuration`, cocher la case `Add a new forest`, et entrer ``BillU.Lan`` dans le champ `Root domaine name`

![2024-05-14 14_50_25-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/82f0ef76-f6c7-4b24-a5f4-5ee14db1f2cb)

A la rubrique `Domain Controller Options`, laisser les options par défaut, et indiquer un mot de passe dans les champs `Password` et `Confirme password` (Dans notre cas, le mot de passe sera `Azerty1*`)

![2024-05-14 14_50_56-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4a3095a0-5032-4ada-bbbc-01bae54ed7b5)

A la rubrique `Additional Options`, le champ `NetBIOS domain name` va se remplir tout seul avec le nom `BILLU`, cliquer sur `Next`

![2024-05-14 14_51_21-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/789aefc9-dd00-41a9-b461-0b6eb2532e7c)

Cliquer sur `Next` aux rubriques `Paths` et `Review Options`, puis cliquer sur `Install` à la rubrique `Prerequisites Check`

![2024-05-14 14_51_54-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a60fb813-de0f-442b-8b8d-149eda419f3c)

Une fois l'installation terminée, un message indiquera que l'ordinateur va redémarrer ; Une fois cela fait, le domaine Active Directory sera mis en place !

![2024-05-14 14_52_49-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a0af0028-5e6a-4008-a5a1-d4e4a48cc73a)


## *Installation de la VM Windows Server 2022 (Core)*

### *Nom et configuration IP du serveur Windows Server 2022 (Core)*

Comme pour l'installation de Windows Server 2022 (GUI), nous allons devoir modifier le nom et la configuration IP du serveur

Au démarrage de Windows Server 2022 (Core), nous arrivons sur cette interface : 

![2024-05-14 14_53_34-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/054a4fae-351e-499d-9211-41feced9bf45)

Nous allons selectionner l'option `8` pour afficher l'interface `Network Settings`

![2024-05-14 14_53_48-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1d53782b-c26e-4908-b981-ab5d9e2b7509)

Nous allons ensuite séléctionner l'option `1` pour paramétrer la carte réseau via l'interface Network Adpater Settings

![2024-05-14 14_54_01-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/c991277f-183c-4248-baa6-908e651e4e8d)

Nous allons de nouveau sélectionner l'option `1` pour paramétrer l'interface réseau, de la manière suivante : 
- Indiquer `S` pour définir une adresse IP fixe
- Indiquer l'adresse IP fixe suivante : `172.19.5.3`
- Indiquer le masque de sous-réseau suivant : `255.255.255.0`
- Indiquer la passerelle suivante : `172.19.5.254`

![2024-05-14 14_54_42-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1512d6aa-2d9c-4885-9c28-23e311c5db4b)

De retour l'interface `Network Adapter Settings`, nous allons maintenant seléctionner l'option `2` pour définir les DNS

![2024-05-14 14_55_03-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/22df12f5-a865-43d6-8612-055715160907)

Indiquer le DNS préféré suivant : `172.19.5.2` (*Qui correspond à l'adresse IP sur serveur Windows Server 2022 (GUI)*), et laisser vide le DNS secondaire ; Appuyer enfin sur `Entrée` pour revenir à l'interface principale

![2024-05-14 14_55_24-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/3cf4cb39-8b09-4b5c-af0c-9bd0f3a91819)

De retour au menu principal, selectionner l'option `2` pour modifier le nom du serveur

![2024-05-14 14_55_53-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/bcd983ef-a449-4588-9647-5e32fdf9b586)

Une fois arrivé sur l'interface `Computer Name`, indiquer le nouveau nom du serveur : Dans notre cas, ce sera `BillU-Files-Rec`

![2024-05-14 14_56_24-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fac6caec-5f60-424c-97ee-d075922a0a32)

Une fois cela fait, il nous sera demandé de redémarrer l'ordinateur en selectionnant l'option `Y`, ce que nous ferons bien evidemment

![2024-05-14 14_56_49-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/757c65a3-0637-434a-8596-8215449bad79)

### *Installation du rôle AD-DS sur le serveur Windows Server 2022 (Core)*

Une fois l'ordinateur redémarré, et de retour sur l'interface principale, nous allons selectionner l'option `15` afin de passer en interface de lignes de commandes (Powershell)

![2024-05-14 14_57_47-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/bbddd657-018e-4636-9e0f-a47b0432bb29)

Nous allons ensuite inscrire la ligne suivante, afin d'installer les outils d'administration graphiques : 
```powershell
Add-WindowsFeature -Name "RSAT-AD-Tools" -IncludeManagementTools -IncludeAllSubFeature
```

![2024-05-14 14_58_51-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/e053d396-f774-4c5a-9a3a-da8701b81114)

Puis nous allons inscrire la ligne suivante, afin d'installer les services de domaine Active Directory : 
```powershell
Add-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature
```

![2024-05-14 15_00_04-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/68ada4fa-76bb-4a7a-ab43-9b6a251c28ad)

Dès lors que les deux installations ont eu lieu, nous allons fermer la fenêtre pour revenir sur l'interface principale, pour selectionner l'option `1`

![2024-05-14 15_01_22-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8cb4a3e8-b632-4402-9c7f-7c9661bced9e)

Dans cette nouvelle interface, appellée `Change domaine/workgroup membership`, nous allons pouvoir joindre un nouveau domaine, en l'occurence celui configuré lors de l'installation de Windows Server 2022 (GUI) : 
- Indiquer `D` pour joindre un nouveau domaine
- Indiquer `BillU` dans le nom de domaine à joindre
- Indiquer `BillU.lan\Administrator` pour l'utilisateur qui nous permettra de joindre ce nouveau domaine
- Indiquer `Azerty1*`, qui est le mot de passe de l'administrateur du domaine `BillU.lan`

Une fois ces étapes réalisées, un message indiquera que le domaine `BillU` a été rejoint, et vous demandera de changer le nom de l'ordinateur.
Comme nous l'avons dejà fait, indiquer `N`, puis indiquer `Y` pour redémarrer l'ordinateur
La configuration de Windows Server 2022 (Core) est terminée !

![2024-05-14 15_02_26-QEMU (G1-WServer2022-Core) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/6511ee1d-5c6f-4a03-b920-9fc1f3cdd544)






































