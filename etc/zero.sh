#!/bin/bash

_f_echo_T() {
  echo "--- [$*] ----------"
}
_f_echo() {
  echo "$*"
}

DOTMY_DIR=$HOME/.my
DOTMYCACHE_DIR=$HOME/.mycache
VENV_DIR=$HOME/.venv
BASE_DIR=$(pwd)

_f_echo "BASE_DIR=$BASE_DIR"

#------------------------------------------------------
mkdir -p $DOTMY_DIR
mkdir -p $DOTMYCACHE_DIR

./zero_hostname.sh > $DOTMY_DIR/hostname.sh
source $DOTMY_DIR/hostname.sh

#------------------------------------------------------
_f_symlink() {
  if [ ! -e "$2" -a ! -L "$2" ]; then
    _f_echo "ln -s $1 $2"
    ln -s $1 $2
  fi
}
#------------------------------------------------------
f_zero_symlink() {
  case $MY_OS_NAME in
    wsl)
      cd
      _f_symlink WinHome/MyConfig MyConfig
      _f_symlink WinHome/MyData   MyData
      _f_symlink WinHome/MyProj   MyProj
      _f_symlink WinHome/MyWork   MyWork
      ;;
  esac
}
f_zero_sys() {
  case $MY_OS_NAME in
    wsl)
      sudo -E apt update
      sudo -E apt upgrade
      sudo -E apt autoremove
      sudo -E apt install python3-venv python3-pip
      ;;
  esac
}
f_zero_venv_create() {
  _f_echo "$SYS_PYTHON_EXE -m venv $VENV_DIR"
  $SYS_PYTHON_EXE -m venv $VENV_DIR
}
#------------------------------------------------------
f_zero_bash() {
  cd $BASE_DIR/bash
  cp --update=none $HOME/.bashrc $HOME/.bashrc.orig
  cat bashrc_zero_func.sh bashrc_zero.sh > $HOME/.bashrc
}
f_zero_vim() {
  cd $BASE_DIR/vim
  cat vimrc_zero.vim > $HOME/.vimrc
}
f_zero_batcat() {
  if [ "$SYS_CAT_EXE" = 'batcat' ]; then
    _f_echo_T "batcat build"
    batcat cache --build
  fi
}
#------------------------------------------------------
if [ ! -d "$VENV_DIR" ]; then
  f_zero_symlink
  f_zero_sys
  f_zero_venv_create
fi
f_zero_bash
f_zero_vim
f_zero_batcat
