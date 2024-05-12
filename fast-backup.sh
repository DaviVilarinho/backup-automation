#!/bin/zsh

code --list-extensions >> ~/.config/vscode-extensions.log

DRIVE_SYNC_DIR="$HOME/mnt/drive"
HDD_DIR="$HOME/mnt/hdd"

if [[ $(mountpoint $HDD_DIR) == 0 ]]
then
  restic --password-file /etc/password-restic.txt --repo ~/mnt/hdd/restic backup ~/data & 
fi

sleep 10

(rclone sync drive:/sync $DRIVE_SYNC_DIR/sync -v && notify-send "sync sync dir from drive") &
(rclone sync drive:/Colab\ Notebooks $DRIVE_SYNC_DIR/Colab\ Notebooks -v && notify-send "sync Colab Notebooks dir from drive") &
(rclone sync ~/data/docs drive:/docs -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to drive") &
(rclone sync ~/data/notes drive:/notes -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync notes to drive") &
(rclone sync ~/data/projects drive:/desktop-projects -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync projects to drive") &

if [[ $(mountpoint $HDD_DIR) == 0 ]]
then
  (rclone sync ~/data hdd:/data -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync data to hdd") & 
  rclone sync ~/backups hdd:/backups -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync backus to hdd"
fi
