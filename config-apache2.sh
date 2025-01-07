#!/bin/bash

# Configuration Apache pour GLPI
echo "Configuration du fichier de site Apache pour GLPI..."
sudo mv glpi-administratif.conf /etc/apache2/sites-available/

# Activation du site Apache et des modules nécessaires
echo "Activation du site GLPI dans Apache..."
sudo a2ensite glpi-administratif.conf 1>/dev/null 2>error.log
echo "Activation des modules Apache nécessaires (rewrite, ssl)..."
sudo a2enmod rewrite 1>/dev/null 2>error.log
sudo a2enmod ssl 1>/dev/null 2>error.log

# Désactivation du site par défaut Apache et redémarrage du service
echo "Désactivation du site par défaut Apache et redémarrage du service Apache..."
sudo a2dissite 000-default.conf 1>/dev/null 2>error.log
#sudo systemctl restart apache2

# Activation de PHP-FPM et rechargement d'Apache
echo "Activation de PHP-FPM pour PHP 8.2 et rechargement d'Apache..."
sudo a2enmod proxy_fcgi setenvif 1>/dev/null 2>error.log
sudo a2enconf php8.2-fpm 1>/dev/null 2>error.log
#sudo systemctl restart apache2

# Modification de la configuration PHP pour activer cookie_httponly
echo "Modification de la configuration PHP pour activer session.cookie_httponly..."
sudo sed -i 's/^;session.cookie_secure\s*=\s*.*/session.cookie_secure = on/' "/etc/php/8.2/fpm/php.ini"
sudo sed -i 's/^session.cookie_httponly\s*=\s*.*/session.cookie_httponly = on/' "/etc/php/8.2/fpm/php.ini"

# Redémarrage du service PHP-FPM pour appliquer la modification
echo "Redémarrage du service PHP-FPM..."
sudo systemctl restart php8.2-fpm.service
sudo systemctl restart apache2
