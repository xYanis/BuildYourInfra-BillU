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
