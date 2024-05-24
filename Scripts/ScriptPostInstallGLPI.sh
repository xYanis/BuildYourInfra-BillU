#!/bin/bash

# Variables de configuration
DB_NAME="billu_glpi"
DB_USER="glpi_adm"
DB_PASS="Azerty1*"
GLPI_URL="http://support.billu.net/glpi"
GLPI_VERSION="10.0.15"  #version glpi

# Mettre à jour le système et installer les dépendances
apt update
apt upgrade -y
apt install apache2 mariadb-server php php-mysql php-xml php-mbstring php-curl php-gd php-imap php-ldap php-apcu php-zip php-json wget tar -y

# Télécharger et décompresser GLPI
cd /var/www/html
wget https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz
tar -xvzf glpi-$GLPI_VERSION.tgz
mv glpi-$GLPI_VERSION glpi
chown -R www-data:www-data /var/www/html/glpi
chmod -R 755 /var/www/html/glpi

# Configurer Apache pour GLPI
bash -c 'cat <<EOT > /etc/apache2/sites-available/glpi.conf
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/glpi
    ServerName support.billu.net
    <Directory /var/www/html/glpi>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/glpi_error.log
    CustomLog \${APACHE_LOG_DIR}/glpi_access.log combined
</VirtualHost>
EOT'
a2ensite glpi.conf
a2enmod rewrite
systemctl restart apache2

# Configurer la base de données MariaDB pour GLPI
mysql -u root -e "CREATE DATABASE $DB_NAME;"
mysql -u root -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Attendre que le serveur soit prêt
sleep 10

# Installe les tables de base de données
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < /var/www/html/glpi/install/mysql/glpi-empty.sql

# Configurer les paramètres par défaut
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
INSERT INTO glpi_configs (context, name, value) VALUES ('core', 'base_url', '$GLPI_URL');
UPDATE glpi_users SET password = MD5('glpi') WHERE username = 'glpi';
EOF

echo "Installation de GLPI terminée. Accédez à $GLPI_URL pour finaliser l'installation."
