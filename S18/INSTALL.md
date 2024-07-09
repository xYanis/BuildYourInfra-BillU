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




