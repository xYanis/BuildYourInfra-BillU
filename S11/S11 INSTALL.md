# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

### 1 - Création de 10 GPO de sécurité (Minimum)

1- Politique de mot de passe (complexité, longueur, etc.)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOUserPasswordSecurity.png?raw=true)

2- Verrouillage de compte (blocage de l'accès à la session après quelques erreurs de mot de passe)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOComputerLockWrongPassword.png?raw=true)

3- Restriction d'installation de logiciel pour les utilisateurs non-administrateurs



4- Blocage de l'accès à la base de registre

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOUserRegeditDeny.png?raw=true)

5-Gestion du pare-feu



6- Écran de veille avec mot de passe en sortie

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOUserPasswordScreensaver.png?raw=true)

7- Politique de sécurité PowerShell

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOUserPowershellDeny.png?raw=true)

8- Bloquer l'accès au lecteur C

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/GPOUserDiskCDeny.png?raw=true)

9- Bloquer l'accès à l'AD



10- Interdire la configuration avancée TCP / IP




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

### B - Préparation du serveur GLPI

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

Une fois dans l'éditeur, ajouter le contenu ci-dessous, puis enregistrer le fichier : 
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

Une fois dans l'éditeur, ajouter le contenu ci-dessous, puis enregistrer le fichier :
```php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi/files');
define('GLPI_LOG_DIR', '/var/log/glpi');
```

![2024-05-21 16_02_37-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/e0a904c3-4cdc-414e-87bc-3727175c69ee)

### ***Configuration de Apache2***

*Pour la configuration du serveur Web Apache2, nous allons créer un fichier un fichier de configuration pour le VirtualHost dédié à GLPI.  
Dans notre cas, le fichier s'appellera `support.billu.net.conf`, en référence au nom de domaine choisi : `support.billu.net`*

Exécuter la commande suivante pour la création du rfichier de configuration précédemmenr cité : 
```bash
nano /etc/apache2/sites-available/support.billu.net.conf
```

![2024-05-21 16_05_01-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a5c4d3a6-f9d7-4a4f-b931-86cd6de805a9)

Une fois dans l'éditeur, ajouter le contenu ci-dessous, puis enregistrer le fichier : 
```php
<VirtualHost *:80>
    ServerName support.billu.net

    DocumentRoot /var/www/glpi/public

    # If you want to place GLPI in a subfolder of your site (e.g. your virtual host is serving multiple applications),
    # you can use an Alias directive. If you do this, the DocumentRoot directive MUST NOT target the GLPI directory itself.
    # Alias "/glpi" "/var/www/glpi/public"

    <Directory /var/www/glpi/public>
        Require all granted

        RewriteEngine On

        # Redirect all requests to GLPI router, unless file exists.
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>
</VirtualHost>
```

![2024-05-21 16_11_44-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/882c7a9c-26ac-4d11-9ccb-e18be4b371fb)

Exécuter ensuite la commande suivante pour activer le nouveau site dans `Apache2` : 
```bash
a2ensite support.billu.net.conf
```

Exécuter ensuite la commande suivante pour désactiver le site par défaut, car inutile :
```bash
a2dissite 000-default.conf
```

Exécuter ensuite la commande suivante pour activer le module `Rewrite`, car nius l'avont utilisé dans le fichier de configuration du VirtualHost (`RewriteCond` / `RewriteRule`)
```bash
a2enmod rewrite
```

Exécuter ensuite la commande suivante pour redémarrer le service `Apache2` : 
```bash
systemctl restart apache2
```

![2024-05-21 16_16_52-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/b0ed1786-2639-4fc1-a908-0c67dd854dac)

### ***Installation et configuration de PHP8.2-FMP***

*Du fait de ses meilleures performances et de son indépendance aux autres différents services, il est recommandé d'utiliser le module `PHP8.2-FPM` sur `Apache2`, en lieu et place du module PHP de base*

Exécuter la commande suivante pour installer le module `PHP8.2-FPM` : 
```bash
apt-get install php8.2-fpm
```

![2024-05-21 16_17_57-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a483b34c-7f44-408f-8340-b0ef127e7037)

Exécuter ensuite les commandes suivantes pour activer deux modules dans `Apache2`, activer la configuration de `PHP8.2-FPM`, et enfin redémarrer le service `Apache2` :
```bash
a2enmod proxy_fcgi setenvif
a2enconf php8.2-fpm
systemctl reload apache2
```

