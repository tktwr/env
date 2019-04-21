#!/bin/bash

source $HOME/.hostname

f_get_files() {
  local files="bashrc.??.*"

  for i in $files; do
    case $i in
      bashrc.0?.*)
        echo $i
        ;;
      bashrc.1?.*)
        echo $i
        ;;
      bashrc.50.os.$MY_OS_NAME)
        echo $i
        ;;
      bashrc.51.shell.$MY_SHELL_NAME)
        echo $i
        ;;
      bashrc.52.site.$MY_SITE_NAME)
        echo $i
        ;;
      bashrc.53.host.$MY_HOST_NAME)
        echo $i
        ;;
      bashrc.9?.*)
        echo $i
        ;;
    esac
  done
}

f_make_bashrc() {
  local files=$*

  cat bashrc.time

  local I
  for I in $files; do
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

files=`f_get_files`
f_make_bashrc $files

