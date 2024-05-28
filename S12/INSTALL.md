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

## 3. Sécurité - Gestion de la télémétrie sur un client Windows 10/11, 2 possibilités (au choix)
