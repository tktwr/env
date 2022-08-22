#!/bin/bash

#======================================================
# variables
#======================================================
WIN_HOME=/mnt/c/Users/Takeh
ENV_DIR=~/MyRoaming/env

pkg_min="\
vim \
nodejs npm \
python3-pip \
python3-venv \
fzy \
zip unzip \
universal-ctags \
eblook \
ripgrep \
"
pkg_ext="\
vim-gui-common \
neovim \
cmake \
clang \
clangd \
clang-format \
"
pkg_ext2="\
blender \
nvidia-cuda-toolkit \
"

#======================================================
# functions
#======================================================
f_update() {
  sudo -E apt update
  sudo -E apt upgrade
}

f_install_min() {
  sudo -E apt install $pkg_min
}

f_install_ext() {
  sudo -E apt install $pkg_ext
}

f_dir() {
  cd
  if [ ! -d "WinHome" ]; then
    ln -s $WIN_HOME WinHome
  fi
}

f_etc() {
  cd $ENV_DIR/etc
  ./make.sh init
  source $HOME/.bashrc
}

f_wsltty() {
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp $ENV_DIR/os.windows/wsltty/config $wsltty_dir
}

f_python_venv() {
  mypython.sh --create-venv torch
  source $HOME/.bashrc

  if [ $MY_PYTHON_VENV = "torch" ]; then
    pip-upgrade.sh
    pip-install.sh install_vim
  fi
}

#------------------------------------------------------
f_init() {
  if [ ! -d $ENV_DIR ]; then
    echo "$ENV_DIR is not a directory"
    return
  fi

  f_update
  f_install_min
  f_dir
  f_etc
  f_wsltty
  #f_python_venv
}

f_help() {
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "dir         ... dir"
  echo "etc         ... etc"
  echo "wsltty      ... wsltty"
  echo "python_venv ... python_venv"
  echo "----------- ... -----------------------------"
  echo "init        ... init"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help (default)"
}

f_default() {
  f_help
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"

