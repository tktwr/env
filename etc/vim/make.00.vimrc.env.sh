#!/bin/bash

source ../common.sh

hostname_file=$HOME/.my/hostname
bashrc_env_file=$HOME/.bashrc.env

f_expand_dir() {
  local opt="$1"
  local name="$2"
  local val="$3"

  dir=`f_cygpath $opt $val`

  echo "let \$$name=\"$dir\""
  #echo "let \$$name=expand(\"$dir\")"
}

f_set_env_vars() {
  local target_os=$1
  local target_shell=$2
  local opt

  case $target_os in
    unix)
      opt="-u"
      ;;
    win)
      opt="-m"
      ;;
  esac
  case $target_shell in
    MINGW64)
      GIT_EXE=$MY_REMOTE_CONFIG/env/bin/shell.$MY_SHELL_NAME/git
      ;;
    gitbash|termux|bash)
      GIT_EXE=git
      ;;
  esac

  f_expand_dir $opt MY_VIM $MY_VIM
  f_expand_dir $opt MY_REMOTE_CONFIG $MY_REMOTE_CONFIG
  f_expand_dir $opt MY_LOCAL_CONFIG $MY_LOCAL_CONFIG
  f_expand_dir $opt MY_PRIVATE_CONFIG $MY_PRIVATE_CONFIG
  f_expand_dir $opt MY_OPT $MY_OPT
  f_expand_dir $opt MY_GIT_EXE $GIT_EXE
}

f_source_file $hostname_file
f_source_file $bashrc_env_file

f_set_env_vars $1 $2

