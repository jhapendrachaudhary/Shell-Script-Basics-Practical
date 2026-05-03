#!/bin/bash

# backup.sh - Backup a specific directory with timestamp, compression, and rotation
# Usage: ./backup.sh [source_dir] [backup_dir]

# ======================
# CONFIGURATION (Edit these as needed)
# ======================
SOURCE_DIR="${1:-/home/unknown/Documents}"     # Default source (use arg $1 or fallback)
BACKUP_DIR="${2:-/home/unknown/Documents/backup}"                 # Default backup location (use arg $2 or fallback)
MAX_BACKUPS=7                               # Keep only last 7 backups
ENABLE_COMPRESSION=true                     # true = .tar.gz, false = plain copy
LOG_FILE="$HOME/Documents/backup.log"              # Log file path

# ======================
# FUNCTIONS
# ======================

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

validate_paths() {
    if [ ! -d "$SOURCE_DIR" ]; then
        log "ERROR: Source directory does not exist: $SOURCE_DIR"
        exit 1
    fi

    if [ ! -d "$BACKUP_DIR" ]; then
        log "WARNING: Backup directory does not exist. Creating: $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        if [ ! -d "$BACKUP_DIR" ]; then
            log "ERROR: Failed to create backup directory"
            exit 1
        fi
    fi
}

create_backup() {
    TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
    BACKUP_NAME="backup_$(basename "$SOURCE_DIR")_$TIMESTAMP"
    
    if [ "$ENABLE_COMPRESSION" = true ]; then
        BACKUP_FILE="$BACKUP_DIR/${BACKUP_NAME}.tar.gz"
        log "Creating compressed backup: $BACKUP_FILE"
        tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>> "$LOG_FILE"
    else
        BACKUP_FILE="$BACKUP_DIR/${BACKUP_NAME}"
        log "Creating backup: $BACKUP_FILE"
        rsync -a "$SOURCE_DIR/" "$BACKUP_FILE/" 2>> "$LOG_FILE"
    fi

    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        log "SUCCESS: Backup completed: $BACKUP_FILE"
    else
        log "ERROR: Backup failed!"
        exit 1
    fi
}

rotate_backups() {
    if [ "$MAX_BACKUPS" -lt 1 ]; then
        return
    fi

    # Get list of backups sorted by modification time (newest first)
    BACKUP_LIST=$(find "$BACKUP_DIR" -maxdepth 1 -name "backup_$(basename "$SOURCE_DIR")_*" -type f | sort -r)
    COUNT=0

    while IFS= read -r backup; do
        ((COUNT++))
        if [ $COUNT -gt $MAX_BACKUPS ]; then
            log "Rotating old backup: $backup"
            rm -f "$backup"
        fi
    done <<< "$BACKUP_LIST"
}

# ======================
# MAIN EXECUTION
# ======================

# Create log directory if needed
mkdir -p "$(dirname "$LOG_FILE")"

log "=== Backup started for: $SOURCE_DIR ==="

validate_paths
create_backup
rotate_backups

log "=== Backup completed successfully ==="
