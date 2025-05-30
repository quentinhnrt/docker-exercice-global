#!/bin/bash

DB_HOST="${DB_HOST:-localhost}"
DB_USER="${DB_USER:-root}"
DB_PASS="${MYSQL_ROOT_PASSWORD:-root}"
DB_NAME="${DB_NAME:-my_database}"
BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

until mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1" &> /dev/null; do
    echo "En attente de MySQL..."
    sleep 1
done

mkdir -p "$BACKUP_DIR"

mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"

BACKUP_FILES=($(ls -1t "$BACKUP_DIR"/*.sql 2>/dev/null))
TOTAL_BACKUPS=${#BACKUP_FILES[@]}

if (( TOTAL_BACKUPS > 6 )); then
    FILES_TO_DELETE=("${BACKUP_FILES[@]:6}")
    for file in "${FILES_TO_DELETE[@]}"; do
        echo "Suppression du backup ancien : $file"
        rm -f "$file"
    done
fi