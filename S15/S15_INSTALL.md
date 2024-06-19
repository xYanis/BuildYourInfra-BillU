# MESSAGERIE - Mettre en place un serveur de messagerie **Zimbra**


## 1 Mise en place du conteneur 

*Pré requis :* 

6GB de mémoire vive 

2 cores 


![image](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/9aa5cd43-4bc0-4e25-b109-8f82231a386c)



![image2](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/dbc0de71-c7d4-4dc3-b7e5-a20d052c3595)




![image3](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/0392f24b-2ace-40cb-8bda-5d09e725672e)




![image4](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/cf1a7b40-0fb3-44da-b864-0bea8126c7e9)



sudo apt update && sudo apt upgrade -y

sudo apt install -y gnupg gnupg1 gnupg2

sudo systemctl stop postfix

sudo apt remove postfix -y

wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz

tar xzf zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz

cd zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954

./install.sh



 
# SÉCURITÉ - Mettre en place un serveur de gestion de mot de passe **Passbolt**
	



 
# GESTION DE PROJET/SUIVI DE TÂCHES - Mettre en place un serveur **RedMine** 
	
