# Installation Automatisée de GLPI 10.0.17 avec le Plugin GLPI Inventory 1.4.0

Ce dépôt contient une série de scripts bash pour automatiser l'installation de **GLPI 10.0.17** ainsi que l'option d'installer le **plugin GLPI Inventory 1.4.0**. Ces scripts facilitent le déploiement de GLPI sur une machine avec Apache, PHP, et MariaDB, tout en configurant les permissions et en installant le plugin GLPI Inventory si nécessaire.

## Prérequis

- Système basé sur Debian/Ubuntu.
- Accès root ou sudo pour installer des paquets et effectuer des configurations système.
- Une connexion Internet pour télécharger les paquets et dépendances nécessaires.

## Installation

### Étape 1 : Configuration des permissions

Avant de lancer les scripts, assurez-vous de configurer les permissions correctement. Exécutez les commandes suivantes dans le répertoire contenant les scripts :

```bash
sudo chown www-data:www-data -R .
sudo chmod +x *.sh
