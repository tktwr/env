#!/bin/bash

source $HOME/.my/hostname

FILES_DIR="\
$MY_REMOTE_CONFIG/env/etc/fzy/dir.txt \
$MY_LOCAL_CONFIG/env/etc/fzy/dir.txt \
$MY_PRIVATE_CONFIG/env/etc/fzy/dir.txt \
"

f_set_env_vars() {
  if [ ! -z "$USERPROFILE" ]; then
    ./make-dir.py ../fzy/dir.sys.msys.txt
  else
    ./make-dir.py ../fzy/dir.sys.unix.txt
  fi

  echo 'source $HOME/.my/hostname'
  echo 'source $HOME/.my/buildrc'
  echo 'source $HOME/.my/pythonrc'
  echo 'source $HOME/.my/pushdrc'

  ./make-dir.py $FILES_DIR
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

cat bashrc.time
echo 'unalias -a'
f_set_env_vars
f_cat_bashrc $MY_REMOTE_CONFIG/env/etc/bash
f_cat_bashrc $MY_LOCAL_CONFIG/env/etc/bash
f_cat_bashrc $MY_PRIVATE_CONFIG/env/etc/bash

