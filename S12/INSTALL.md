# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# 1. Objectifs

### 1. Firewall - Prise en main du pare-feu pfSense
**1 - Connexion :**
- Login : `admin`
- Mdp : `pfsense`

**2 - VM Proxmox :**

- Interfaces :
  - WAN (`vmbr1 proxmox`) : `10.0.0.2/24`
  - Gateway : `10.0.0.1`
  - LAN (`vmbr4 proxmox`) : `172.19.5.254/24` <= Accès console Web
  - DMZ (`vmbr5 proxmox`) : Interface à gérer
  - ID de VM de groupe à gérer
      
- Mise en place de règles de pare-feu (WAN et LAN) :
  - Règles de bonnes pratiques
  - Principe du **Deny All**

### 2. Réseau - Utilisation de routeur sur l'infrastructure Proxmox
  - Routeur Vyos
  - Lien avec le schéma réseau initial

### 3. Sécurité - Gestion de la télémétrie sur un client Windows 10/11, 2 possibilités (au choix) :

- Gestion par script :
  - Script crée sur un serveur Windows
  - Script copié sur les clients (GPO, AT, etc.)
  - Script exécuté sur les clients (GPO, AT, etc.)

- Gestion par GPO :
  - Création d'une GPO ordinateur
  - Création d'une GPO utilisateur

## 1. Firewall - Prise en main du pare-feu pfSense

## 2. Réseau - Utilisation de routeur sur l'infrastructure Proxmox

Mise en place d'un routeur de type VyOS cloner depuis un template fourni par le formateur.

Création de deux carte réseaux pour les ajouter au routeur pour faire communiquer deux réseaux dans un premier temps.

Sur l'interface de VyOS taper `conf` puis `set interfaces ethernet eth<Numéro> address <AdresseDeLInterface>` pour configurer les différents port ethernet du routeur, ne pas oublier de faire un `commit` et un `save` après chaque manipulation, la commande `show interfaces` permet de voir les interfaces ethernet présente sur le routeur.

Ensuite mise en place d'un routage statique pour faire communiquer les deux réseaux en utilisant la commande `set protocols static route <addresse réseau de destination> next-hop <passerelle>` , ne pas oublier le `commit` et le `save`

Nous avons donc fait communiquer les réseaux 172.19.10.0/24 et 172.19.0.0/24.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/VyOS_Show_Interface&Show_IP_Route.png?raw=true)

Mise en place d'un relais DHCP sur le routeur VyOS

Une fois sur la console VyOS rentrer en mode conf puis taper :

<interface_number> correspond à l'interface qui écoute les requetes DHCP

``
set service dhcp-relay interface eth<interface_number>
set service dhcp-relay server <DHCP_IP_Address>
``



## 3. Sécurité - Gestion de la télémétrie sur un client Windows 10/11, 2 possibilités (au choix)
