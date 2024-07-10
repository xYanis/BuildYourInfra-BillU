# TSSR-2402-P3-G1-BuildYourInfra-BillU

## 1 - PingCastle

Se rendre sur le site https://www.pingcastle.com/

Cliquer sur FreeDownload

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-07-08%20103938.png?raw=true)

Un fois le fichier télécharger, le décompresser et lancer le fichier :

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-41-50%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Suivez le script ouvert puis deux fichier vont être créé dans le même dossier ou cse trouve PingCastle

Nous allons étudier le .html

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-26%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-33%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-42%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-55%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-35-08%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![]()


## 2 - Serveur RADIUS : FREERADIUS sur PfSense

Un serveur RADIUS est utilisé dans le but d'authentifier les utilisateurs utilsant le réseau.  
Dans le cadre de notre projet, la fonction qui nous intéressera sera celle du "portail captif", une sorte de passerelle nécéssitant un identifiant et un mot de passe afin d'autoriser les utilisateurs à accéder au réseau Internet.  


### Installation de FREERADIUS sur Pfsense

Se rendre sur l'interface de gestion de PfSense, puis cliquer sur `System`, et sur `Package Manager`

![2024-07-09 14_13_05-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/858536e9-9b65-4632-bc3c-eb47ca5aa35b)

Cliquer sur `Available Packages`, puis cliquer sur le bouton `Install` au niveau du paquet nommé `freeradius3`

![2024-07-09 14_13_49-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/746b64ac-53b8-4d9d-b552-b9702f346d4b)
![2024-07-09 14_14_19-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7b8a168c-ce94-4395-8951-075d67d01d6f)


Cliquer ensuite sur `Confirm`, et patienter jusqu'à la fin de l'installation de `FREERADIUS`

![2024-07-09 14_15_41-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7e80f175-b8fb-447a-bf18-e8f0c15bc864)
![2024-07-09 14_16_00-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/88bff39f-7137-40ae-be1c-7d239a41cb64)
![2024-07-09 14_16_28-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7993bcbd-b934-4c29-beda-1b8ff76929dc)

### Configuration de FREERADIUS sur PfSense

## 3 - Serveur OpenVPN : OpenVPN sur PfSense

Dans l'optique d'un(e) partenariat / fusion entre les entreprises BillU et EcoTechSolutions, nous avons mis en place un tunnel VPN entre les réseaux de ces dernières.  
Cette liaison sécurisée a été possible grâce au service OpenVPN intégré directement sur le pare-feu PfSense.  

### Création et importation de certificats / clés TLS

Nous partons du principe que notre entreprise, BillU, se placera du côté "client VPN", et l'entreprise EcoTechSolutions du côté "serveur VPN".  
Les différents certificats ainsi que les clés TLS seront générés via le service OpenVPN de l'entreprise EcoTechSolutions, et envoyés (par exemple, par mail) sur le serveur principal de l'entreprise BillU.  
Vous pourrez retrouver la documentation concernant la génération de certificats et des clés TLS sur le fichier INSTALL.md de l'entreprise EcoTechSolutions.  

Nous avons donc en notre possession 4 fichiers : 2 certificats en format .crt, une clé en format .txt, et une clé en format .key

**1ère étape**  
Se rendre dans l'interface d'administration de PfSense, puis cliquer sur System, puis sur Certificates.  
  
Dans la section Authorities, cliquer sur le bouton + Add, puis entrer les informations suivantes :   
- Descriptive Name : OpenVPN_EcoTech_Auth
- Method : Impot an existing Certificate Authority
- Trust Store : Cocher la case
- Certificate data : Coller le contenu du fichier OpenVPN_BillU_Auth.crt, préalablement ouvert avec le bloc-notes de Windows

Une fois cela fait, cliquer sur Save

![2024-07-10 10_33_00-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/84141a13-4718-48f7-b99b-63ea851e51e5)
![2024-07-10 10_33_50-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7205eef5-11d7-438d-bd10-66bad71f2868)

Cliquer maintenant sur Certificates, puis sur le bouton + Add, et entrer les informations suivantes : 
- Méthod : Importing an existing Certificate
- Descriptive Name : OpenVPN_EcoTech_Cert_CLI
- Certificate Type : Laisser cochée la case X.509 (PEM)
- Certificate data : Coller le contenu du fichier OpenVPN_BillU_Certificat_CLI.crt, préalablement ouvert avec le bloc-notes de Windows
- Private key data : Coller le contenu du fichier OpenVPN_BillU_Certificat_CLI.key, préalablement ouvert avec le bloc-notes de Windows
  
