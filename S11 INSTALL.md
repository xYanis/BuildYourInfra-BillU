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

Une fois connecté en `root` sur la VM Debian, éxécuter la commande suivant afin de mettre à jour le système : 
```bash
sudo apt-get update && sudo apt-get upgrade
```

![2024-05-21 15_34_29-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/02f557df-c517-4f43-bf0e-8e48a7b47390)


Exécuter ensuite la commande suivante afin d'installer les paquets `Apache2`, `Maria DB`, et `PHP` (Penser également à appuyer sur `O` puis sur la touche `Entrée` pour valider)
```bash
sudo apt-get install apache2 php mariadb-server
```

![2024-05-21 15_35_44-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/589a6386-427d-4a3b-a2ae-19b9bcde4f75)

Exécuter ensuite la commande suivante pour installer les extensions PHP nécéssaires au bon fonctionnement de GLPI : 
```bash
sudo apt-get install php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu php-ldap
```

![2024-05-21 15_39_46-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/df6aed23-b5fa-4b18-b6c1-f52cded7d804)

Exécuter la commande suivante pour préparer MariaDB à l'hebergement de la base de données de GLPI : 
```bash
sudo mysql_secure_installation
```

![2024-05-21 15_41_27-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/16d86bcb-b2bb-4813-8d9c-331abc1d6b06)

Pour les questions qui seront posées : 
  - Appuyer sur `Entrée` pour la 1ère question (Comme il s'agit de la 1ère installation, il n'y a pas de mot de passe de configuré)
  - Taper `n` à la question `Switch to unix_socket authentication`
  - Taper `Y` à la question `Change the root password`, puis entrer un mot de passe et confirmer une deuxièeme fois ce même mot de passe (Dans notre cas, ce sera `Azerty1*`)
  - Taper `Y` à toutes les autres questions

![2024-05-21 15_45_24-QEMU (G1-DebianServer) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/92d4d4f0-3da2-4e7d-972e-7c12210024d5)

