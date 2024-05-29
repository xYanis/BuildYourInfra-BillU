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
### 1. Connexion :
	 -	1. Login : `admin`
	 -	2. Mdp : `pfsense`
### 2. VM Proxmox :
	  -	1. Interfaces :
		  - WAN (vmbr1 proxmox) : 10.0.0.2/24
		  - Gateway : 10.0.0.1
			- LAN (vmbr4 proxmox) : 172.19.10.254/16 
			- DMZ (vmbr5 proxmox) : 172.19.11.1
		2. ID de VM de groupe à gérer
     - pfSense ID = 543
##3. Mise en place de règles de pare-feu (WAN et LAN)
  ![Capture d'écran 2024-05-29 151908](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/2bdf9f9e-5dcb-4b13-8947-2f37fcb8a3aa)
    
  Deny all traffic depuis WAN

  ![Capture d'écran 2024-05-29 151931](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/b7836113-b743-44dc-bbc4-2621f2d1c4a6)
    
  - Deny all traffic depuis LAN
  - Puis ajout de règles pour gèrer le traffic.
  - LAN to LAN
  - LAN to pfSense
  - LAN to WAN

  ![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/8cdd015f-702f-4225-8f5f-386c4e40d6cf)

  - Deny all traffic from DMZ to LAN


 ### - En attente de services a filtrer
    



## 2. Réseau - Utilisation de routeur sur l'infrastructure Proxmox

Mise en place d'un routeur de type VyOS cloner depuis un template fourni par le formateur.

Création de deux carte réseaux pour les ajouter au routeur pour faire communiquer deux réseaux dans un premier temps.

Sur l'interface de VyOS taper `conf` puis `set interfaces ethernet eth<Numéro> address <AdresseDeLInterface>` pour configurer les différents port ethernet du routeur, ne pas oublier de faire un `commit` et un `save` après chaque manipulation, la commande `show interfaces` permet de voir les interfaces ethernet présente sur le routeur.

Ensuite mise en place d'un routage statique pour faire communiquer les deux réseaux en utilisant la commande `set protocols static route <addresse réseau de destination> next-hop <passerelle>` , ne pas oublier le `commit` et le `save`

Nous avons donc fait communiquer les réseaux 172.19.10.0/24 et 172.19.0.0/24.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/VyOS_Show_Interface&Show_IP_Route.png?raw=true)

Mise en place d'un relais DHCP sur le routeur VyOS

Une fois sur la console VyOS rentrer en mode conf puis taper :

`set service dhcp-relay interface eth<interface_number>`

`set service dhcp-relay server <DHCP_IP_Address>`

`commit`

`save`

<interface_number> correspond à l'interface qui écoute les requetes DHCP

<DHCP_IP_Address> correspond à l'addresse IP du serveur DHCP

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/VyOS_Relay_DHCP.png?raw=true)


## 3. Sécurité - Gestion de la télémétrie sur un client Windows 10/11, 2 possibilités (au choix)
