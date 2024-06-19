# MESSAGERIE - Mettre en place un serveur de messagerie **Zimbra**


## 1 Mise en place du conteneur 

Nous allons mettre en place un conteneur pour accueillir Zimbra, avec les configurations ci dessous :

Hostname : `mail` (Indispensable)
Mot de passe : `Azerty1*`

Template : `Ubuntu 20.04` (Indispensable)

Disk : `10 Go` dans l'emplacement `local-datas`
CPU : 2 coeurs
RAM : `6 Go`

Network : `IPv4 172.19.0.50/24` (Adresse IP de notre conteneur)
Gateway : `172.19.0.254` (Passerelle du routeur)

DNS domain : `billu.lan` (Le même nom que le domaine de notre DC)
DNS servers : `172.19.0.2` (Adresse IP de notre serveur DNS)


![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/9aa5cd43-4bc0-4e25-b109-8f82231a386c)



![image2](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/dbc0de71-c7d4-4dc3-b7e5-a20d052c3595)




![image3](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/0392f24b-2ace-40cb-8bda-5d09e725672e)




![image4](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/cf1a7b40-0fb3-44da-b864-0bea8126c7e9)




![image6](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/e1697323-2793-41a9-bdfd-40a7afe0f5db)





![image7](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/2163942e-7e4d-42fa-89f9-ea8e4810f32e)



![image8](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/324869eb-1c0b-4ad7-8f02-8ad8100a410c)




![image9](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/873b4e0f-b810-4ed5-bf65-592bfa336919)


## 2 Configuration du DNS 

Sur le serveur principal, dans le DNS Manager, il faudra enregistrer un hôte A et un Mail Exchanger MX
Ci-dessous les configurations à respecter : 

![image10](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/36b40288-e7e8-44ec-b54a-87fb4df9897c)




![image11](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/53e3a8fc-7b38-48c6-ab80-9854c5dcf33e)



## 3 Installation de Zimbra sur le conteneur 

Mise à jour d'Ubuntu 

```bash
sudo apt update && sudo apt upgrade -y
```

Installation du paquet *GNUPG*, nécessaire à la récupération de la clé GPG de Zimbra 

```bash
sudo apt install -y gnupg gnupg1 gnupg2
```

