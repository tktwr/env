#!/bin/bash

source $HOME/.my/hostname
source $HOME/.bashrc.env
source ../lib/common_etc.sh

f_expand_dir() {
  local opt="$1"
  local name="$2"
  local val="$3"

  dir=`f_cygpath $opt $val`

  echo "let \$$name=\"$dir\""
}

f_print_env() {
  local target_os=$1
  local opt

  case $target_os in
    unix)
      opt="-u"
      ;;
    win)
      opt="-m"
      ;;
  esac

  GIT_EXE=git

  f_expand_dir $opt MY_VIM $MY_VIM
  f_expand_dir -m   MY_VIM_WIN $MY_VIM
  f_expand_dir $opt MY_REMOTE_CONFIG $MY_REMOTE_CONFIG
  f_expand_dir $opt MY_LOCAL_CONFIG $MY_LOCAL_CONFIG
  f_expand_dir $opt MY_PRIVATE_CONFIG $MY_PRIVATE_CONFIG
  f_expand_dir $opt MY_OPT $MY_OPT
  f_expand_dir $opt MY_GIT_EXE $GIT_EXE
}

f_print_env $1

