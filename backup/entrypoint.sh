#!/bin/bash

# Créer une entrée cron : toutes les 6 heures
echo "0 */6 * * * /usr/local/bin/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/db-backup

# Appliquer les droits
chmod 0644 /etc/cron.d/db-backup
crontab /etc/cron.d/db-backup

# Lancer cron en foreground
cron -f

/usr/local/bin/backup.sh