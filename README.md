# TSSR-2402-P3-G1-BuildYourInfra-BillU

Construction d’une infrastructure réseau

Mise en pratique des compétences suivantes :

- Analyser les besoins techniques et fonctionnels
- Mettre en place des objectifs et réaliser un suivi
- Créer, gérer, faire évoluer une architecture réseau
- Réaliser un projet en équipe
- Documenter toutes les étapes


Contexte

     
**BillU** est une filiale du groupe international RemindMe, qui a plus de 2000 collaborateurs dans le monde. Elle est spécialisée dans le développement de logiciels, entre-autre de facturation. Le groupe prévoit un budget conséquent pour développer cette filiale. Le siège Français se situe à Paris (dans le 20 eme arrondissement).
Avec une équipe talentueuse de développeurs et d'experts en finance, elle est déterminée à fournir des logiciels de pointe qui simplifient les processus financiers et améliorent l'efficacité opérationnelle pour ses clients.
Vous faite partie d'une société prestataire de services du groupe RemindMe. Vous êtes mandaté pour mettre en place l'infrastructure réseau de la société BillU.
Dans le contexte du projet, le formateur sera le DSI de cette société.                                        


*Préface*


SkyLan, une solution de pointe déployée par RemindMe. Une entreprise réputée pour son expertise en solutions informatiques de pointe, vient de remporter avec succès l'appel d'offres pour structurer le réseau informatique de la société BillU. Cette annonce marque une étape significative dans l'évolution technologique de BillU, une entreprise innovante dans le domaine du développement logiciel. La décision de confier cette tâche cruciale à RemindMe reflète la confiance de BillU dans la capacité de Skylan à concevoir et à mettre en œuvre des solutions informatiques fiables et évolutives. Cette collaboration promet de renforcer l'efficacité opérationnelle de BillU tout en lui offrant les outils nécessaires pour prospérer dans un environnement numérique en constante évolution.  

Effectif détaché par RemindME pour le déploiement de SkyLan au sein de BillU:

# Semaine 09 sprint 01  

        - Yanis Hortholary   SM
        - Alexandre Peyronie
        - Thomas Scotti
        - Sébastien Taiclet  PO


| Tâches                                               | Responsable    |
|-----------------------------------------------------|----------------|
| Création de VM serveur / client                     | Sébastien Taiclet et  Alexandre Peyronie |
| Création d'un domaine                               | Sébastien Taiclet et  Alexandre Peyronie |
| Création des OU correspondant aux différents services de la société | Sébastien Taiclet et Alexandre Peyronie |
| Création des groupes correspondant aux différents groupes d'utilisateurs de la société | Alexandre Peyronie et Sébastien Taiclet |
| Intégration des données dans l'AD                  |  Alexandre Peyronie et Sébastien Taiclet   |
| Plan d'adressage réseau                             |      Alexandre Peyronie       |
| Plan schématique du futur réseau                   |  Yanis Hortholary et Thomas Scotti |
| Liste des serveurs/matériels nécessaires           |  Yanis Hortholary et Thomas Scotti |
| Mise en place d'une nomenclature de nom            |  Yanis Hortholary et Thomas Scotti |


# Semaine 10 sprint 02 

        - Yanis Hortholary   PO
        - Alexandre Peyronie
        - Thomas Scotti      SM
        - Sébastien Taiclet  

| Tâches                                                                            | Responsable    |
|-----------------------------------------------------------------------------------|----------------|
| AD-DS Création d'un domaine AD ( Windows Server GUI / CORE )                      | Thomas Scotti et Yanis Hortholary |
| Création de l'arborescence AD ( Création OU / GROUPES / COMPTES )                | Alexandre Peyronie et Yanis Hortholary |
| Création de l'arborescence AD entièrement automatisée à partir d'un fichier CSV | Sébastien Taiclet et Alexandre Peyronie |
| Création d'une VM Server Debian mise sur le domaine AD accessible en SSH | Thomas Scotti et Sébastien Taiclet |
| Création VM client ( Sur le domaine AD + SSH Debian )                | Thomas Scotti et Yanis Hortholary   |



# Semaine 11 sprint 03

        - Yanis Hortholary   
        - Alexandre Peyronie PO
        - Thomas Scotti      
        - Sébastien Taiclet  SM

## Création de GPO

## GPO de Sécurité

