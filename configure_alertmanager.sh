#!/bin/bash

# Remplacer les placeholders par les valeurs des variables d'environnement
envsubst < /etc/alertmanager/alertmanager.yml > /etc/alertmanager/alertmanager.tmp.yml

# Afficher le fichier modifié pour vérification
cat /etc/alertmanager/alertmanager.tmp.yml

# Lancer Alertmanager avec le fichier de configuration modifié
exec /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.tmp.yml --storage.path=/alertmanager