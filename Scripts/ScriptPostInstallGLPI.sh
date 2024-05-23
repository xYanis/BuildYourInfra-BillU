#!/bin/bash

DB_NAME="billu_glpi"
DB_USER="glpi_adm"
DB_PASS="Azerty1*"
GLPI_URL="http://support.billu.net/glpi"

# Attend que le serveur soit prêt
sleep 10

# Installe les tables de base de données
sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < /var/www/glpi/install/mysql/glpi-empty.sql

# Configurer les paramètres par défaut
sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
INSERT INTO glpi_configs (context, name, value) VALUES ('core', 'base_url', '$GLPI_URL');
UPDATE glpi_users SET password = MD5('glpi') WHERE username = 'glpi';
EOF

echo "Installation de GLPI terminée. Accédez à $GLPI_URL pour finaliser l'installation."
