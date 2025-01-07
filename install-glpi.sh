#!/bin/bash

path_base=$(pwd)

# Téléchargement et installation de GLPI 10.0.17
echo "Téléchargement de GLPI 10.0.17..."
cd /tmp
wget -q --show-progress https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz

echo "Décompression de l'archive GLPI dans /var/www/..."
tar -xzvf glpi-10.0.17.tgz -C /var/www/ 1>/dev/null 2>error.log

# Changement de propriétaire pour les fichiers de GLPI
echo "Changement de propriétaire des fichiers GLPI..."
chown www-data:www-data /var/www/glpi/ -R

# Configuration de GLPI
echo "Configuration des répertoires de GLPI..."
mkdir /etc/glpi
chown www-data:www-data /etc/glpi/
mv /var/www/glpi/config /etc/glpi

mkdir /var/lib/glpi
chown www-data:www-data /var/lib/glpi/
mv /var/www/glpi/files /var/lib/glpi

mkdir /var/log/glpi
chown www-data:www-data /var/log/glpi

# Déplacement de fichiers de configuration personnalisés
cd $path_base
echo "Déplacement des fichiers de configuration personnalisés..."
mv downstream.php /var/www/glpi/inc/
mv local_define.php /etc/glpi/
