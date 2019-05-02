#!/bin/bash

source $HOME/.hostname

f_get_files() {
  local files="bashrc.??.*"

  for i in $files; do
    case $i in
      bashrc.0?.*)
        echo $i ;;
      bashrc.1?.*)
        echo $i ;;
      bashrc.50.os.$MY_OS_NAME)
        echo $i ;;
      bashrc.51.shell.$MY_SHELL_NAME)
        echo $i ;;
      bashrc.52.site.$MY_SITE_NAME)
        echo $i ;;
      bashrc.53.host.$MY_HOST_NAME)
        echo $i ;;
      bashrc.9?.*)
        echo $i ;;
    esac
  done
}

f_make_bashrc() {
  local files=`f_get_files`
  local I
  for I in $files; do
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

f_make_local_bashrc() {
  local local_bashrc_dir=$MY_LOCAL_CONFIG/env/etc/bash
  local files="bashrc"
  local I
  for I in $files; do
    I=$local_bashrc_dir/$I
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

cat bashrc.time
f_make_bashrc
f_make_local_bashrc

