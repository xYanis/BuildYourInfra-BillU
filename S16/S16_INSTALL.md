# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# Sommaire 

### 1 - AD - Rôles FSMO
### 2 - SÉCURITÉ - Mettre en place un serveur de gestion des mises à jour **WSUS**
### 3 - PARTENARIAT D'ENTREPRISE - VPN site-à-site
### 4 - PARTENARIAT D'ENTREPRISE - FIREWALL
### 5 - PARTENARIAT D'ENTREPRISE - Active Directory
### 6 - PARTENARIAT D'ENTREPRISE - SUPERVISION
### 7 - PARTENARIAT D'ENTREPRISE - STOCKAGE
### 8 - PARTENARIAT D'ENTREPRISE - GUACAMOLE


🚩
> **A partir de ce sprint, l'entreprise BillU est dorénavant liée à l'entreprise EcoTech Solutions**  
> **Ce partenariat aura pour objectif de renforcer la présence de ces deux entreprises à un niveau international encore jamais imaginé !**  
> **Les nouveaux objectifs seront désormais adaptés à cette nouvelle infrastructure**

## 1 - AD - Rôles FSMO

Objectifs : 
- Installation d'un nouveau serveur Windows Server Core `BILLU-CORE-TWO` en `172.19.0.5/24`
- Installation des rôles **ADDS**
- Transfert des rôles **FSMO**
  
Sur le serveur principal ( GUI ) 

Ouvrir une console CMD en admin puis taper `ntdsutil.exe` , la liste des commandes se consulte en tapant `?`

Taper `role` pour rentrer en mode de maintenance FSMO, ensuite `Connections` et `connect to server BILLU-CORE-TWO`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-26-39%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

`q` pour revenir au menu précédent et `transfer RID master`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-40-06%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cliquer sur `Yes`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-40-16%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Retourner dans le mode de connection avec `Connections` puis `connecto to server BILLU-FILES-REC`

`q` puis `transfer schema master`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-41-50%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-41-56%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Pour vérifier lancer un CMD et la commande suivante `NETDOM QUERY /Domain:BillU.lan FSMO`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2010-43-31%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

### 2 - SÉCURITÉ - Mettre en place un serveur de gestion des mises à jour **WSUS**

### Installation du rôle WSUS

L’installation du rôle WSUS sur Windows Server 2022, ou une autre version, s’effectue de façon classique c’est-à-dire à partir du Gestionnaire de serveur. Une configuration initiale est nécessaire dans la continuité de l’installation du rôle.

Avant de démarrer l’installation, intégrez le serveur WSUS au domaine Active Directory.

Ouvrez le « Gestionnaire de serveur », cliquez sur « Gérer » puis « Ajouter des rôles et fonctionnalités ».

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-19-23%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Passez le premier écran, et comme « Type d’installation », prenez la première option. Poursuivez.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-19-36%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Selectionnez le serveur sur lequel vous voulez installer le rôle WSUS, ici le serveur BILLU-FILES.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-19-56%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Concernant l’étape « Rôles de serveurs », choisissez « Windows Server Update Services » tout en bas de la liste. L’assistant vous demande si vous souhaitez installer les dépendances, notamment les outils d’administration afin d’avoir la console de gestion, ainsi que le serveur web IIS qui est indispensable au bon fonctionnement de WSUS. Cliquez sur « Ajouter des fonctionnalités » pour valider.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-20-27%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

À l’étape suivante, cliquez tout simplement sur « Suivant ».

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-21-43%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cochez les cases « WID Connectivity » et « WSUS Services », tout en sachant qu’il y a deux possibilités pour la base de données WSUS.

En effet, il y a l’option par défaut « WID Connectivity », où WID correspond à « Windows Internal Database », une alternative à SQL Server Express qui est intégrée à Windows. Dans une très grande majorité des cas, la base WID est utilisée. C’est le choix que je vous propose de faire dès à présent.

