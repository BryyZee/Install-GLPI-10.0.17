#!/bin/bash

# Définir les variables
DB_NAME="glpi_db"
DB_USER="glpi_admin"
DB_PASSWORD="$1"
MYSQL_ROOT_PASSWORD="$2"  # Remplacez cela par votre mot de passe root MySQL

# Exécuter les commandes SQL via mysql
mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE DATABASE $DB_NAME;
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY "$DB_PASSWORD";
FLUSH PRIVILEGES;
EOF

echo "Base de données et utilisateur créés avec succès."
