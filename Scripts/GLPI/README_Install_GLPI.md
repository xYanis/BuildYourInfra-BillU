## Script pour automatisation de la configuration d'un serveur GLPI sous Debian

### 1 - Présentation
Le script `InstallGLPIFromConf.sh` permet d'automatiser l'installation et la configuration d'un serveur GLPI sous Debian 

  
Il est fourni avec un fichier `Config_GLPI.txt` qui servira de fichier de configuration pour l'interface réseau, le nom de la base de données, le nom de l'utilisateur et le mot de passe associé 

  
**ATTENTION : Ce fichier de configuration est pré-configuré pour être utilisé dans le cadre de notre projet, il sera évidemment à modifier pour correspondre à une autre architecture.**

### 2 - Pré-requis
- Un poste sous Debian 12
- Un dossier `Scripts`, contenant les fichiers `InstallGLPIFromConf.sh` et `Config_GLPI.txt`
- Un accès `root` sur ce serveur

### 3 - Utilisation
L'utilisation est très simple : 
 - Démarrer le poste sous Debian 12
 - Se connecter avec un compte `root`
 - Se rendre dans le dossier `Scripts`
 - Exéctuter le script `InstallGLPIFromConf.sh`

Une fois l'éxécution du script finalisée, vous pouvez redémarrer le serveur et continuer la configuration du serveur GLPI comme indiqué dans le fichier `INSTALL.md` de la `S11` (Rubrique `C - Installation du serveur GLPI (Via l'interface graphique)`)