A titre d'information, sachez que la seconde option, nommée « SQL Server Connectivity » permet d’utiliser une instance SQL Server ou SQL Server Express pour la base de données WSUS. Je vous rappelle que SQL Server est payant, tandis que SQL Server Express est gratuit, mais limité (par exemple, la taille de la base de données ne peut pas dépasser 10 Go).

Il peut s’avérer judicieux d’utiliser la connectivité SQL Server si vous avez de nombreuses versions différentes de Windows desktop dans votre parc informatique (par exemple, Windows 11, Windows 10 et Windows 7) et un très grand nombre de machines à gérer.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-22-12%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Indiquez l’emplacement des données WSUS, notamment les fichiers de mises à jour. Je vous recommande d’utiliser un volume dédié sur votre serveur, plutôt que le disque « C ». Par exemple, le volume « W: » au sein du dossier « WSUS », tout en sachant qu’un dossier « WsusContent » sera créé.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-23-57%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

L’assistant nous informe qu’un serveur Web « IIS » va être mis en place sur notre serveur. C’est un prérequis, car WSUS s’appuie sur un site et des connexions HTTP/HTTPS pour distribuer les mises à jour aux clients. Cliquez sur « Suivant ».

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-24-05%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cliquez sur « Suivant », il n’y a pas de modifications à apporter.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-24-14%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cliquez sur « Installer » pour démarrer l’installation de WSUS et des fonctionnalités associées.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-24-19%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-24-33%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

En temps normal, l’installation ne prend que quelques minutes, mais elle ne s’arrête pas là. Au sein du « Gestionnaire de serveur », nous pouvons remarquer un avertissement en haut à droite : il faut démarrer les tâches de post-installation de WSUS en cliquant sur le lien.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-25%20at%2011-29-31%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

### Configuration de base de WSUS

WSUS est installé sur notre serveur et la base de données est créée, que ce soit via WID ou SQL Server. Désormais, nous pouvons lancer la console « Services WSUS » afin d’effectuer la configuration de base.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-48-15%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cliquez sur « Suivant » / « Next » pour commencer.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-53-37%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Si vous souhaitez participer du programme d’amélioration de Microsoft Update, cochez l’option, sinon décochez cette option. Poursuivez.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-53-50%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Sur quelle source notre serveur WSUS doit-il s’appuyer pour se synchroniser et obtenir les nouvelles mises à jour ? Deux options : à partir des serveurs de Microsoft Update (Synchronize from Microsoft Update) ou à partir d’un autre serveur WSUS (Synchronize from another Windows Server Update Services server).

La seconde option est nécessaire dans le cas d’une architecture multisite avec un serveur WSUS maître et des serveurs WSUS secondaires, ici nous allons choisir Microsoft Update.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-53-58%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Si vous utilisez un proxy pour accéder à Internet et qu’il doit être déclaré, c’est le moment. Sinon, poursuivez sans cocher l’option.

Note : les communications avec les serveurs de Microsoft Update s’effectuent en HTTPS avec le port 443. Veillez à autoriser ce flux au sein de votre réseau.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-54-05%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Cliquez sur « Démarrer la connexion » / « Start Connecting » pour que notre serveur WSUS se connecte sur les serveurs Microsoft Update. Cela va lui permettre de récupérer la liste des systèmes d’exploitation et logiciels pris en charge, les types de mises à jour, et les langages disponibles. Cette opération est assez longue… Je dirais même que vous avez le temps de prendre un café.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2009-54-11%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Une fois l’étape précédente terminée, la barre de progression sera pleine et le bouton « Suivant » / « Next » sera accessible.

La prochaine étape consiste à choisir les langues de mises à jour. Si vous utilisez seulement des systèmes d’exploitation en français pour vos postes de travail et vos serveurs, vous pouvez choisir « Français » (ou « French »).

Si vous utilisez Windows en FR sur les postes de travail et en version EN pour les serveurs, choisissez également « Anglais » (ou « English »).

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2010-06-49%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Poursuivez une fois votre choix effectué, tout en sachant que vous pouvez le modifier à tout moment.

Nous devons sélectionner les produits pour lesquels nous souhaitons synchroniser les mises à jour. La liste est très longue et très complète (Exchange, Office, Edge, SQL Server, etc…), vous devez cocher les produits correspondants à ceux que vous utilisez !