| #  | GPO de Sécurité                                                          | Responsable |
|----|-------------------------------------------------------------------------------------------------|-------------|
| 1  | Politique de mot de passe (complexité, longueur, etc.)                                          | Alexandre Peyronie et Thomas Scotti |
| 2  | Verrouillage de compte (blocage de l'accès à la session après quelques erreurs de mot de passe) | Alexandre Peyronie et Thomas Scotti |
| 3  | Restriction d'installation de logiciel pour les utilisateurs non-administrateurs                | Alexandre Peyronie et Thomas Scotti |
| 4  | Blocage de l'accès à la base de registre                                                        | Alexandre Peyronie et Thomas Scotti |
| 5  | Gestion du pare-feu                                                                             | Alexandre Peyronie et Thomas Scotti |
| 6  | Écran de veille avec mot de passe en sortie                                                     | Alexandre Peyronie et Thomas Scotti |
| 7  | Politique de sécurité PowerShell                                                                | Alexandre Peyronie et Thomas Scotti |
| 8  | Bloquer l'accès au lecteur C                                                                    | Alexandre Peyronie et Thomas Scotti |
| 9  | Bloquer l'accès au panneau de configuration                                                     | Alexandre Peyronie et Thomas Scotti |
| 10 | Déconexion en dehors des horaires prédéfinies                                                   | Alexandre Peyronie et Thomas Scotti |


## GPO Standard

| #  | GPO Standard                                                   | Responsable |
|----|----------------------------------------------------------------|-------------|
| 1  | Fond d'écran                                                   | Yanis Hortholary et Thomas Scotti  |
| 2  | Déploiement (publication) de logiciels                         | Yanis Hortholary et Thomas Scotti  |
| 3  | Configuration des paramètres du navigateur (Firefox ou Chrome) | Yanis Hortholary et Thomas Scotti  |
| 4  | Bloquer Windows Jeux                                           | Yanis Hortholary et Thomas Scotti  |
| 5  | Désactiver l'accès à Windows Media Player                      | Yanis Hortholary et Thomas Scotti  |



## Création d'un serveur GLPI - Sur Debian 11 ou 12 en CLI

| #  | Création d'un serveur GLPI                               | Responsable |
|----|----------------------------------------------------------------------------------|-------------|
| 1  | Synchronisation AD                                                               |   Alexandre Peyronie et Thomas Scotti |
| 2  | Gestion de parc : Inclusion des objets AD (utilisateurs, groupes, ordinateurs)   |  Alexandre Peyronie et Thomas Scotti  |
| 3  | Gestion des incidents : Mise en place d'un système de ticketing                  |  Alexandre Peyronie et Thomas Scotti  |
| 4  | Accès et gestion à partir d'un client                                            |  Alexandre Peyronie et Thomas Scotti  |
 
##  Scripts d'automatisation :

| #  | Scripts d'automatisation | Responsable |
|----|-----------------------------------------------|-------------|
| 1  | Sur un serveur Debian, installation de Glpi à partir d'un fichier de configuration qui contient par exemple le nom de la base de donnée, le nom du compte, etc.       |  Sébastien Taiclet et  Alexandre Peyronie |
| 2  | Sur un Windows Server Core, installation du rôle AD-DS, ajout à un domaine existant. On se base sur un fichier de configuration qui contient le nom du serveur, l'adresse IP du DNS, le nom du domaine, etc. | Yanis Hortholary et Thomas Scotti |
| 3 | Finalisation du script ajout d'utilisateur    |  Sébastien Taiclet |

        

# Semaine 12 sprint 04

        - Yanis Hortholary   PO
        - Alexandre Peyronie SM
        - Thomas Scotti      
        - Sébastien Taiclet  


## Firewall - Prise en main du pare-feu pfSense

| #  | Firewall                                        |   Responsable  |   
|----|-----------------------------------------------------|---------------------|  
| 1  | Connexion au pare-feu pfSense                       |  Sébastien Taiclet  |
| 2  | DMZ (vmbr5 proxmox) : Interface à gérer             |  Sébastien Taiclet  |
| 3  | Identification des VMs de groupe à gérer            |  Sébastien Taiclet  |
| 4  | Mise en place de règles de pare-feu (WAN et LAN)    |  Sébastien Taiclet  |
| 5  | Règles de bonnes pratiques                          |  Sébastien Taiclet  |
| 6  | Principe du Deny All                                |  Sébastien Taiclet  |

## Utilisation de routeur sur l'infrastructure Proxmox

| #  | Vyos                                        |  Responsable  |
|----|-----------------------------------------------------|---------------------------------------|  
| 1  | Routeur Vyos                                        |   Alexandre Peyronie et Thomas Scotti |
| 2  | Lien avec le schéma réseau initial                  |   Alexandre Peyronie et Thomas Scotti |

## Gestion de la télémétrie sur un client Windows 10/11

| #  | GPO Télémétrie                                       | Responsable | 
|----|-----------------------------------------------------|--------------|  
| 1  | Gestion par script                                  |  Yanis Hortholary |
| 2  | Script créé sur un serveur Windows                  |  Yanis Hortholary |
| 3  | Script copié sur les clients (GPO, AT, etc.)        |  Yanis Hortholary |
| 4  | Script exécuté sur les clients (GPO, AT, etc.)      |  Yanis Hortholary |


## Mise en place du role DHCP

| #  | DHCP                                       | Responsable |
|----|-------------------------------------------|--------------| 
| 1  | Mis en place sur GUI et Vyos              |   Alexandre Peyronie, Thomas Scotti et Sébastien Taiclet |



# Semaine 13 sprint 05

        - Yanis Hortholary   
        - Alexandre Peyronie 
        - Thomas Scotti      SM
        - Sébastien Taiclet  PO

## 1. DOSSIERS PARTAGES - Mettre en place des dossiers réseaux pour les utilisateurs

| #  | Dossiers partagés                                     |  Responsable  |
|----|--------------------------------------------------------|-----------------------------------|
| 1  | Stockage des données sur un volume spécifique de l'AD  | Yanis Hortholary et Thomas Scotti |
| 2  | Sécurité de partage des dossiers par groupe AD         | Yanis Hortholary et Thomas Scotti |
| 3  | Mappage des lecteurs sur les clients par GPO ou script | Yanis Hortholary et Thomas Scotti |
|    | ou paramétrage de profil utilisateur                   |                                   | 
| 4  | Acces des utilisteurs aux lecteurs                     | Yanis Hortholary et Thomas Scotti |

## 2. STOCKAGE AVANCÉ - Mettre en place du RAID 1 sur le volume système des serveurs
En stand by
## 3. SAUVEGARDE - Mettre en place une sauvegarde du volume qui contient les dossiers partagés des utilisateurs

| #  | Sauvegarde                                   |  Responsable  |
|----|--------------------------------------------------------|-----------------------------------|
| 1  | Mettre en place une sauvegarde du volume  | Yanis Hortholary et Thomas Scotti |


## 4. MOT DE PASSE ADMINISTRATEUR LOCAL - Mise en place de LAPS


| #  | LAPS                                   |  Responsable  |
|----|--------------------------------------------------------|-----------------------------------|
| 1  | Mise en place du LAPS  | Alexandre Peyronie  |


## 5. DÉPLACEMENT DES MACHINES DANS L'AD - Automatisation du placement dans la bonne OU

| #  | Placement des machines dans l'AD et automatisation                        |  Responsable  |
|----|--------------------------------------------------------|-----------------------------------|
| 1  | Placement AD et automatisation                  | Alexandre Peyronie et Sébastien Taiclet  |

## 6. RESTRICTION D'UTILISATION DES MACHINES - Restriction horaire

| #  | Restriction horaire                                |  Responsable  |
|----|--------------------------------------------------------|-----------------------------------|
| 1  | Mise en place de la restriction | Alexandre Peyronie  |

Création d'un [script](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/Scripts/EditLogHours.ps1) pour éditer les heures de connection autorisé pour tout les utilisateurs présent dans l'OU BillU-Users basé sur le tuto de [it-connect](https://www.it-connect.fr/chapitres/active-directory-powershell-horaire-acces/).

Ce Script permet aux utilisateurs de se connecter de 7h30 à 20h du lundi au samedi.


## 7. Objectif personnalisé 
Next week

# Semaine 13 sprint 05

        - Yanis Hortholary   
        - Alexandre Peyronie PO
        - Thomas Scotti      
        - Sébastien Taiclet  SM

## 1. Mise en place du RAID

## 2. Supervision - ZABBIX

## 3. Mise à jour de l'AD

Le script UserGestion.ps1 à été modifier pour permettre de déplacer et désactiver les personnes sortante de l'entreprise

## 4. Journalisation des scripts

Les scrips ont été modifier pour permettre de créer des journaux de log dans C:\Logs

Chaque script créé un journal de log qui lui est propre pour faciliter la lecture et la recherche d'évènements 

Ces log sont aussi consultable depuis le Log Event
