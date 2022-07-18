#!/bin/bash

#======================================================
# variables
#======================================================
WIN_HOME=/mnt/c/Users/Takeh

pkg_min="\
vim \
nodejs npm \
python3-pip \
python3-venv \
"

pkg_ext="\
fzy \
neovim \
zip unzip \
universal-ctags \
cmake \
clang \
clang-format \
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
  ln -s $WIN_HOME WinHome
  ln -s WinHome/MyConfig .
  ln -s WinHome/MyShare .
}

f_python_venv() {
  mypython.sh --create-venv torch
  source $HOME/.bashrc
  #pip-upgrade.sh
  #pip-install.sh
}

#------------------------------------------------------
f_init() {
}

f_help() {
  echo "init        ... init"
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "dir         ... dir"
  echo "python_venv ... python_venv"
  echo "help        ... print help"
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