Remarque : plus vous sélectionnez de produits, plus votre serveur WSUS aura des données à stocker.

Pour Windows Server 2019 et supérieur, il suffit de cocher « Windows Server 2019 ». Il y a également des catégories de produits correspondantes aux pilotes et aux packs de langues.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2010-12-01%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Pour Windows 10, sélectionnez « Windows 10, version 1903 and later » pour synchroniser toutes les mises à jour Windows 10 à partir de cette version. Autrement dit, pour Windows 10 21H2, il faut sélectionner cette catégorie : probablement, car ces versions sont très proches.

Cette sélection est modifiable à tout moment. Par exemple, si vous intégrez vos premières machines Windows 11 à votre parc informatique, vous pouvez modifier la configuration WSUS pour inclure les mises à jour Windows 11. En ce qui me concerne, je sélectionne « Windows 11 », car mon « PC-01 » est sous cette version de Windows.

Pour plus d’informations sur les différentes catégories, je vous recommande la lecture de cet article : https://www.it-connect.fr/wsus-classifications-quels-produits-windows-10-choisir/

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-28%20at%2010-12-32%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

L’étape suivante concerne la classification des mises à jour, c’est-à-dire les types de mises à jour qu’il faut synchroniser sur le serveur WSUS. Les catégories « Mises à jour critique », « Mise à jour de la sécurité » et « Mise à jour » permettent d’obtenir les mises à jour mensuelles publiées par Microsoft, tandis que la catégorie « Mises à jour de définitions » correspond aux mises à jour Windows Defender.

Dans un environnement où il y a la volonté de distribuer les mises à niveau de Windows via WSUS, il sera nécessaire de cocher l’option « Upgrades ».




## 3 - PARTENARIAT D'ENTREPRISE - VPN site-à-site 

Afin d'initialiser cette fusion d'entreprise, il est indispensable de procéder à une liaison par VPN entre les deux infrastructures déjà existantes.

### Préparation de la VM Debian 12
Pré-requis pour la VM Debian 12 : 
- Disque dur : `25 Go` sur le stockage `ceph-datas`
- Cores : `2`
- RAM : `2 Go`
- Carte réseau : `vmbr5 (DMZ BillU)`
- IP : Statique -> `172.19.11.2/24`
- Gateway : `172.19.11.254` *(Interface DMZ du parefeu)*
- DNS : `billu.lan` *(Domain)* / `172.19.0.2` *(IP du serveur DNS)*

![2024-06-24 14_46_16-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4b32d335-86a8-4167-a9a7-480c4da35b05)

![2024-06-24 14_46_49-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/adffa54b-e8ba-4a5d-8b53-849807b57317)

![2024-06-24 14_47_06-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/bd347588-4608-4ed1-a24a-968acb157f19)

![2024-06-24 14_47_20-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4a66a6bf-ed4d-4640-9b5b-8c508ce52d7b)

![2024-06-24 14_47_36-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8447b34e-d6b9-4995-9399-62b6201578d1)

![2024-06-24 14_48_15-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/f5721595-0adf-45df-b4bc-a108e40a4e0e)

![2024-06-24 14_48_35-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d6fae5d1-9042-4558-acf5-e2a29f8dcd6d)


### Configuration post-installation

Dans un premier temps, nous devons effectuer les mises à jour de l'OS avec la commande suivante : 
```bash
apt update && apt upgrade
```

Ensuite, il faut éditer le fichier `/etc/network/interfaces` afin de configurer correctement notre adresse IP :

![2024-06-24 22_15_18-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8cbb6ee5-1b60-430e-8b3f-2461bafd196d)

Ensuite, il faut éditer le fichier `/etc/hosts` afin de corriger l'adresse IP de notre serveur ; Dans notre cas, ce sera `172.19.11.2` :

![2024-06-24 22_23_12-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/332dd3fd-b6e0-46a4-9cce-d8e7af74c689)

