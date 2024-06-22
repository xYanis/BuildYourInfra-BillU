# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

# Sommaire 
# 1 Serveur de messagerie **Zimbra**
# 2 Mettre en place un serveur de gestion de mot de passe **Passbolt**
# 3 Mettre en place un serveur de gestion de projet **RedMine** 






## MESSAGERIE - Mettre en place un serveur de messagerie **Zimbra**


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

## 6 Installation et configuration de Thunderbird (Client de messagerie)

***Ndlr : Dans ce chapitre, nous allons installer et utiliser Thunderbird sous Windows 10 Pro***

Dans un premier temps, se rendre sur le site officiel de Thunderbird pour télécharger la dernière version de [Thunderbird](https://www.thunderbird.net/fr/thunderbird/all/)

Pour des raisons pratiques, nous allons télécharger la version `64-bit (.msi)`, potentiellement déployable sur des postes via une GPO

![2024-06-20 18_27_54-Télécharger — Thunderbird](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d62d4af4-6b31-4cfa-811c-b2fbe0e74de7)

Une fois téléchargée, le fichier `.msi` devrait apparaître dans le dossier `Téléchargements`

![2024-06-20 17_46_43-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a8608dff-92a6-48fc-b297-ae6d2667c177)

Double-cliquer dessus, et attendre la fin de l'installation : 

![2024-06-20 17_47_34-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/082b16da-e2d5-4821-bd02-3433c2219ad0)

Une fois Thunderbird installé, l'éxécuter

Au 1er démarrage, cet écran apparaît : 

![2024-06-20 17_58_55-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a555737d-7db5-4e50-a35c-682bdea357e5)

Entrer une adresse mail, préalablement créée via l'interface web de Zimbra ; Dans notre cas, il s'agira de `Camille Martin` : 

![2024-06-20 17_59_51-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/4ec73f35-ade6-494a-92c4-c9066803c881)

Une fois l'adresse et le mot de passe entrés, Thunderbird cherchera (*et trouvera !*) le serveur mail correspondant au domaine `billu.lan`

![2024-06-20 18_01_21-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/888facac-2a96-4f92-8515-cee5a6727b3d)

Une fois la configuration validée, Thunderbird fera apparaître un pop-up indiquant l'ajout d'une exception de sécurité pour le serveur `mail.billu.lan`, cliquer sur `Confirmer l'exeption de sécurité` en laissant la case `Conserver cette exception de façon permanente` cochée : 

![2024-06-20 18_01_51-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7ea6386b-4aa2-466f-8353-cb27c43ec0f4)

Une fois validée, une fenêtre indiquera que la création du compte de messagerie a été réussie : 

![2024-06-20 18_02_56-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/169360e0-977e-43ee-b4a7-a8af0b56b9e0)

Un pop-up apparaîtra pour demander de définir Thunderbird par défaut pour la lecture des e-mails et autres, laisser tout coché et appuyer sur `Définir par défaut` :

![2024-06-20 18_03_13-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d88a597c-0cac-45c7-b39b-9c6742679737)

Le compte nouvellement créé appraîtra sur la gauche de Thunderbird : 

![2024-06-20 18_03_30-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7e7a018d-9e0a-42d8-8698-bd71f8dac178)

Dans le cas de l'ajout d'un nouveau compte, il faut : 
- Faire un clic-droit sur un compte de messagerie existant
- Cliquer sur `Paramètres`
- Cliquer sur `Gestion des comptes`
- Cliquer sur `Ajouter un compte de messagerie`

![2024-06-20 18_04_21-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/eb063d64-a9a9-4ac6-8561-a05c4f12ce5a)

Pour les besoins du projet, nous avons créé un deuxième compte, pour tester le bon fonctionnement de l'envoi/reception de mails : 

![2024-06-20 18_09_39-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/58522c78-3ea0-44d4-a96a-7a43257006da)

ATTENTION : Lors du 1er envoi de mail, un pop-up similaire à celui affiché lors de la création de compte appraîtra, il faudra procéder de la même manière que précédemment : 

![2024-06-20 18_08_15-wcs-cyber-node05 - Proxmox Virtual Environment](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a84e7337-6040-42ea-a47f-cadcc2ae9627)

**Thunderbird est dorénavant configuré !**

# 2 SÉCURITÉ - Mettre en place un serveur de gestion de mot de passe **Passbolt**
	
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

## Installation à partir d'un CT Template Turnkey-Redmine

 
![Capture d'écran 2024-06-20 095846](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/40eaffb4-6488-4512-9758-93e2b8f914b3)

![Capture d'écran 2024-06-20 100046](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/3bb43099-29c5-489a-8777-81934dedaf58)

![Capture d'écran 2024-06-20 100121](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/c166fc58-b708-41d6-ad6b-3cefdf314e00)

![Capture d'écran 2024-06-20 100153](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/6db9e39f-9af9-4938-9bde-9f0404671511)

![Capture d'écran 2024-06-20 100231](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/9501ffde-e858-4429-acef-2695ec1275d8)

![Capture d'écran 2024-06-20 100312](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/22667f13-1b3d-4577-9094-7a3cdabc1c64)

![Capture d'écran 2024-06-20 100344](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/a5f2bb62-8f3b-405e-8089-648ff438043f)

![Capture d'écran 2024-06-20 100359](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/87188798-114d-4a26-bd76-ec900017e704)

![Capture d'écran 2024-06-20 143545](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/160050170/2f4bf427-71cb-4cc1-ad35-963ae1516cb8)



