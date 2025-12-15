#!/bin/bash

SNAP_DIRS="\
  $MY_LOCAL_CONFIG/memo \
  $MY_DIARY \
  $MY_SECRET \
  "

f_snap() {
  for-dir.sh "git-tar.sh -t -D $MY_SNAP" $SNAP_DIRS
  cd $MY_ETC
  mymake.sh f_dot_snap_tar
}

f_snap_n() {
  for-dir.sh "git-tar.sh -t -D $MY_SNAP -n" $SNAP_DIRS
  cd $MY_ETC
  mymake.sh f_dot_snap_tar_n
}

f_snap_status() {
  for-dir.sh "git.sh status -s" $SNAP_DIRS
}

f_snap_commit() {
  for-dir.sh "git.sh commit -a -m 'snap update'" $SNAP_DIRS
}