Ensuite, il faut éditer le fichier `/etc/hosts` afin de corriger le nom de notre serveur ; Dans notre cas, ce sera `BillU-VPN` :

![2024-06-24 22_25_40-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/88423aed-105a-42c7-bbe3-1ace6188bb4b)

Ensuite, il faut éditer le fichier `/etc/resolv.conf` afin de corriger notre DNS ; Dans notre cas, nous ajouterons les lignes suivantes : 
```bash
nameserver 172.19.0.2
search billu.lan
```

![2024-06-24 22_16_42-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/81e0c354-8432-4ab7-902d-a420d8fce81c)

Tester le ping vers le domaine :
```bash
ping billu.lan
```

![2024-06-24 21_32_17-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fe58ba7d-2a41-40b2-a857-e207eaf07df0)

Installer les paquet nécéssaires à l'ajout de la VM au domaine : 
```bash
apt-get install realmd sssd-tools sssd libnss-sss libpam-sss adcli samba-common
```

Dès l'installation terminée, entrer la commande suivante pour ajouter la VM au domaine, et entrer le mot de passe `Azerty1*` quand il vous sera demandé : 
```bash
realm join billu.lan --user Administrator
```

:warning: **Il est possible que la commande précédente ne fonctionne pas ; Dans ce cas, éxécuter la commande suivante :** 
```bash
realm --install=/ join billu.lan --user Administrator
```

Vérifier avec la commande suivante que le serveur est bien situé sur le domaine : 
```bash
realm list
```

![2024-06-24 21_32_45-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/06dfb681-50b7-462e-bf06-e0d18e45065b)

### Installation d'OpenVPN

Afin de simplifier l'installation d'OpenVPN, nous utiliserons un script qui nous guidera à traver toutes les étapes de l'installation.  
Avant toute chose, nous devons installer l'utilitaire `curl`, qui nous permettra de télécharger le script, avec la commande suivante : 
```bash
apt install curl
```

Ensuite, nous téléchargeons le script directement depuis un dépôt GitHub : 
```bash
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
```

Ensuite, nous allons donner les droits à l'éxécution du script : 
```bash
chmod +x openvpn-install.sh
```

Puis, nous éxécutons le script : 
```bash
./openvpn-install.sh
```

