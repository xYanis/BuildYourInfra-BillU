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

## Semaine 09 sprint 01  

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


## Semaine 10 sprint 02 

        - Yanis Hortholary   PO
        - Alexandre Peyronie
        - Thomas Scotti      SM
        - Sébastien Taiclet  

| Tâches                                               | Responsable    |
|-----------------------------------------------------|----------------|
| AD-DS Création d'un domaine AD ( Windows Server GUI / CORE )        | Thomas Scotti et Yanis Hortholary |
| Création de l'arborescence AD ( Création OU / GROUPES / COMPTES )                | Alexandre Peyronie et Yanis Hortholary |
| Création de l'arborescence AD entièrement automatisée à partir d'un fichier CSV | Sébastien Taiclet et Alexandre Peyronie |
| Création d'une VM Server Debian mise sur le domaine AD accessible en SSH | Thomas Scotti et Sébastien Taiclet |
| Création VM client ( Sur le domaine AD + SSH Debian )                | Thomas Scotti et Yanis Hortholary   |



## Semaine 11 sprint 02 

        - Yanis Hortholary   
        - Alexandre Peyronie PO
        - Thomas Scotti      
        - Sébastien Taiclet  SM

## Création de GPO

## GPO de Sécurité

| #  | GPO de Sécurité                                                          | Responsable |
|----|--------------------------------------------------------------------------|-------------|
| 1  | Politique de mot de passe (complexité, longueur, etc.)                   |            |
| 2  | Verrouillage de compte (blocage de l'accès à la session après quelques erreurs de mot de passe) |            |
| 3  | Restriction d'installation de logiciel pour les utilisateurs non-administrateurs |           |
| 4  | Blocage de l'accès à la base de registre                                 |            |
| 5  | Gestion du pare-feu                                                      |            |
| 6  | Écran de veille avec mot de passe en sortie                              |            |
| 7  | Politique de sécurité PowerShell                                         |            |
| 8  | Bloquer l'accès au lecteur C                                             |            |
| 9  | Bloquer l'accès à l'AD                                                   |            |
| 10 | Interdire la configuration avancée TCP / IP                              |            |


## GPO Standard

| #  | GPO Standard                                  | Responsable |
|----|-----------------------------------------------|-------------|
| 1  | Fond d'écran                                  |           |
| 2  | Déploiement (publication) de logiciels        |           |
| 3  | Configuration des paramètres du navigateur (Firefox ou Chrome) |           |
| 4  | Bloquer Windows Jeux                          |           |
| 5  | Désactiver l'accès à Windows Media Player     |           |



## Création d'un serveur GLPI - Sur Debian 11 ou 12 en CLI

| #  | Création d'un serveur GLPI                               | Responsable |
|----|-----------------------------------------------|-------------|
| 1  | Synchronisation AD                            |               |
| 2  | Gestion de parc : Inclusion des objets AD (utilisateurs, groupes, ordinateurs)   |         |
| 3  | Gestion des incidents : Mise en place d'un système de ticketing  |         |
| 4  | Accès et gestion à partir d'un client  |         |
 
##  Scripts d'automatisation :

| #  | Scripts d'automatisation | Responsable |
|----|-----------------------------------------------|-------------|
| 1  | Sur un serveur Debian, installation de Glpi à partir d'un fichier de configuration qui contient par exemple le nom de la base de donnée, le nom du compte, etc.
| 2  | Sur un Windows Server Core, installation du rôle AD-DS, ajout à un domaine existant. On se base sur un fichier de configuration qui contient le nom du serveur, l'adresse IP du DNS, le nom du domaine, etc.

        

