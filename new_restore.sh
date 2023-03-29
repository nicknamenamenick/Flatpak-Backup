#!/usr/bin/env bash

# Set source and destination directories
SRC_DIR="/run/media/mmcblk0pl1"
DEST_DIR="/var/home/deck/.var/app"

# Set filename for backup
BACKUP_FILENAME="$(ls "$SRC_DIR" | grep 'flatpakbackup' | tail -1)"

# Install flatpaks listed in packages.txt
xargs -a "$SRC_DIR/packages.txt" flatpak install || {
    echo "Failed to install flatpaks!"
    exit 1
}

# Extract backup archive to destination directory
tar --extract --gzip --file="$SRC_DIR/$BACKUP_FILENAME" --directory="$DEST_DIR" || {
    echo "Failed to restore backup!"
    exit 1
}

echo "Restore complete."