Arrêt et désinstallation du service POSTFIX ( service mail d'origine installé )

```bash
sudo systemctl stop postfix
```
```bash
sudo apt remove postfix -y
```

Téléchargement de l'archive de Zimbra 8.8.15

```bash
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
```

Décompression de l'archive 

```bash
tar xzf zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
```

Déplacement vers le dossier Zimbra

```bash
cd zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954
```

Execution du script de l'installation de Zimbra

```bash
./install.sh
```

## 4 Menu d'installation Zimbra

Après l'execution du script d'installation, plusieurs choix s'offrent à vous, ci dessous ce qu'il faudra indiqué :

```bash
 Do you agree with the terms of the software license agreement? [N] Y 
```

```bash
Use Zimbra's package repository [Y] Y
```

```bash
Select the packages to install

Install zimbra-ldap [Y] Y
Install zimbra-logger [Y] Y
Install zimbra-mta [Y] Y
Install zimbra-dnscache [Y] Y
Install zimbra-snmp [Y] Y
Install zimbra-store [Y] Y
Install zimbra-apache [Y] Y
Install zimbra-spell [Y] Y
Install zimbra-memcached [Y] Y
Install zimbra-proxy [Y] Y
Install zimbra-drive [Y] N
Install zimbra-imapd (BETA - for evaluation only) [N] N
Install zimbra-chat [Y] N
```

```bash
The system will be modified.  Continue? [N] Y
```

```bash
Main menu

   1) Common Configuration:
   2) zimbra-ldap:                             Enabled
   3) zimbra-logger:                           Enabled
   4) zimbra-mta:                              Enabled
   5) zimbra-dnscache:                         Enabled
   6) zimbra-snmp:                             Enabled
   7) zimbra-store:                            Enabled
        +Create Admin User:                    yes
        +Admin user to create:                 admin@billu.lan
******* +Admin Password                        UNSET
        +Anti-virus quarantine user:           virus-quarantine.2cu4xh2hd@billu.lan
        +Enable automated spam training:       yes
        +Spam training user:                   spam.guxl4gg2za@billu.lan
        +Non-spam(Ham) training user:          ham.5e2sctqp@billu.lan
        +SMTP host:                            mail.billu.lan
        +Web server HTTP port:                 8080
        +Web server HTTPS port:                8443
        +Web server mode:                      https
        +IMAP server port:                     7143
        +IMAP server SSL port:                 7993
        +POP server port:                      7110
        +POP server SSL port:                  7995
        +Use spell check server:               yes
        +Spell server URL:                     http://mail.billu.lan:7780/aspell.php
        +Enable version update checks:         TRUE
        +Enable version update notifications:  TRUE
        +Version update notification email:    admin@billu.lan
        +Version update source email:          admin@billu.lan
        +Install mailstore (service webapp):   yes
        +Install UI (zimbra,zimbraAdmin webapps): yes
   8) zimbra-spell:                            Enabled
   9) zimbra-proxy:                            Enabled
  10) Default Class of Service Configuration:
   s) Save config to file
   x) Expand menu
   q) Quit

Address unconfigured (**) items  (? - help) 7
```

```bash
Store configuration

   1) Status:                                  Enabled
   2) Create Admin User:                       yes
   3) Admin user to create:                    admin@billu.lan
** 4) Admin Password                           UNSET
   5) Anti-virus quarantine user:              virus-quarantine.2cu4xh2hd@billu.lan
   6) Enable automated spam training:          yes
   7) Spam training user:                      spam.guxl4gg2za@billu.lan
   8) Non-spam(Ham) training user:             ham.5e2sctqp@billu.lan
   9) SMTP host:                               mail.billu.lan
  10) Web server HTTP port:                    8080
  11) Web server HTTPS port:                   8443
  12) Web server mode:                         https
  13) IMAP server port:                        7143
  14) IMAP server SSL port:                    7993
  15) POP server port:                         7110
  16) POP server SSL port:                     7995
  17) Use spell check server:                  yes
  18) Spell server URL:                        http://mail.billu.lan:7780/aspell.php
  19) Enable version update checks:            TRUE
  20) Enable version update notifications:     TRUE
  21) Version update notification email:       admin@billu.lan
  22) Version update source email:             admin@billu.lan
  23) Install mailstore (service webapp):      yes
  24) Install UI (zimbra,zimbraAdmin webapps): yes

Select, or 'r' for previous menu [r] 4
```


```bash
Password for admin@testdomain1.com (min 6 characters): [********] Azerty1*
```

```bash
Store configuration

   1) Status:                                  Enabled
   2) Create Admin User:                       yes
   3) Admin user to create:                    admin@billu.lan
   4) Admin Password                           set
   5) Anti-virus quarantine user:              virus-quarantine.2cu4xh2hd@billu.lan
   6) Enable automated spam training:          yes
   7) Spam training user:                      spam.guxl4gg2za@billu.lan
   8) Non-spam(Ham) training user:             ham.5e2sctqp@billu.lan
   9) SMTP host:                               mail.billu.lan
  10) Web server HTTP port:                    8080
  11) Web server HTTPS port:                   8443
  12) Web server mode:                         https
  13) IMAP server port:                        7143
  14) IMAP server SSL port:                    7993
  15) POP server port:                         7110
  16) POP server SSL port:                     7995
  17) Use spell check server:                  yes
  18) Spell server URL:                        http://mail.billu.lan:7780/aspell.php
  19) Enable version update checks:            TRUE
  20) Enable version update notifications:     TRUE
  21) Version update notification email:       admin@billu.lan
  22) Version update source email:             admin@billu.lan
  23) Install mailstore (service webapp):      yes
  24) Install UI (zimbra,zimbraAdmin webapps): yes

Select, or 'r' for previous menu [r] r
```

```bash
Main menu

   1) Common Configuration:
   2) zimbra-ldap:                             Enabled
   3) zimbra-logger:                           Enabled
   4) zimbra-mta:                              Enabled
   5) zimbra-dnscache:                         Enabled
   6) zimbra-snmp:                             Enabled
   7) zimbra-store:                            Enabled
   8) zimbra-spell:                            Enabled
   9) zimbra-proxy:                            Enabled
  10) Default Class of Service Configuration:
   s) Save config to file
   x) Expand menu
   q) Quit

*** CONFIGURATION COMPLETE - press 'a' to apply
Select from menu, or press 'a' to apply config (? - help) a
Save configuration data to a file? [Yes] yes
Save config in file: [/opt/zimbra/config.*****]
Saving config in /opt/zimbra/config.*****...done.
The system will be modified - continue? [No] yes
Operations logged to /tmp/zmsetup.********-******.log
```

```bash
You have the option of notifying Zimbra of your installation.
This helps us to track the uptake of the Zimbra Collaboration Server.
The only information that will be transmitted is:
        The VERSION of zcs installed (8.8.15_GA_4179_UBUNTU20_64)
        The ADMIN EMAIL ADDRESS created (admin@mail.billu.lan)

Notify Zimbra of your installation? [Yes] no
Notification skipped
Checking if the NG started running...done.
Setting up zimbra crontab...done.


Moving /tmp/zmsetup.20220615-125142.log to /opt/zimbra/log


Configuration complete - press return to exit
[Press ENTER]

root@mail:/tmp/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954#
```

```bash
root@mail:~# su zimbra
zimbra@mail:/root$
zimbra@mail:/root$ zmcontrol status
Host mail.billu.lan
        amavis                  Running
        antispam                Running
        antivirus               Running
        dnscache                Running
        ldap                    Running
        logger                  Running
        mailbox                 Running
        memcached               Running
        mta                     Running
        opendkim                Running
        proxy                   Running
        service webapp          Running
        snmp                    Running
        spell                   Running
        stats                   Running
        zimbra webapp           Running
        zimbraAdmin webapp      Running
        zimlet webapp           Running
        zmconfigd               Running
zimbra@mail:/root$
```

## 5 Configuration Zimbra ( interface Web )







 
# SÉCURITÉ - Mettre en place un serveur de gestion de mot de passe **Passbolt**
	
Création d'un conteneur avec une image debian 12 avec comme configuration 2GO de RAM, 2 cores, 8GO de stockage et une carte réseau configurer en 172.19.0.25/24 avec comme passerelle l'interface du routeur VyOS (172.19.0.254) et désactivation du firewall

Dans un premier temps télécharger curl avec la commande:

`apt-get instal curl`

Puis télécharger et lancer le script de Passbolt via:

`curl -LO https://download.passbolt.com/ce/installer/passbolt-repo-setup.ce.sh`

`bash ./passbolt-repo-setup.ce.sh`

Installer Passbolt

`apt install passbolt-ce-server`

Configuration de mariadb

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/configure_mysql.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-06-19%20175159.png?raw=true)

![]([https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/mysql_admin_user_pass.png?raw=true](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/mysql_admin_user_pass.png?raw=true))

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-06-19%20175419.png?raw=true)

![]([https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/passbolt_db_user_pass.png?raw=true](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-06-19%20175811.png?raw=true))

 Configuration de Passbolt

Sur une machine avec interface graphique et navigateur internet, lancer un navigateur et taper dans la barre d'addresse

`http://adresse_ip_serveur_passbolt`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-19%20at%2014-42-46%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-19%20at%2014-43-03%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Dans la deuxieme partie de la configuration faire comme ci dessous

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-06-19%20180247.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-19%20at%2015-23-48%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Après la configuration la page vous invite à installer le plug in passbolt

Ensuite on vous demande une passphrase ici : jemangedescaillou

Création d'un mot de passe dans Passbolt

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-19%20at%2017-37-17%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Sur la prochaine image nous voyons une petite clé blanche sur fond rouge et si on clique dessus on peut voir la gestion de mot de passe que nous venons de créer et il vous sera demander votre passphrase

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-06-19%20at%2017-38-51%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)
 
# GESTION DE PROJET/SUIVI DE TÂCHES - Mettre en place un serveur **RedMine** 
	
