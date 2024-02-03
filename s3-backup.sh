#!/bin/zsh
HDD_DIR="$HOME/mnt/hdd"

set -e

mountpoint $HDD_DIR
is_mountpoint=$?

if [ $is_mountpoint -eq 0 ]; then
    rclone sync --fast-list --checksum ~/data/docs s3_archive:/docs --no-traverse --progress

    rclone sync --fast-list --checksum ~/data s3_archive_encrypted: --no-traverse --progress
else
    echo "HDD is not mounted"
    exit 1
fi
