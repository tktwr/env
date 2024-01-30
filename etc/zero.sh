#!/bin/bash

f_symlink() {
  if [ ! -e "$2" -a ! -L "$2" ]; then
    echo "ln -s $1 $2"
    ln -s $1 $2
  fi
}

#------------------------------------------------------
f_zero_backup() {
  cp -n $HOME/.bashrc $HOME/.bashrc.orig
}

f_zero_init() {
  mkdir -p $HOME/.my
  mkdir -p $HOME/.mycache
}

f_zero_bash() {
  cd bash
  ./zero_hostname.sh > $HOME/.my/hostname.sh
  cat bashrc_zero.sh > $HOME/.bashrc
  cd ..
}

f_zero_vim() {
  cd vim
  cat vimrc_zero.vim > $HOME/.vimrc
  cd ..
}

f_zero_symlink() {
  cd

  # ln -s /mnt/c/Users/$USER      WinHome
  # ln -s /mnt/hgfs/$USER         WinHome
  # ln -s /cygdrive/c/Users/$USER WinHome

  f_symlink WinHome/MyConfig MyConfig
  f_symlink WinHome/MyData   MyData
  f_symlink WinHome/MyProj   MyProj
  f_symlink WinHome/MyWork   MyWork
}

f_zero_batcat() {
  if [ "$SYS_CAT_EXE" = 'batcat' ]; then
    echo "[batcat] build"
    batcat cache --build
  fi
}

#------------------------------------------------------
f_zero_backup
f_zero_init
f_zero_bash
f_zero_vim
f_zero_symlink
f_zero_batcat
