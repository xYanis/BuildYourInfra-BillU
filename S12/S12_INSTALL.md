# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

#### 1. Firewall - Prise en main du pare-feu pfSense
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

### Mise en place de règles de pare-feu (WAN / LAN / DMZ)

Nous allons mettre en place plusieurs règles, sur lers interfaces WAN et LAN du pare-feu

##### WAN
Bloquer tout le trafic entrant depuis le WAN ("Deny All")

  ![Capture d'écran 2024-05-29 151908](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/2bdf9f9e-5dcb-4b13-8947-2f37fcb8a3aa)

##### LAN

Comme précédemment pour l'interface WAN, nous allons bloquer tout le trafic sortant en direction du WAN ("Deny All")

Puis nous allons ajouter quelques régles pour filtrer le trafic en focntion de nos besoins : 

  - Autorisation du trafic LAN vers LAN (Les ordinateurs de notre réseau peuvent communiquer entre eux)
  - Autorisation du trafic LAN vers le pare-feu (Les ordinateurs de notre réseau peuvent communiquer avec le pare-feu, et également l'administrer)
  - Autorisation du trafic sortant en direction du WAN, uniquement via les ports 80 et 443 (Protocoles `http` et `https`) 

  ![Capture d'écran 2024-05-29 151931](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/b7836113-b743-44dc-bbc4-2621f2d1c4a6)

##### DMZ

Comme précedemment, nous allons bloquer tout le trafic sortant, mais cette fois-ci, en direction du LAN ("Deny All")

Pour les autres règles, nous attendrons la mise en place de serveurs dans la DMZ de notre infrastructure

![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/8cdd015f-702f-4225-8f5f-386c4e40d6cf)

    



## 2. Réseau - Utilisation de routeur sur l'infrastructure Proxmox

Mise en place d'un routeur de type VyOS cloner depuis un template fourni par le formateur.

Création de deux carte réseaux pour les ajouter au routeur pour faire communiquer deux réseaux dans un premier temps.

Sur l'interface de VyOS taper `conf` puis `set interfaces ethernet eth<Numéro> address <AdresseDeLInterface>` pour configurer les différents port ethernet du routeur, ne pas oublier de faire un `commit` et un `save` après chaque manipulation, la commande `show interfaces` permet de voir les interfaces ethernet présente sur le routeur.

Ensuite mise en place d'un routage statique pour faire communiquer les deux réseaux en utilisant la commande `set protocols static route <addresse réseau de destination> next-hop <passerelle>` , ne pas oublier le `commit` et le `save`

Nous avons donc fait communiquer les réseaux 172.19.10.0/24 et 172.19.0.0/24.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/VyOS_Show_Interface&Show_IP_Route.png?raw=true)

### Mise en place d'un relais DHCP sur le routeur VyOS

Une fois sur la console VyOS, entrer en mode "configuration", via la commande `conf`, puis entrer les commandes suivantes :

`set service dhcp-relay listen-interface eth<interface_number1>`

`set service dhcp-relay upstream-interface eth<interface_number2>`

`set service dhcp-relay server <DHCP_IP_Address>`

`commit`

`save`

`exit` pour quitter le mode "configuration"

`restart dhcp relay-agent`

`<interface_number1>` correspond à l'interface qui écoute les requetes DHCP

`<interface_number2>` correspond à l'interface qui reçoit les demande DHCP

`<DHCP_IP_Address>` correspond à l'addresse IP du serveur DHCP

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/VyOS_DHCP_Relay.png?raw=true)


### Installation de service DHCP sur les VM Ubuntu

Concernant la mise en réseau des différents ordinateurs sur les réseaux, et notamment ceux sur Ubuntu, nous devons configurer le service DHCP.  
Pour Windows, le service est dejà intégré, mais pas pour Linux.  
Pour cela, nous devons installer le service DHCP via la commande suivante : 
```bash
sudo apt install isc-dhcp-client
```
Puis utiliser les commandes `sudo dhclient -r` pour libérer l'adresse IP, et `sudo dhclient` pour renouveller la demande d'adresse IP

![2024-05-31 12_04_30-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a4bd2180-eb03-40d4-a5ea-b9ccec65537d)


## 3. Sécurité - Gestion de la télémétrie sur un client Windows 10/11, 2 possibilités (au choix)

Pour plus d'informations, se rendre sur le fichier [S12_USER_GUIDE.md](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/local/S12/S12_USER_GUIDE.md)
