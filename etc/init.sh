#!/bin/bash
#
# init.sh USER_NAME

USER_NAME=${1:-user_name}
WIN_HOME=/mnt/c/Users/$USER_NAME

if [ ! -d $WIN_HOME ]; then
  echo "no dir: $WIN_HOME"
  exit
fi
if [ -d $HOME/MyRoaming ]; then
  echo "already exist: $HOME/MyRoaming"
  exit
fi

f_init_mkdir() {
  # make dirs in win
  cd $WIN_HOME
  mkdir -p MyRoaming MyConfig MyData MyProj MyWork

  # symbolic links in linux
  cd
  mkdir -p MyRoaming
  ln -s $WIN_HOME        WinHome
  ln -s WinHome/MyConfig MyConfig
  ln -s WinHome/MyData   MyData
  ln -s WinHome/MyProj   MyProj
  ln -s WinHome/MyWork   MyWork
}

f_init_mkdir
