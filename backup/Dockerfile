FROM debian:bullseye

ENV EDITOR=nano

# Installer mysql-client et cron
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    cron \
    && apt-get clean

# Ajouter les scripts
COPY backup.sh /usr/local/bin/backup.sh
COPY entrypoint.sh /entrypoint.sh

# Rendre les scripts exécutables
RUN chmod +x /usr/local/bin/backup.sh /entrypoint.sh

# Créer le dossier de backup
RUN mkdir -p /backups

# Définir le point d'entrée
ENTRYPOINT ["/entrypoint.sh"]