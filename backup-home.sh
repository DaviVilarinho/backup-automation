#!/bin/zsh

code --list-extensions >> ~/.config/vscode-extensions.log

DRIVE_SYNC_DIR="$HOME/mnt/drive"
HDD_DIR="$HOME/mnt/hdd"

(rclone sync drive:/sync $DRIVE_SYNC_DIR/sync -v && notify-send "sync sync dir from drive") &
(rclone sync drive:/Colab\ Notebooks $DRIVE_SYNC_DIR/Colab\ Notebooks -v && notify-send "sync Colab Notebooks dir from drive") &
(rclone sync ~/data/docs drive:/docs -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to drive encrypted") &
(rclone sync ~/data/notes drive:/notes -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync notes to drive encrypted") &

if [[ $(mountpoint $HDD_DIR) == 0 ]]
then
  (rclone sync ~/data hdd:/data -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to hdd") & 
  rclone sync ~/backups hdd:/backups -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to hdd"
fi

(rclone sync ~/data drive-encrypted:/data -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to drive") &
rclone sync ~/data ufudrive-encrypted:/ --progress  && notify-send 'sync to ufudrive encrypted'
