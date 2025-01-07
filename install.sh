#!/bin/bash

# Fonction pour imprimer une ligne avec une couleur
print_colored_line() {
    local color_code="$1"
    local text="$2"
    echo -e "\e[38;5;${color_code}m${text}\e[0m"
}

# Dégradé de verts (codes ANSI 22 à 46)
green_colors=(22 28 34 40 46 46 40 34 28 22)

# ASCII art, chaque ligne sera traitée séparément
ascii_art=(
"          _____                    _____            _____                    _____          "
"         /\    \                  /\    \          /\    \                  /\    \         "
"        /::\    \                /::\____\        /::\    \                /::\    \        "
"       /::::\    \              /:::/    /       /::::\    \               \:::\    \       "
"      /::::::\    \            /:::/    /       /::::::\    \               \:::\    \      "
"     /:::/\:::\    \          /:::/    /       /:::/\:::\    \               \:::\    \     "
"    /:::/  \:::\    \        /:::/    /       /:::/__\:::\    \               \:::\    \    "
"   /:::/    \:::\    \      /:::/    /       /::::\   \:::\    \              /::::\    \   "
"  /:::/    / \:::\    \    /:::/    /       /::::::\   \:::\    \    ____    /::::::\    \  "
" /:::/    /   \:::\ ___\  /:::/    /       /:::/\:::\   \:::\____\  /\   \  /:::/\:::\    \ "
"/:::/____/  ___\:::|    |/:::/____/       /:::/  \:::\   \:::|    |/::\   \/:::/  \:::\____\."
"\:::\    \ /\  /:::|____|\:::\    \       \::/    \:::\  /:::|____|\:::\  /:::/    \::/    /"
" \:::\    /::\ \::/    /  \:::\    \       \/_____/\:::\/:::/    /  \:::\/:::/    / \/____/ "
"  \:::\   \:::\ \/____/    \:::\    \               \::::::/    /    \::::::/    /          "
"   \:::\   \:::\____\       \:::\    \               \::::/    /      \::::/____/           "
"    \:::\  /:::/    /        \:::\    \               \::/____/        \:::\    \           "
"     \:::\/:::/    /          \:::\    \               ~~               \:::\    \          "
"      \::::::/    /            \:::\    \                                \:::\    \         "
"       \::::/    /              \:::\____\                                \:::\____\        "
"        \::/____/                \::/    /                                 \::/    /        "
"                                  \/____/                                   \/____/         "
"                                                                 by BryyZee (and ChatGPT...)"
"                                                             GLPI-10.0.17 Install - dec/2024"
)

# Impression de chaque ligne avec une couleur différente
for i in "${!ascii_art[@]}"; do
    color_index=$((i % ${#green_colors[@]}))
    print_colored_line "${green_colors[color_index]}" "${ascii_art[i]}"
done



# Fonction pour appliquer le dégradé
apply_gradient() {
    local line_number=0
    for line in "${ASCII_ART[@]}"; do
        # Calculer l'indice de couleur en fonction du numéro de ligne
        local color_index=$((line_number % ${#COLORS[@]}))
        echo -e "${COLORS[color_index]}$line\033[0m" # Appliquer la couleur à la ligne
        ((line_number++))
    done
}

# Appeler la fonction pour afficher l'art en couleur
apply_gradient

echo "Entrez l'adresse IP ou le nom de domaine de votre futur serveur GLPI :"
read  ip_glpi_srv

sudo sed -i "s/@IP-srv/$ip_glpi_srv/g" glpi-administratif.conf


# Demander à l'utilisateur de créer un mot de passe root MySQL
echo "Créez votre mot de passe root MySQL :"
read -s MYSQL_ROOT_PASSWORD

# Demander la confirmation du mot de passe
echo "Confirmez votre mot de passe root MySQL :"
read -s MYSQL_ROOT_PASSWORD_CONFIRM

# Vérifier si les mots de passe correspondent
while [ "$MYSQL_ROOT_PASSWORD" != "$MYSQL_ROOT_PASSWORD_CONFIRM" ]; do
    echo "Les mots de passe ne correspondent pas. Veuillez les saisir à nouveau."

    # Demander à nouveau le mot de passe
    echo "Créez votre mot de passe root MySQL :"
    read -s MYSQL_ROOT_PASSWORD
    
    # Demander à nouveau la confirmation du mot de passe
    echo "Confirmez votre mot de passe root MySQL :"
    read -s MYSQL_ROOT_PASSWORD_CONFIRM
done

# Demander à l'utilisateur de créer un mot de passe pour la base de données glpi_db
echo "Créez votre mot de passe pour la base de données glpi_db :"
read -s DB_PASSWORD

# Demander la confirmation du mot de passe
echo "Confirmez votre mot de passe pour la base de données glpi_db :"
read -s DB_PASSWORD_CONFIRM

# Vérifier si les mots de passe correspondent
while [ "$DB_PASSWORD" != "$DB_PASSWORD_CONFIRM" ]; do
    echo "Les mots de passe ne correspondent pas. Veuillez les saisir à nouveau."

    # Demander à nouveau le mot de passe
    echo "Créez votre mot de passe pour la base de données glpi_db :"
    read -s DB_PASSWORD
    
    # Demander à nouveau la confirmation du mot de passe
    echo "Confirmez votre mot de passe pour la base de données glpi_db :"
    read -s DB_PASSWORD_CONFIRM
done

echo "Les mots de passe correspondent. Configuration terminée."


echo "Voulez vous installer le plugin GLPI-Inventory 1.4.0 ? [O/N]:"
read plugin

# Installation des packages
./install-services.sh

# Configuration du mot de passe root de MariaDB
echo "Lancement du script de sécurisation de MariaDB..."
mysql_secure_installation

# Création et configuration de la base de données GLPI
echo "Création et configuration de la base de données GLPI..."
./glpidb-creation.sh "$DB_PASSWORD" "$MYSQL_ROOT_PASSWORD"
echo "Création et configuration de la base de données GLPI...Fait"

#Téléchargement et configuration de GLPI
./install-glpi.sh

# Création d'un certificat auto-signé
echo "Création et configuration du certificat auto-signé..."
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-glpi-selfsigned.key -out /etc/ssl/certs/apache-glpi-selfsigned.crt -subj "/C=FR/ST=France/L=Paris/O=MonOrganisation/OU=IT/CN=localhost" 1>/dev/null 2>error.log
echo "Création et configuration du certificat auto-signé..."

# Configuration Apache2 et PHP8.2 pour GLPI
./config-apache2.sh


if [[ "$plugin" == "O" ]]; then
    # Installation du plugin GLPI Inventory 1.4
    ./install-plugin-glpi-inventory.sh
fi

echo "Installation GLPI 10.0.17 terminé ..."
echo "                          _   "
echo "                         (_)  "
echo "  _ __ ___   ___ _ __ ___ _   "
echo " | '_ \` _ \ / _ \ '__/ __| |  "
echo " | | | | | |  __/ | | (__| |_ "
echo " |_| |_| |_|\___|_|  \___|_(_) "
echo "                               "
echo "                               "