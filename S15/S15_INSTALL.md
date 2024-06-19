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


 
# SÉCURITÉ - Mettre en place un serveur de gestion de mot de passe **Passbolt**
	



 
# GESTION DE PROJET/SUIVI DE TÂCHES - Mettre en place un serveur **RedMine** 
	
