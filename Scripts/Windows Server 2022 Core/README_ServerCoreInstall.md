## Script pour automatisation de la configuration d'un serveur sous Windows Server Core

### 1 - Présentation
Le script `ServerCoreInstall.ps1` permet d'automatiser la configuration et l'installation des rôles `AD-DS` et `DNS` sur un serveur basé sur Windows Server 2022 Core (Sans GUI).  

  
Il est fourni avec un fichier `ServerCoreConfig.csv` qui servira de fichier de configuration pour le nom de l'ordinateur, le nom de domaine, et la configuration IP.  

  
**ATTENTION : Ce fichier de configuration est pré-configuré pour être utilisé dans le cadre de notre projet, il sera évidemment à modifier pour correspondre à une autre architecture.**

### 2 - Pré-requis
- Un poste sous Windows Server 2022 Core
- Un dossier `Scripts` à la racine de `C:\` (Le chemin sera donc `C:\Scripts\`), contenant les fichiers `ServerCoreInstall.ps1` et `ServerCoreConfig.csv`
- Un accès Administrateur sur ce serveur

### 3 - Utilisation
L'utilisation est très simple : 
 - Démarrer le poste sous Windows Server Core
 - Se connecter avec un compte Administrateur
 - Une fois sur le menu principal, entrer `15` pour accéder au prompt
 - Se rendre dans le dossier `C:\Scripts\`
 - Exéctuter le script `ServerCoreInstall.ps1`

Une fois l'éxécution du script finalisée, les différents paramètres du serveur, correspondant à votre architecture réseau, seront appliqués.
