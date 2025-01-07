#!/bin/bash

path_base=$(pwd)

# Téléchargement et installation de GLPI 10.0.17
echo "Téléchargement de GLPI 10.0.17..."
cd /tmp
wget -q --show-progress https://github.com/glpi-project/glpi/releases/download/10.0.17/glpi-10.0.17.tgz

echo "Décompression de l'archive GLPI dans /var/www/..."
sudo tar -xzvf glpi-10.0.17.tgz -C /var/www/ 1>/dev/null 2>error.log

# Changement de propriétaire pour les fichiers de GLPI
echo "Changement de propriétaire des fichiers GLPI..."
sudo chown www-data:www-data /var/www/glpi/ -R

# Configuration de GLPI
echo "Configuration des répertoires de GLPI..."
sudo mkdir /etc/glpi
sudo chown www-data:www-data /etc/glpi/
sudo mv /var/www/glpi/config /etc/glpi

sudo mkdir /var/lib/glpi
sudo chown www-data:www-data /var/lib/glpi/
sudo mv /var/www/glpi/files /var/lib/glpi

sudo mkdir /var/log/glpi
sudo chown www-data:www-data /var/log/glpi

# Déplacement de fichiers de configuration personnalisés
cd $path_base
echo "Déplacement des fichiers de configuration personnalisés..."
sudo mv downstream.php /var/www/glpi/inc/
sudo mv local_define.php /etc/glpi/
