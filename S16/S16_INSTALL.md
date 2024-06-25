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

Ensuite, il faut éditer le fichier /etc/network/interfaces afin de configurer correctement notre adresse IP :

![2024-06-24 22_15_18-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8cbb6ee5-1b60-430e-8b3f-2461bafd196d)

Ensuite, il faut éditer le fichier /etc/hosts afin de corriger l'adresse IP de notre serveur ; Dans notre cas, ce sera `172.19.11.2` :

![2024-06-24 22_23_12-QEMU (G1-OpenVPN) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/332dd3fd-b6e0-46a4-9cce-d8e7af74c689)

Ensuite, il faut éditer le fichier /etc/hosts afin de corriger le nom de notre serveur ; Dans notre cas, ce sera `BillU-VPN` :

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



