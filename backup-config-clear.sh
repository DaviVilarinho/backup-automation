#!/bin/zsh

for oldbackup in $(find ~/backups | grep config-backup | sort --reverse | tail -n +4)
do
  rm $oldbackup
done
