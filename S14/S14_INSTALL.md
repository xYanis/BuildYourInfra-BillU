## JOURNALISATION - Mettre en place une journalisation des scripts PowerShell

*  Secondaire
  
  Modifier les script que l'on veut journaliser en ajoutant au début
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-001.PNG?raw=true)

  Puis à la fin
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-002.PNG?raw=true)

Les journaux sont disponible dans le dossier Logs à la racine de C:\

Nous pouvons aussi consulter les log depuis l'Event Log

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-003.PNG?raw=true)

## **SUPERVISION - Mise en place d'une supervision de l'infrastructure réseau avec ZABBIX**
***Ndlr : Pour tous les champs <mot_de_passe> suivants, nous avons utilisé le même mot de passe : `Azerty1*`***

## Installation  

### 1 . Téléchargement et mise à jour des dépôts ZABBIX :  

```
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update
```

### 2 . Installation de Zabbix Server, Zabbix Frontend, et Zabbix Agent :  

```
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```

### 3 . Installation du socle LAMP :  

```
apt-get install apache2 php mariadb-server
```

### 4 . Création de la base de données initiale :  

```
mysql -uroot -p
<mot_de_passe>
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by *<mot_de_passe>*;
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;
```


```
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

```
mysql -uroot -p
<mot_de_passe>
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
```

### 5 . Edition du fichier `/etc/zabbix/zabbix_server.conf` :   

```
nano /etc/zabbix/zabbix_server.conf
```
Puis ajouter le mot de passe défini précédemment : 

```
DBPassword=<mot_de_passe>
```
### 6 . Démarrage du serveur et des agents ZABBIX

```
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```

## Configuration

Se rendre sur un poste relié au réseau, ouvrir un navigateur web, et entrer l'adresse suivante :  
  
`<Adresse_IP_hôte>/zabbix`

## AD - Nouveau fichier d'utilisateurs à synchroniser dans l'AD
