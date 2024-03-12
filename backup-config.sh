#!/bin/bash

backup_dir=~/backups

backup_file="$backup_dir/$(date '+%Y-%m-%d')_config-backup.tar.gz"

tar --exclude ".config/Microsoft" --exclude ".config/Code" --exclude ".config/chromium" --exclude ".config/libreoffice" -cvzf $backup_file -C "/home/dv" .config .zshrc .tmux .ssh/ .aws .cert .thunderbird
  
 
