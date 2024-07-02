
# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

### Sommaire

1 - FreePBX

👉 Installation

✔️ Pré-requis: 1 Go de RAM et 20 Go de disque dur

L'ISO peut se récupérer ![ici](https://www.freepbx.org/downloads/)

Au démarrage de la VM, dans la liste, choisir la version recommandée.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX001.png?raw=true)

Puis sélectionner `Graphical Installation - Output to VGA`.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX002.png?raw=true)

Enfin choisir `FreePBX Standard`

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX003.png?raw=true)

Pendant l'installation, il faut configurer le mot de passe root (`Root password is not set` s'affiche).

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX004.png?raw=true)

Clique sur ROOT PASSWORD et entre un mot de passe (robuste, est-il besoin de le préciser ?) pour le compte root.

Le clavier est en anglais donc attention aux lettres des touches du clavier QWERTY !

Puis rebbot la machine à la fin de l'installation

Au redémarrage de la machine, se connecter en root et changer le clavier en FR en tapant

``` bash
localectl set-locale LANG=fr_FR.utf8
localectl set-keymap fr
localectl set-x11-keymap fr
```

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX007.png?raw=true)

Puis changer la configuration IP en tapant!

``` bash
nano /etc/sysconfig/network-scripts/ifcfg-eth0
```

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX006.png?raw=true)

💻 Connexion en web

A partir de ton navigateur web, connecte-toi sur l'adresse du serveur et tu arriveras sur l'interface de gestion de FreePBX. Ici j'ai pointé le DNS pour pouvoir y accéder en tapant http://freepbx comme URL

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX009.png?raw=true)

⚙️ Démarrage et première configuration

Par l'interface web, connecte-toi en root sur la VM avec le mot de passe associé (à mettre 2 fois).

Indique également une addresse mail pour les notifications et clique sur Setup System

Dans la fenêtre, clique sur FreePBX Administration et reconnecte-toi en root.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX010.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX011.png?raw=true)

Laisse les langages par défaut et clique sur Submit

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX012.png?raw=true)

A la fenêtre d'activation du firewall, clique sur Abort

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX013.png?raw=true)

A la fenêtre de l'essais de SIP Station clique sur Not Now

Tu arrive sur le tableau de bord, clique sur Apply Config (en rouge)pour valider tout ce que tu viens de faire

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX014.png?raw=true)

💻 Activation du serveur

Cette activation n'est pas obligatoire, mais elle permet d'avoir accès à l'ensemble des fonctionnalités du serveur.

Va dans le menu Admin puis System Admin.

[](https://github.com/WildCodeSchool/TSSR_Resources/blob/main/Ressources_quetes/freePBX-16.png?raw=true)

Un message indique que le système n'est pas activé.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX015.png?raw=true)

Clique sur Activation puis Activate

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX016.png?raw=true)

Dans la fenêtre qui s'affiche, clique sur Activate

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX017.png?raw=true)

Entre une adresse email et attend quelques instant.

Dans la fenêtre qui s'affiche, renseigne les différentes informations, et :

    Pour Which best describes you mets I use your products and services with my Business(s) and do not want to resell it
    Pour Do you agree to receive product and marketing emails from Sangoma ? coche No
    Clique sur Create

![](https://github.com/WildCodeSchool/TSSR_Resources/blob/main/Ressources_quetes/freePBX-19.png?raw=true)

Dans la fenêtre d'activation, clique sur Activate et attends que l'activation se fasse.

Dans les fenêtres qui s'affichent, clique sur Skip.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX018.png?raw=true)

🗓️ Update des modules du serveur

La fenêtre de mise-à-jour des modules va s'afficher automatiquement.

Clique sur Update Now.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX019.png?raw=true)

Attend la mise-à-jour de tous les modules.

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX020.png?raw=true)

Une fois que tout est terminé, clique sur Apply config.

Il peut y avoir des erreurs sur le serveurs suite à la mise-à-jour des modules et dans ce cas, l'accès au serveur ne se fait pas.

Les modules incriminés sont précisés et il faut les réinstaller et les activer.

Dans ce cas, sur le serveur en CLI, exécute les commandes suivantes :

fwconsole ma install <module>

fwconsole ma enable <module>

Par exemple pour les modules userman, voicemail, et sysadmin :

fwconsole ma install userman

fwconsole ma enable userman

fwconsole ma install voicemail

fwconsole ma enable voicemail

fwconsole ma install sysadmin

fwconsole ma enable sysadmin

Va sur le serveur en CLI et exécute la commande yum update pour faire la mise-à-jour du serveur.

Répond y lorsque cela sera demandé.

Redémarre le serveur

🗓️ Update complémentaire des modules

Connecte-toi en root via la console web, et vas dans le Dashboard pour voir s'il te manque des modules.

Vas dans le menu Admin puis Modules Admin, et dans l'onglet Module Update.

Dans la fenêtre qui s'affiche, dans la colonne Status, sélectionne ceux qui sont en Disabled; Pending Upgrade... et qui ont une licence GPL.

Sélectionne alors le bouton Upgrade to ....

Quand tu as géré tous les modules, clique sur Process.

Dans la fenêtre qui apparaît, clique sur Confirm.

Quand tout est terminé, clique sur Apply config.

🏗️ Création d'utilisateurs et de lignes sur le serveur

Va dans le menu Applications puis Extensions

Va sur sur l'onglet SIP [chan_pjsip] Extensions puis ici je choisi un utilisateurs de l'AD (Erwan Faure et Camille Martin pour l'exemple )

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX023.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX021.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX022.png?raw=true)

🔬 Installation du logiciel SIP sur les postes clients

Prendre la source ![ici](https://github.com/WildCodeSchool/TSSR-2402-P3-G4-BuildYourInfra-Pharmgreen/blob/main/Ressources/3cxphone6%20(1).msi)

⚙️ Configuration du logiciel SIP

Sur l'écran du SIP phone, clique sur Set account pour avoir la fenêtre Accounts.

En cliquant sur New, la fenêtre de création de compte Account settings apparaît.

💬 Communication entre les postes

En cliquant sur l'icone contact ( le troisieme en partant de la gauche en bas )

Nous ajoutons sur nos deux postes le contact de l'autre puis nous pouvons les appeller sans taper leur numéro

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX024.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/FreePBX026.png?raw=true)





