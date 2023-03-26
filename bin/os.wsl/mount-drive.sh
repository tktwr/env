#!/bin/bash

drive=$1
mnt_dir=/mnt/$1

if [ -z "$drive" ]; then
  echo "USAGE: mount-drive.sh drive_letter"
  exit
fi

if [ ! -d "$mnt_dir" ]; then
  echo "no directory: $mnt_dir"
  exit
fi

sudo mount -t drvfs $drive: $mnt_dir