Lors de l'éxécution du script, nous devrons entrer les infirmations suivantes afin de configurer l'installation OpenVPN : 
- `IP address` : `172.19.11.2`
- `Public IP address or hostname` : `10.0.0.2` (Adresse WAN du pare-feu)
- `Do you want to enable IPv6 support (NAT) ?` : `n`
- `Port choice` : `1`
- `Protocol` : `1`
- `DNS` : `1`
- `Enable compression` : `n`
- `Client name` : `ECO-Cooper` *(Nom du serveur OpenVPN de l'entreprise EcoTech Solutions)*
- `Select a option` : `1 (Add a passwordless client)`

![2024-06-24 16_00_59-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/58b7e672-63d4-4ac8-8a0e-5e95f9e647f6)

![2024-06-24 16_02_31-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/5f0fc855-a32f-4abc-8026-f7a822661757)

![2024-06-24 16_14_39-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/953721c9-402b-469b-a71e-e52c6e43d5a4)


### Copie du fichier sur les postes distants

> Comme indiqué à la fin de l'installation, nous devons télécharger le fichier `.ovpn` sur le poste distant.  

#### 1ère etape : Installation des utilitaires nécéssaires sur le serveur OpenVPN

Installation de [XORG](https://doc.ubuntu-fr.org/xorg) : 
```bash
apt install xorg
```

![2024-06-26 11_00_13-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a401da15-dd2a-45bd-b703-0989fabd4b9f)

Installation de [Gedit](https://doc.ubuntu-fr.org/gedit) : 
```bash
apt install gedit
```

![2024-06-26 11_09_12-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/93f8333e-7b45-4b2e-a6ec-044a00e24f8c)


Installation de [GTK](https://www.gtk.org/) : 

```bash
apt install libcanberra-gtk-module libcanberra-gtk3-module
```

![2024-06-26 11_31_09-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fd984b3b-3e6c-48f9-868b-da29ef5e0b80)


Edition du fichier `/etc/ssh/sshd_config`, pour ajouter la ligne `X11Forwarding yes` *(Même si elle devrait dejà être présente)*

![2024-06-26 11_04_45-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/0f65524f-47d2-4d08-b705-33831355cf78)


Redémarrage su service `SSH` : 

```bash
systemctl restart sshd
```

![2024-06-26 11_05_32-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/b6bd635d-a20e-463d-aa6b-e267ba795fbc)

Pour l'étape suivante, nous aurons besoin de copier le fichier `.ovpn` dans le dossier personnel de l'utilisateur `wilder` : 

```bash
cp <nom_du_fichier>.ovpn /home/wilder
```

![2024-06-26 11_08_00-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/c4070c13-a96b-47be-bf66-be6fc0c494fa)

> Les commandes éxécutées ci-dessus permettront d'utiliser le protocole X11 Forwarding sur le poste client.

#### 2ème etape : Installation de [Gedit](https://doc.ubuntu-fr.org/gedit) sur un poste client Ubuntu, et création d'une copie du fichier `.ovpn` original

> Dans cette section, nous allons devoir copier le contenu du fichier `.ovpn` disponible sur le serveur OpenVPN, afin de pouvoir le diffuser sur d'autres postes. 

Installation de [Gedit](https://doc.ubuntu-fr.org/gedit) : 

```bash
sudo apt install gedit
```

![2024-06-26 11_38_25-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/effd858a-9771-4562-8d11-7ac81d4b899b)

Connexion en `SSH X11` sur le serveur OpenVPN : 
```bash
ssh -X wilder@<addresseIPServeur>
```

![2024-06-26 11_06_34-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/2bd7c151-eee6-49ff-9831-48d09db35eda)

Ouverture du fichier `.ovpn` via l'outil [Gedit](https://doc.ubuntu-fr.org/gedit), installé sur le serveur OpenVPN : 

```bash
gedit <nom_du_fichier>.ovpn
```

![2024-06-26 11_33_41-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/ae6b735d-d6de-4ff8-8c60-92e7c1655fdd)

Copie du contenu du fichier : 

![2024-06-26 11_37_31-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/14da2b67-b94a-42a7-971f-c21f773cb3c0)

Fermeture de la connexion `SSH X11` (dans le terminal) : 

```bash
exit
```

Exécution de [Gedit](https://doc.ubuntu-fr.org/gedit) dans le terminal (Cette fois-çi, nous sommes bien sur le terminal du poste client) :

```bash
gedit
```

![2024-06-26 11_39_21-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a66ed281-c2bc-4602-a340-282685ca0100)


Et enfin, coller le contenu du presse-papiers dans ce nouveau document, et l'enregistrer dans un format `<nom_du_fichier>.ovpn`

![2024-06-26 11_40_11-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8fc671dd-b99e-497c-a8c9-ff39b816bf93)

Une fois ce fichier créé sur le poste client (Qui est donc une copie exacte du fichier `.ovpn` original situé sur le serveur), il nous faudra le transférer sur le/les poste(s) qui se connecteront via le VPN.  
Le transfert peut se faire via mail / Drive Google / Plateforme de stockage de fichiers / etc ...

### Installation d'OpenVPN-GUI sur les postes serveurs / clients

Nous allons dans un premier temps télécharger la version de [OpenVPN-GUI](https://swupdate.openvpn.org/community/releases/OpenVPN-2.6.11-I001-amd64.msi) depuis le serveur Windows Server GUI, avec l'extension .msi afin de pouvoir la déployer sur les postes clients

![2024-06-26 19_20_01-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1f012094-0eee-471c-a540-f6ac70ae298f)

Une fois le fichier téléchargé, nous allons créér une GPO afin de pouvoir le déployer sur tous les postes clients de notre infrastructure

![2024-06-26 19_21_13-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/25edaae3-8b76-4e6c-a9e7-4584150fa634)

![2024-06-26 19_22_10-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/c776117e-0382-4592-9c53-d331eb7c082b)

![2024-06-26 19_23_58-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/10193403-f28f-4d2f-bd6c-4e69ad58a9b1)

![2024-06-26 19_46_02-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d01256ea-04c6-401e-a23c-f797b137e650)

![2024-06-26 19_25_29-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/2224089e-b0f8-441a-98d8-03190ce90624)

Nous installons ensuite OpenVPN-GUI sur notre serveur

Une fois installé, il nous avertira qu'aucun fichier de confifuration n'a été trouvé, ce qui est normal : Faire un clic droit sur l'icône d'OpenVPN-GUI dans la barre des tâches, puis cliquer sur `Import`

![2024-06-26 19_30_29-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/42f46500-3e23-40e2-b375-30d9f05f63b3)

Choisir un des fichiers que nous avons prélabalement récupéré : 

![2024-06-26 19_30_08-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a9c6c4eb-b830-4619-8079-1853e75f0cfc)

Faire un clic droit sur l'icône d'OpenVPN-GUI dans la barre des tâches, puis cliquer sur `Connect`, et entrer le mot de passe `Azerty1*` pour valider la connexion

![2024-06-26 19_30_54-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a7708cf7-c7ee-40a0-abc3-bbad6aed3cd8)

Un pop-up apparaîtra pour confirmer la connexion, et nous pouvons également le vérifier via l'interface d'OpenVPN-GUI : 

![2024-06-26 19_31_14-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/c85cddb0-c7b2-44f1-bf14-5bd3307f9670)

![2024-06-26 19_31_40-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/dc0cdc14-a156-46a2-a03e-58878482c027)



## 8 PARTENARIAT D'ENTREPRISE - GUACAMOLE

Nous allons mettre en place un serveur Guacamole sur une VM Debian 12

Dans un premier temps nous créer un VM Debian 12 avec les configurations ci dessous 
4GB de RAM minimum 
2 cores minimum



![2024-06-25 14_38_26-](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/880a3199-521d-4b79-9f2f-7ed9a01f7115)


Ensuite nous allons configurer la VM pour la mettre en réseau


![2024-06-25 14_42_37-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/143ef0be-a340-4911-a1e6-b5fa24d0e1a9)


![2024-06-25 14_43_08-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/beea7ad7-4df4-49ff-b70a-82c4c4e1dd38)


![2024-06-25 14_43_28-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/3186a800-1423-47f7-8537-9886cb9670df)


On va égalemment vérifier le fichier *source.list* pour pour utiliser le ```apt update```

![2024-06-25 14_45_33-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/69742a69-7db2-4652-bc28-fd26bbaf7e8c)

Nous allons installer les différentes  bibliothèques de développement nécessaires pour construire le serveur Guacamole et ses dépendances.

```
apt install -y build-essential libcairo2-dev libjpeg62-turbo-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libvncserver-dev libtelnet-dev libwebsockets-dev libssl-dev libvorbis-dev libwebp-dev libpulse-dev sudo
```

On définit une variable d'environnement VER avec la valeur 1.5.5. et on télécharge le fichier source du serveur Guacamole pour la version spécifiée.

```
VER=1.5.5
wget https://downloads.apache.org/guacamole/$VER/source/guacamole-server-$VER.tar.gz
```

On extrait les fichiers de l'archive tar.gz téléchargée.

```
tar xzf guacamole-server-$VER.tar.gz
```

On va changer de répertoire courant pour le dossier extrait du serveur Guacamole.

```
cd guacamole-server-$VER/
```

On configure le projet pour la compilation et spécifie le répertoire d'initialisation pour les scripts de démarrage.

```
./configure --with-init-dir=/etc/init.d
```

On compile le projet, on installe les fichiers compilés sur le système et on met à jour les liens et le cache des bibliothèques partagées.


```
make
make install
ldconfig
```

Recharge le démon systemd pour prendre en compte les nouvelles unités de service, on démarre le service Guacamole Daemon (guacd). Et on active le service guacd pour qu'il démarre automatiquement au démarrage du système.

```
systemctl daemon-reload
systemctl start guacd
systemctl enable guacd
```

On vérifie le status de *guacd*

```
systemctl status guacd
```

On va créer un dossier *extensions*

```
mkdir -p /etc/guacamole/{extensions,lib}
```

On ajoute le dépôt Debian Bullseye à la liste des sources APT

```
echo "deb http://deb.debian.org/debian/ bullseye main" > /etc/apt/sources.list.d/bullseye.list
```

On vas mettre à jour les paquets

```
apt update
```


On installe Tomcat 9 et ses composants administratifs et communs.

```
apt-get install tomcat9 tomcat9-admin tomcat9-common tomcat9-user -y
```

On change le répertoire courant pour /tmp.

```
cd /tmp
```

On télécharge le fichier WAR de l'application web Guacamole pour la version spécifiée.

```
wget https://downloads.apache.org/guacamole/1.5.5/binary/guacamole-1.5.5.war
```

On déplace le fichier WAR téléchargé dans le répertoire des applications web de Tomcat.


```
mv guacamole-1.5.5.war /var/lib/tomcat9/webapps/guacamole.war
```

On redémarre le service Tomcat 9 pour appliquer les changements.

```
systemctl restart tomcat9
```

On installe le serveur de base de données MariaDB.

```
apt-get install mariadb-server
```

On exécute le script de sécurisation de l'installation de MySQL.

```
mysql_secure_installation
```

On ouvre une session MySQL en tant qu'utilisateur root. Demande le mot de passe root pour MySQL.

```
mysql -u root -p
```

Les commandes ci-dessous permettent de créer la base de données "guacadb", avec l'utilisateur "guaca_nachos" associé au mot de passe "Azerty1*" (adaptez ces valeurs). Cet utilisateur dispose de quelques droits sur la base de données.

```
CREATE DATABASE guacadb;
CREATE USER 'guaca_nachos'@'localhost' IDENTIFIED BY 'Azerty1*';
GRANT SELECT,INSERT,UPDATE,DELETE ON guacadb.* TO 'guaca_nachos'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```



On télécharge les extensions d'authentification JDBC pour Guacamole.

```
cd/tmp
wget https://downloads.apache.org/guacamole/1.5.5/binary/guacamole-auth-jdbc-1.5.5.tar.gz
```


On extrait les fichiers de l'archive tar.gz téléchargée.

```
tar -xzf guacamole-auth-jdbc-1.5.5.tar.gz
```


On déplace le fichier JAR de l'extension JDBC MySQL vers le répertoire des extensions de Guacamole.

```
mv guacamole-auth-jdbc-mysql-1.5.5.jar /etc/guacamole/extensions/
```

On télécharge le connecteur JDBC de MySQL.

```
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.4.0.tar.gz
```


On extrait les fichiers de l'archive tar.gz téléchargée.

```
tar -xzf mysql-connector-j-8.4.0.tar.gz
```


On copie le fichier JAR du connecteur MySQL vers le répertoire de la bibliothèque de Guacamole.

```
cp mysql-connector-j-8.4.0/mysql-connector-j-8.4.0.jar /etc/guacamole/lib/
```


On change le répertoire courant pour le dossier schema des extensions JDBC MySQL de Guacamole.

```
cd guacamole-auth-jdbc-1.5.5/mysql/schema/
```

On édite le fichier de configuration de Guacamole avec l'éditeur de texte nano.

```
nano /etc/guacamole/guacamole.properties
```

![2024-06-25 15_17_17-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/623d16e7-d5c3-47ea-93b8-62c1edbf6473)

On édite le fichier de configuration du daemon Guacamole (guacd) avec nano.

```
nano /etc/guacamole/guacd.conf
```

![2024-06-25 15_17_50-QEMU (G1-Guacamole) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/8a6dfc1b-ca83-482a-99a7-b9121fbee0f5)

On redémarre les services MariaDB, Guacamole Daemon (guacd) et Tomcat 9 pour appliquer les configurations et changements.

```
systemctl restart mariadb guacd tomcat9
```

Merci Maggio Di Pasta pour l'accompagnement 






