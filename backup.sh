#!/bin/bash
# This ensures the backup script will *halt* if
# any one command fails (e.g., stopping a Docker
# image) preventing data corruption
set -e

# Set mount point for backup drive
BACKUP_DRIVE=/media/treehouse/backup/

# Ensure backup drive is online and is a mounted
# drive (as opposed to a directory on the machine)
if ! mountpoint -q "$BACKUP_DRIVE"; then
    echo "Error: $BACKUP_DRIVE is not mounted!"
    exit 1
fi

# Ensure the backup drive is formatted as ext4 (other
# format types such as FAT32 enhance compatability with
# other operating systems, but will not correctly inherit
# timestamps and permissions for Linux and may cause rsync
# to unnecessarily copy and replace files)
if [ "$(findmnt -n -o FSTYPE -T "$BACKUP_DRIVE")" != "ext4" ]; then
    echo "Error: $BACKUP_DRIVE is not formatted as ext4!"
    exit 1
fi

# Halt all Docker images
(cd immich/ && docker compose down)
(cd lab/ && docker compose down)
(cd memos/ && docker compose down)

# Begin backup (can take a long time) which will:
# - Backup new files
# - Update existing files
# - Inherit all permissions
# - Delete files in backup which I intentionally
#   removed (e.g., I deleted an picture in Immich)
rsync -av --delete --info=progress2 --exclude="lost+found" /mnt/raid/ "$BACKUP_DRIVE"

# Restart Docker images
(cd immich/ && docker compose up -d)
(cd lab/ && docker compose up -d)
(cd memos/ && docker compose up -d)

# Unmount backup drive for safe removal
umount -l "$BACKUP_DRIVE"

# Backup successful
echo "Success!"