Une fois cela fait, cliquer sur Save  

![2024-07-10 10_35_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fd9b6cd4-c193-4a5a-a625-21365c537c07)
![2024-07-10 10_36_06-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/75c93e8b-3665-4aa7-8d25-bf43cce8e26d)
![2024-07-10 10_36_23-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/29067a21-86af-40d3-bae3-c705704bc655)

Une fois les certificats importés, nous allons configurer le "client" OpenVPN : Cliquer en haut sur VPN, puis sur OpenVPN.  
Une fois arrivé içi, cliquer sur Clients, puis sur le bouton + Add, et entrer les informations suivantes : 
- Description OpenVPN_EcoTech_CLI
- Server mode : Peer to Peer
- Desvice Mode : tun - layer 3 Tunnel Mode
- Protocol : UDP on IPv4 only
- Interface : WAN
- Server host or address :  10.0.0.3 (Interface WAN du pare-feu PfSense de l'entreprise EcoTech)
- Server Port : 1194 (Port utilisé par OpenVPN)
- TLS Configuration : Use a TLS Key
- TLS Key : Coller le contenu du fichier TLS_KEY_OpenVPN.txt
- Peer Certificate Authority : OpenVPN_EcoTech_Auth
- Client Certificate : OpenVPN_EcoTech_Cert_CLI
- IPv4 Tunnel Network : 10.0.8.0/30 (Réseau utilisé pour la connexion VPN)
- IPv4 Remote network(s) : 10.10.0.0/16 (Réseau LAN de l'entreprise EcoTech)
- Gateway creation : IPv4 only

Une fois cela fait, cliquer sur Save  

![2024-07-10 10_37_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1fdd9429-af82-4818-8baa-8aa9c57f05c3)
![2024-07-10 10_38_19-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/dbadb7a9-5a20-4001-b736-bc11fd8aac3f)
![2024-07-10 10_39_24-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/cfb1fb93-49fc-4bf9-9f86-6734692dc6d9)
![2024-07-10 10_39_51-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8396424f-97db-4672-a0e1-3cd1f820e59e)
![2024-07-10 10_40_31-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/22df5007-f4c9-4832-aefd-e07d635f18f6)
![2024-07-10 10_40_59-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/56809afa-4853-4219-b244-61f98d535f24)


Cliquer en haut sur Interfaces, puis sur Assignements  
Une fois dans cette section, cliquer sur le bouton + Add en bas à droite, afin d'activer l'interface d'OpenVPN (OPT2), pusi cliquer sur OPT2 afin de la configurer avec les informations suivantes : 
- Enable : Cocher la case Enable interface
- Description : OpenVPN
  
Une fois cela fait, cliquer sur Save  

![2024-07-10 10_43_08-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a2994af9-604a-449b-b50a-551817e79a1d)
![2024-07-10 10_43_35-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d9c6496f-d427-4d53-a617-1a5f00cfefc6)

Cliquer en haut sur Firewall, puis sur Rules, puis sur l'interface OPENVPN, puis sur le bouton Add, et créer une règle qui autorise tout le trafic : 

![2024-07-10 10_45_32-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/9e5f8ca4-15aa-4183-8038-ae346323d1a8)

Faire de même avec l'interface OpenVPN : 

![2024-07-10 10_46_02-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/ab8ff722-3f10-42fe-9469-cb15b3cd837c)

Cliquer en haut sur System, puis Routing, puis Static Routes, puis sur le bouton + Add, et entrer les informations suivantes : 
- Destination network : 10.10.0.0 (Réseau LAN de l'entreprise EcoTech)
- Gateway : OPENVPN_VPNV4 - 10.0.8.1
- Disabled : Laisser la case décochée
- Description : Road_To_EcoTech

Faire de même une nouvelle fois avec les informations suivantes : 
- Destination network : 10.11.0.0 (Réseau DMZ de l'entreprise EcoTech)
- Gateway : OPENVPN_VPNV4 - 10.0.8.1
- Disabled : Laisser la case décochée
- Description : Road_To_EcoTech_DMZ
  
![2024-07-10 11_33_36-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a7ca7281-068f-4120-9af6-044047d0387b)

OpenVPN est désormais installé et configuré pour la communication entre les réseaux des deux entreprises

