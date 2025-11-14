#!/bin/bash
# Backup Script for .bashrc
# Always backup your configuration files before modification!

BACKUP_DIR="$HOME/.config_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/bashrc_backup_$TIMESTAMP"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Check if .bashrc exists
if [ -f "$HOME/.bashrc" ]; then
    # Create backup
    cp "$HOME/.bashrc" "$BACKUP_FILE"
    echo "Backup created: $BACKUP_FILE"
    echo "File size: $(du -h "$BACKUP_FILE" | cut -f1)"
    echo ""
    echo "To restore from this backup, run:"
    echo "cp $BACKUP_FILE ~/.bashrc && source ~/.bashrc"
else
    echo "Error: ~/.bashrc not found"
    exit 1
fi

# List all backups
echo ""
echo "All available backups:"
ls -lh "$BACKUP_DIR"/bashrc_backup_* 2>/dev/null | awk '{print $9, "(" $5 ")"}'
