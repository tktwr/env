#!/bin/bash

source $HOME/.my/hostname
source build/.bashrc.env
source ../common.sh

f_init() {
  echo 'unalias -a'
  echo 'source $HOME/.my/hostname'
  echo 'source $HOME/.my/buildrc'
  echo 'source $HOME/.my/pythonrc'
  echo 'source $HOME/.my/pushdrc'
  echo 'source $HOME/.bashrc.env'
}

f_get_bashrc() {
  local files="bashrc.??.*.sh"

  for i in $files; do
    case $i in
      bashrc.[0-4]?.*.sh)
        echo $i ;;
      bashrc.50.os.$MY_OS_NAME.sh)
        echo $i ;;
      bashrc.51.shell.$MY_SHELL_NAME.sh)
        echo $i ;;
      bashrc.52.site.$MY_SITE_NAME.sh)
        echo $i ;;
      bashrc.53.host.$MY_HOST_NAME.sh)
        echo $i ;;
      bashrc.[6-9]?.*.sh)
        echo $i ;;
    esac
  done
}

f_cat_bashrc() {
  local DIR=$1
  if [ ! -d $DIR ]; then
    return
  fi

  cd $DIR

  local files=`f_get_bashrc`
  local I

  for I in $files; do
    if [ -f $I ]; then
      echo "f_time_start $DIR/$I"
      cat $I
      echo "f_time_end $DIR/$I"
    fi
  done
}

cat bashrc.time.sh
f_init
f_cat_bashrc $MY_REMOTE_CONFIG/env/etc/bash
f_cat_bashrc $MY_LOCAL_CONFIG/env/etc/bash
f_cat_bashrc $MY_PRIVATE_CONFIG/env/etc/bash

