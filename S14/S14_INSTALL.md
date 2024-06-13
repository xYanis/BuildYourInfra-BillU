## JOURNALISATION - Mettre en place une journalisation des scripts PowerShell
*  Secondaire

## SUPERVISION - Mise en place d'une supervision de l'infrastructure réseau avec **ZABBIX**

## Instalation
### 1. Télécharger et mettre à jour les dépots Zabbix:
- wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
- dpkg -i zabbix-release_7.0-1+debian12_all.deb
- apt update

### 2. Installez Zabbix server, frontend, agent:
- apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

### 3. Creer la base de données initiale: 
- mysql -uroot -p
- *password*
- mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
- mysql> create user zabbix@localhost identified by *password*;
- mysql> grant all privileges on zabbix.* to zabbix@localhost;
- mysql> set global log_bin_trust_function_creators = 1;
- mysql> quit;
  
- zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix 
- mysql -uroot -p
- *password*
- mysql> set global log_bin_trust_function_creators = 0;
- mysql> quit;
### 4. Editer le fichier /etc/zabbix/zabbix_server.conf
- DBPassword=password
### 5. Start Zabbix server and agent processes 
- systemctl restart zabbix-server zabbix-agent apache2
- systemctl enable zabbix-server zabbix-agent apache2 


## AD - Nouveau fichier d'utilisateurs à synchroniser dans l'AD
