#!/bin/bash

DB_USER="prestashop"
DB_PASS="prestashop"
DB_NAME="prestashop"
BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

mkdir -p $BACKUP_DIR

mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

find $BACKUP_DIR -name "*.sql" -type f -mtime +7 -delete