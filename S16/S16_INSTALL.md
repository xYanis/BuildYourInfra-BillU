# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# Sommaire 

### 1 - AD - Rôles FSMO

Installation d'un nouveau serveur Windows Server Core BILLU-CORE-TWO en 172.19.0.5/24

Installation des rôles ADDS

Transfert des rôles FSMO

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

## 1 Installation du rôle WSUS

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


### 3 - PARTENARIAT D'ENTREPRISE - VPN site-à-site
### 4 - PARTENARIAT D'ENTREPRISE - FIREWALL
### 5 - PARTENARIAT D'ENTREPRISE - Active Directory
### 6 - PARTENARIAT D'ENTREPRISE - SUPERVISION
### 7 - PARTENARIAT D'ENTREPRISE - STOCKAGE

A partir de ce sprint, l'entreprise BillU est dorénavant liée à l'entreprise EcoTech Solutions.  
Ce partenariat aura pour objectif de renforcer la présence de ces deux entreprises à un niveau international encore jamais imaginé !  

Les nouveaux objectifs seront désormais adaptés à cette nouvelle infrastructure

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



