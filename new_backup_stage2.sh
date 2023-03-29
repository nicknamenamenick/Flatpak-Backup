#!/usr/bin/env bash

# Set source directory
SRC_DIR="/var/home/deck/.var/app"

# Ask the user to input the destination directory for the backup
read -p "Please enter the destination directory for the backup: " DEST_DIR

# Set filename for backup
BACKUP_FILENAME="flatpakbackup-$(date +'%Y%m%d-%H%M%S').tgz"

# Create backup archive and save to destination directory
tar --create --gzip --file="$DEST_DIR/$BACKUP_FILENAME" "$SRC_DIR" || {
    echo "Backup failed!"
    exit 1
}

# Create list of installed flatpaks and save to file
flatpak list --app --columns=ref > "$DEST_DIR/packages.txt" || {
    echo "Could not save list of installed flatpaks!"
    exit 1
}

echo "Backup complete."
