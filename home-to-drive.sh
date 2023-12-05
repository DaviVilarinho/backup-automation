#!/bin/zsh

. ~/files.sh

code --list-extensions >> ~/.config/vscode-extensions.log

DRIVE_SYNC_DIR="$HOME/mnt/drive-sync"
HDD_DIR="$HOME/mnt/hdd"

mountpoint $HDD_DIR
is_mountpoint=$?
if [[ $is_mountpoint == 0 ]]
then
  notify-send "noticed hdd, will backup"
  
  rclone sync ~/wiki hdd:/wiki -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync wiki to hdd"
  rclone copy ~/backups hdd:/archive/backups -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync backups to hdd"
  rclone sync ~/.dotfiles hdd:/dotfiles -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync dotfiles to hdd"
  rclone sync ~/music hdd:/music -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync music to hdd"
  rclone sync ~/media hdd:/media -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync media to hdd"
  rclone sync ~/watch-later hdd:/watch-later -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync watch-later to hdd"
  rclone sync ~/.config hdd:/config -v --exclude="**/.git/**" --exclude="Code/**" --exclude --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync .config to hdd"
fi

rclone sync drive:/colabTempResults $DRIVE_SYNC_DIR/colabTempResults -v && notify-send "sync colabTempResults dir from drive"
rclone sync drive:/Colab\ Notebooks $DRIVE_SYNC_DIR/Colab\ Notebooks -v && notify-send "sync Colab Notebooks dir from drive"
rclone sync drive:/sync $DRIVE_SYNC_DIR/sync -v && notify-send "sync sync dir from drive"

rclone sync ~/wiki drive-encrypted:/notebook/wiki -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync wiki to drive encrypted"
rclone sync ~/backups drive-encrypted:/notebook/backups -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync backups to drive encrypted"
rclone sync ~/.dotfiles drive-encrypted:/notebook/.dotfiles -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync dotfiles to drive encrypted"
rclone sync ~/music drive-encrypted:/notebook/music -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync music to drive encrypted"
rclone sync ~/media drive-encrypted:/notebook/media -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync media to drive encrypted"
#rclone sync ~/mnt drive-encrypted:/notebook/mnt -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync mnt to drive encrypted"
rclone sync ~/watch-later drive-encrypted:/notebook/watch-later -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync watch-later to drive encrypted"
rclone sync ~/.config drive-encrypted:/notebook/config -v --exclude="Code/**" --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync .config to drive-encrypted"

rclone sync drive-encrypted:/ ufudrive-encrypted:/ --progress
