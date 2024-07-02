
TSSR-2402-P3-G1-BuildYourInfra-BillU
INSTALL GUIDE Infrastructure sécurisée pour BillU
Sommaire
1 - FreePBX

Installation

Pré-requis: 1 Go de RAM et 20 Go de disque dur

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

```bash
localectl set-locale LANG=fr_FR.utf8
localectl set-keymap fr
localectl set-x11-keymap fr```



