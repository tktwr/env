#!/bin/bash

BASE_DIR=$(pwd)
echo $BASE_DIR

#------------------------------------------------------
f_symlink() {
  if [ ! -e "$2" -a ! -L "$2" ]; then
    echo "ln -s $1 $2"
    ln -s $1 $2
  fi
}

#------------------------------------------------------
f_zero_sys() {
  sudo -E apt update
  sudo -E apt upgrade
  sudo -E apt autoremove
  sudo -E apt install python3-venv python3-pip
}

f_zero_dir() {
  cd

  # ln -s /mnt/c/Users/$USER      WinHome
  # ln -s /mnt/hgfs/$USER         WinHome
  # ln -s /cygdrive/c/Users/$USER WinHome

  f_symlink WinHome/MyConfig MyConfig
  f_symlink WinHome/MyData   MyData
  f_symlink WinHome/MyProj   MyProj
  f_symlink WinHome/MyWork   MyWork

  mkdir -p $HOME/.my
  mkdir -p $HOME/.mycache
}

f_zero_bash() {
  cd $BASE_DIR/bash
  cp -n $HOME/.bashrc $HOME/.bashrc.orig
  ./zero_hostname.sh > $HOME/.my/hostname.sh
  cat bashrc_zero.sh > $HOME/.bashrc
}

f_zero_vim() {
  cd $BASE_DIR/vim
  cat vimrc_zero.vim > $HOME/.vimrc
}

f_zero_venv() {
  local dir=$HOME/.venv
  if [ ! -d "$dir" ]; then
    echo "python3 -m venv $dir"
    python3 -m venv $dir
  fi
}

f_zero_batcat() {
  if [ "$SYS_CAT_EXE" = 'batcat' ]; then
    echo "[batcat] build"
    batcat cache --build
  fi
}

#------------------------------------------------------
#f_zero_sys
f_zero_dir
f_zero_bash
f_zero_vim
f_zero_venv
f_zero_batcat
