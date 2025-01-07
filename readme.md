# Installation Automatisée de GLPI 10.0.17 avec le Plugin GLPI Inventory 1.4.0

Ce dépôt contient une série de scripts bash pour automatiser l'installation de **GLPI 10.0.17** ainsi que l'option d'installer le **plugin GLPI Inventory 1.4.0**. Ces scripts facilitent le déploiement de GLPI sur une machine avec Apache, PHP, et MariaDB, tout en configurant les permissions.

L'utilisateur a la possibilité d'installer le plugin **GLPI Inventory 1.4.0** selon ses besoins. Cela peut être activé ou désactivé lors de l'exécution des scripts.

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
```

### Étape 2 : Exécution du script d'installation

Pour démarrer l'installation, exécutez le script `install.sh` avec des droits d'administration. Assurez-vous d'utiliser `sudo` ou un compte root pour lancer le script, car celui-ci nécessite des privilèges élevés pour installer et configurer les composants système.

```bash
sudo ./install.sh
```

Pendant l'exécution du script, il vous sera demandé si vous souhaitez installer le plugin **GLPI Inventory 1.4.0**. Vous pouvez choisir de l'inclure ou non en fonction de vos besoins.

### Étape 3 : Configuration après installation

Une fois l'installation terminée, procédez aux étapes suivantes :

1. **Accédez à l'interface web de GLPI** :
   - Ouvrez un navigateur web et accédez à l'adresse IP ou au nom de domaine de votre serveur GLPI.
   - Complétez l'installation via l'interface web en suivant les instructions.

2. **Finalisez la configuration du plugin Inventory** (si installé) :
   - Activez le plugin dans l'interface d'administration GLPI.
   - Configurez les paramètres selon vos besoins.

## Notes supplémentaires

- **Sécurité** : Assurez-vous que votre système est à jour avant d'exécuter les scripts pour éviter des problèmes liés aux dépendances.
- **Personnalisation** : Si vous avez des configurations spécifiques, vous pouvez modifier les scripts avant de les exécuter.

Bonne installation !

