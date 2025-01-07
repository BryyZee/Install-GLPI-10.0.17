#!/bin/bash

cd /tmp
wget -q --show-progress https://github.com/glpi-project/glpi-inventory-plugin/archive/refs/tags/1.4.0.zip
sudo unzip 1.4.0.zip 1>/dev/null 2>error.log
sudo chown www-data:www-data glpi-inventory-plugin-1.4.0/ -R
sudo mv glpi-inventory-plugin-1.4.0/ /var/www/glpi/plugins/glpiinventory
