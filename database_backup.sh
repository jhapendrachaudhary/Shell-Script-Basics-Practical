#!/bin/bash

DB_NAME="$1"

# Check if argument is empty
if [ -z "$DB_NAME" ]; then
    echo "Error: Database name one argument is required. eg:- ./database_backup.sh db_name"
    exit 1
fi

# Check if backup file already exists
BACKUP_FILE="/home/unknown/Desktop/${DB_NAME}_backup.sql"
if [ -f "$BACKUP_FILE" ]; then
    echo "Error: Backup file '$BACKUP_FILE' already exists."
    exit 1
fi

# Check if database exists (using mysql command)
if ! mysqlshow -u root --password=Admin@123 "$DB_NAME" >/dev/null 2>&1; then
    echo "Error: Database '$DB_NAME' does not exist."
    exit 1
fi

# Perform backup
# mysqldump -u user -p'secret123' database > backup.sql
# or
if mysqldump --password=Admin@123 -u root "$DB_NAME" > "$BACKUP_FILE"; then
echo "Successfully backup......"
else 
     echo  "Failed to create backup...."
     exit 1
fi
