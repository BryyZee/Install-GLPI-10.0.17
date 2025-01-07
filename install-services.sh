#!/bin/bash

# Mise à jour des paquets et installation des services
echo "Mise à jour des paquets nécessaires..."
apt-get update 1>/dev/null 2>error.log
echo "Installation des services nécessaires..."
apt-get upgrade -y 1>/dev/null 2>error.log
echo "Installation des services Apache2, PHP, et MariaDB..."
apt-get install apache2 php mariadb-server -y 1>/dev/null 2>error.log

# Installation des extensions PHP nécessaires pour GLPI
echo "Installation des extensions PHP nécessaires pour GLPI..."
apt-get install expect php-xml php-common php-json php-mysql php-mbstring php-curl php-gd php-intl php-zip php-bz2 php-imap php-apcu -y 1>/dev/null 2>error.log

echo "Installation de php8.2-fpm..."
apt-get install php8.2-fpm 1>/dev/null 2>error.log
