# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

### 1 - Création de 10 GPO de sécurité (Minimum)

### 2 - Création de 5 GPO de sécurité (Minimum)

### 3 - Création d'un serveur GLPI sur une VM Debian 12 (CLI)

### 4 - Scripts d'automatisation sur Debian et Windows Server (Core)

## 1 - Création de 10 GPO de sécurité (Minimum)

## 2 - Création de 5 GPO de sécurité (Minimum)

## 3 - Création d'un serveur GLPI sur une VM Debian 12 (CLI)

### A - Pré-requis

- Une VM Debian 12
  - Nom de compte : `root`
  - Mot de passe : `Azerty1*`
  - Adresse IP : `172.19.5.4`

### B - Installation du serveur GLPI

### ***Mise à jour du système***

Une fois connecté en `root` sur la VM Debian, éxécuter la commande suivant afin de mettre à jour le système : 
```bash
apt-get update && sudo apt-get upgrade
```

![2024-05-21 15_34_29-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/02f557df-c517-4f43-bf0e-8e48a7b47390)

### ***Téléchargement et installation des paquets nécéssaires***

Exécuter la commande suivante afin d'installer les paquets `Apache2`, `Maria DB`, et `PHP` (Penser également à appuyer sur `O` puis sur la touche `Entrée` pour valider)
```bash
apt-get install apache2 php mariadb-server
```

![2024-05-21 15_35_44-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/589a6386-427d-4a3b-a2ae-19b9bcde4f75)

Exécuter ensuite la commande suivante pour installer les extensions PHP nécéssaires au bon fonctionnement de GLPI : 
```bash
apt-get install php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu php-ldap
```

![2024-05-21 15_39_46-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/df6aed23-b5fa-4b18-b6c1-f52cded7d804)

### ***Installation et configuration de MariaDB***

Exécuter la commande suivante pour préparer MariaDB à l'hebergement de la base de données de GLPI : 
```bash
mysql_secure_installation
```

![2024-05-21 15_41_27-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/16d86bcb-b2bb-4813-8d9c-331abc1d6b06)

Pour les questions qui seront posées : 
  - Appuyer sur `Entrée` pour la 1ère question (Comme il s'agit de la 1ère installation, il n'y a pas de mot de passe de configuré)
  - Taper `n` à la question `Switch to unix_socket authentication`
  - Taper `Y` à la question `Change the root password`, puis entrer un mot de passe et confirmer une deuxièeme fois ce même mot de passe (Dans notre cas, ce sera `Azerty1*`)
  - Taper `Y` à toutes les autres questions

![2024-05-21 15_45_24-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/92d4d4f0-3da2-4e7d-972e-7c12210024d5)

Exécuter ensuite la commande suivante pour se connecter à MariaDB : 
```bash
mysql -u root -p
```

![2024-05-21 15_45_43-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/45d6e587-ebc3-432e-93d8-2afe32ec365c)

Exécuter ensuite les commandes suivantes afin de créer la base de données `billu_glpi`, ainsi que l'utilisateur `glpi_adm` associé au mot de passe `Azerty1*`
```bash
CREATE DATABASE billu_glpi;
GRANT ALL PRIVILEGES ON billu_glpi.* TO glpi_adm@localhost IDENTIFIED BY "Azerty1*";
FLUSH PRIVILEGES;
EXIT
```

![2024-05-21 15_48_43-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/86a91321-5ff5-4741-96f3-aa77b41f9482)

### ***Téléchargement et installation de GLPI***

Exécuter les commandes suivantes afin de télécharger GLPI à partir du lien [GitHub](https://github.com/glpi-project/glpi/releases/) officiel, dans un dossier temporaire : 
```bash
cd /tmp
wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
```

![2024-05-21 15_51_36-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/180adba0-987f-430f-baad-4632103cca1b)


Exécuter ensuite la commande suivante afin de décompresser l'archive `.tgz` dans le repertoire `/var/www/` ; Le chemin d'accès de GLPI sera donc `/var/www/glpi`
```bash
tar -xzvf glpi-10.0.15.tgz -C /var/www/
```

![2024-05-21 15_52_43-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fb142563-1438-41b0-97b7-267e00932e36)

Exécuter ensuite la commande pour définir l'utilisateur `www-data` (Correspondant à `Apache2`) en tant que propriétaire sur les fichiers GLPI
```bash
chown www-data /var/www/glpi/ -R
```

![2024-05-21 15_53_20-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/571a5485-a5f0-4097-b21c-994712bc2398)

Exécuter ensuite les commandes suivantes pour créer les différents répertoires nécéssaires à GLPI, déplacer les différents repertoires et leurs contenus aux bons endroits, et donner l'autorisation d'accès à l'utilisateur `www-data` à ces différents repertoires : 
```bash
mkdir /etc/glpi
chown www-data /etc/glpi/
mv /var/www/glpi/config /etc/glpi
mkdir /var/lib/glpi
chown www-data /var/lib/glpi/
mv /var/www/glpi/files /var/lib/glpi
mkdir /var/log/glpi
chown www-data /var/log/glpi
```

![2024-05-21 15_57_03-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/96484ed0-5093-47c2-90ae-c3352d028899)

### ***Configuration de GLPI***

Exécuter la commande suivante afin de créer le fichier qui indiquera à GLPI le chemin vers le répertoire de configuration  : 
```bash
nano /var/www/glpi/inc/downstream.php
```

![2024-05-21 15_57_41-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/152506f1-7787-4846-a539-06add00caed9)

Une fois dans l'éditeur, ajouter le contenu ci-dessous : 
```php
<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if (file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
    require_once GLPI_CONFIG_DIR . '/local_define.php';
}
```

![2024-05-21 16_00_13-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/aa10e1ef-9a7a-4a72-af42-e77ac0fcf0f8)

Exécuter ensuite la commande suivante afin de créer le fichier permettant de déclarer les deux variables précisant le chemin vers les repertoires files et log précédemment créés : 
```bash
nano /etc/glpi/local_define.php
```

![2024-05-21 16_00_58-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/2cb5aeb8-ce15-4978-be80-883653996f3e)

Une fois dans l'éditeur, ajouter le contenu ci-dessous :
```php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');
```

![2024-05-21 16_02_37-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/e0a904c3-4cdc-414e-87bc-3727175c69ee)

### ***Configuration de Apache2***

*Pour la configuration du serveur Web Apache2, nous allons créer un fichier un fichier de configuration pour le VirtualHost dédié à GLPI.  
Dans notre cas, le fichier s'appellera `support.billu.net.conf`, en référence au nom de domaine choisi : `support.billu.net`*
