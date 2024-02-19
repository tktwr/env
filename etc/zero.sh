#!/bin/bash

./zero_hostname.sh
source $HOME/.my/hostname.sh

BASE_DIR=$(pwd)
echo $BASE_DIR

#------------------------------------------------------
f_zero_sys() {
  if [ ! -d $HOME/.venv ]; then
    case $MY_OS_NAME in
      wsl)
        sudo -E apt update
        sudo -E apt upgrade
        sudo -E apt autoremove
        sudo -E apt install python3-venv python3-pip
        ;;
    esac
  fi
}

f_zero_bash() {
  cd $BASE_DIR/bash
  cp -n $HOME/.bashrc $HOME/.bashrc.orig
  cat bashrc_zero_func.sh bashrc_zero.sh > $HOME/.bashrc
}

f_zero_vim() {
  cd $BASE_DIR/vim
  cat vimrc_zero.vim > $HOME/.vimrc
}

f_zero_batcat() {
  if [ "$SYS_CAT_EXE" = 'batcat' ]; then
    echo "[batcat] build"
    batcat cache --build
  fi
}

f_zero_venv_create() {
  local dir=$HOME/.venv
  if [ ! -d "$dir" ]; then
    echo "$MY_PYTHON_EXE -m venv $dir"
    $MY_PYTHON_EXE -m venv $dir
  fi
}

#------------------------------------------------------
f_zero_sys
f_zero_bash
f_zero_vim
f_zero_batcat
f_zero_venv_create
