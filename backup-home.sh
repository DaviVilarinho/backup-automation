#!/bin/zsh

code --list-extensions >> ~/.config/vscode-extensions.log

DRIVE_SYNC_DIR="$HOME/mnt/drive-sync"
HDD_DIR="$HOME/mnt/hdd"

mountpoint $HDD_DIR
is_mountpoint=$?

rclone sync drive:/sync $DRIVE_SYNC_DIR/sync -v && notify-send "sync sync dir from drive"
rclone sync drive:/colabTempResults $DRIVE_SYNC_DIR/colabTempResults -v && notify-send "sync colabTempResults dir from drive"
rclone sync drive:/Colab\ Notebooks $DRIVE_SYNC_DIR/Colab\ Notebooks -v && notify-send "sync Colab Notebooks dir from drive"

rclone sync ~/docs drive-encrypted:/docs -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to drive encrypted"

rclone sync ~/docs drive:/docs -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to drive"

if [[ $is_mountpoint == 0 ]]
then
  rclone sync ~/docs hdd:/docs -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync docs to hdd"
fi

rclone sync ~/.config drive-encrypted:/notebook/config -v --exclude="**/.git/**" --exclude="Code/**" --exclude --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" --exclude="**/Teams/**" --exclude="Microsoft/**" --exclude="Microsoft Teams - Preview/**" && notify-send "sync .config to drive encrypted"

if [[ $is_mountpoint == 0 ]]
then
  rclone sync ~/.config hdd:/config -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" --exclude="Microsoft/**" --exclude="Microsoft Teams - Preview/**" && notify-send "sync doconfig to hdd"
fi


for d in $HOME/*/
do
  based = $(basename $d)
  if [[ based != "mnt" && based != "go" && based != "docs" ]]
  then
    rclone sync $d drive-encrypted:/notebook/$based -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync $based to drive encrypted"

    if [[ $is_mountpoint == 0 ]]
    then
      rclone sync $d hdd:/home/$based -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync $based to hdd"
    fi
  fi
done


rclone sync drive-encrypted:/ ufudrive-encrypted:/ --progress

if [[ $is_mountpoint == 0 ]]
then
  rclone sync hdd:/archive drive-encrypted:/archive -v --exclude="**/.git/**" --exclude="**/node_modules/**" --exclude="**/.env/**" --exclude="**/.venv/**" --exclude="**/.cache/**" --exclude="**/.Cache/**" && notify-send "sync hdd to sync"
fi