#!/bin/bash

source ../common.sh

hostname_file=$HOME/.my/hostname
bashrc_env_file=build/.bashrc.env

f_set_env_vars() {
  echo 'unalias -a'
  echo 'source $HOME/.my/hostname'
  echo 'source $HOME/.my/buildrc'
  echo 'source $HOME/.my/pythonrc'
  echo 'source $HOME/.my/pushdrc'
  echo 'source $HOME/.bashrc.env'
}

f_get_bashrc() {
  local files="bashrc.??.*"

  for i in $files; do
    case $i in
      bashrc.[0-4]?.*)
        echo $i ;;
      bashrc.50.os.$MY_OS_NAME)
        echo $i ;;
      bashrc.51.shell.$MY_SHELL_NAME)
        echo $i ;;
      bashrc.52.site.$MY_SITE_NAME)
        echo $i ;;
      bashrc.53.host.$MY_HOST_NAME)
        echo $i ;;
      bashrc.[6-9]?.*)
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

f_source_file $hostname_file
f_source_file $bashrc_env_file

cat bashrc.time
f_set_env_vars
f_cat_bashrc $MY_REMOTE_CONFIG/env/etc/bash
f_cat_bashrc $MY_LOCAL_CONFIG/env/etc/bash
f_cat_bashrc $MY_PRIVATE_CONFIG/env/etc/bash