![2024-05-21 16_19_05-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d7eada24-8b42-488e-b947-2bc48e2b4638)

Exécuter ensuite la commande suivante pour éditer le fichier de configuration de `PHP8.2-FPM`
```bash
nano /etc/php/8.2/fpm/php.ini
```

![2024-05-21 16_19_35-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a7d55a09-ce7c-42de-9b11-47fa3382a42e)

Une fois dans l'éditeur, rechercher l'option `session.cookie_httponly` et indiquer la valeur `on` pour l'activer, afin de protéger les cookies de GLPI : 
```bash
; Whether or not to add the httpOnly flag to the cookie, which makes it
; inaccessible to browser scripting languages such as JavaScript.
; https://php.net/session.cookie-httponly
session.cookie_httponly = on
```

![2024-05-21 16_24_10-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4e9a5b14-77e3-4f02-b132-a09f3134a9ac)

Exécuter ensuite la commande suivante  pour redémarrer le module PHP8.2-FPM : 
```bash
systemctl restart php8.2-fpm.service
```

![2024-05-21 16_25_06-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/ce16306c-7e7b-42be-b971-8acbc088402b)

Exécuter ensuite la commande suivante pour éditer de nouveau le fichier support.billu.net.conf, afin de préciser à Apache2 d'utiliser le module PHP8.2-FPM pour les fichier PHP : 
```bash
nano /etc/apache2/sites-available/support.billu.net.conf
```

![2024-05-21 16_25_33-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/41e081e0-3638-4f63-9dc2-7163244b1ab9)

Une fois dans l'éditeur, ajouter le contenu ci-dessous (entre les balises `</Directory>` et `</VirtualHost>`, puis enregistrer le fichier : 
```php
<FilesMatch \.php$>
    SetHandler "proxy:unix:/run/php/php8.2-fpm.sock|fcgi://localhost/"
</FilesMatch>
```

![2024-05-21 16_27_35-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/dbaab8d0-8d80-4b11-84d0-1aa8fa8ec1bd)

Pour terminer, exécuter la commande suivante pour redémarrer le service `Apache2` : 
```bash
sudo systemctl restart apache2
```

![2024-05-21 16_28_03-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7374c9d9-f2c0-4573-ac81-2d9f350d16c0)

**La configuration de GLPI est terminée**

### C - Installation du serveur GLPI

### ***Via Interface Graphique***

Dans un premier temps, nous devons nous rendre sur un hôte disposant d'une interface graphique, et connecté sur le même réseau que celui qui heberge le serveur GLPI.  
Dans notre cas, ce sera une VM `WIndows 10 Pro` ayant comme adresse IP `172.19.5.10`

Ouvrir ensuite un navigateur (Par ex : `Edge`) et inscrire l'adresse suivante : `<Adresse_IP_Serveur_GLPI>/install/install.php`  
Nous arrivons dons sur la page ci-dessous :

![2024-05-21 16_29_40-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7d9ddd70-a974-4cbb-bb72-754fefc7ed5a)

Sélectionner Français, puis cliquer sur `OK` : 

![2024-05-21 16_30_00-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/b3d643fe-11d9-4773-a200-b47940d1c3f8)

Lire le contrat de license, puis cliquer sur `Continuer` : 

![2024-05-21 16_30_09-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/6b432556-78e3-45e9-9bbe-d3c438467793)

Comme il s'agit de la 1ère installation, cliquer sur `Installer` : 

![2024-05-21 16_30_25-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/9a328af8-fc72-47af-a834-8e868fecb35f)

Bien vérifier que tous les modules soient bien présents, puis cliquer sur Continuer : 

![2024-05-21 16_30_53-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/72c4c129-eefb-4293-98b7-873ea4030a66)

Arrivé sur l'écran `Etape 1`, entrer les infirlations suivantes : 
 - Serveur SQL : `localhost`
 - Utilisateur SQL : `glpi_adm`
 - Mot de passe SQL : `Azerty1*`

Puis cliquer sur `Continuer` : 

![2024-05-21 16_31_21-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/6b2570c9-51f2-470c-8841-8a136e2b8d85)

Séléctionner la base de données créée précédemment :`billu_glpi`, puis cliquer sur `Continuer` : 

![2024-05-23 10_04_50-QEMU (G1-W10-Client1) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a4634ac0-764f-4463-ba57-4e23c7b85f31)

**L'installation du serveur GLPI est terminée**
