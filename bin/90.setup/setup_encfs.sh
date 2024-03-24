#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_encfs_edit() {
  sudo vi /etc/fuse.conf
}

f_encfs_ls_mount() {
  mount | grep fuse.encfs | $GIT_PAGER
}

f_encfs_mount() {
  #mount-drive.sh e
  encfs -o allow_root /mnt/e/_encfs_e ~/mnt/encfs_e
}

f_encfs_umount() {
  fusermount -u ~/mnt/encfs_e
  #umount-drive.sh e
}

