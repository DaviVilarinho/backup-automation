HDD_DIR="$HOME/mnt/hdd"

mountpoint $HDD_DIR
is_mountpoint=$?

if [ $is_mountpoint -eq 0 ]; then
    rclone sync --fast-list --checksum hdd:/docs s3_archive:/docs --no-traverse

    rclone sync --fast-list --checksum hdd:/archive s3_archive_encrypted: --no-traverse
else
    echo "HDD is not mounted"
    exit 1
fi