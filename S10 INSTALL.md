# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

#### 1 - Création d'un domaine Active Directory
  - Mise en place d'un serveur Windows Serveur 2022 GUI avec les rôle AD-DS, DHCP, DNS
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

