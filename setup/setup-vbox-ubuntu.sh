#!/bin/bash

#======================================================
# variables
#======================================================
WIN_HOME=/mnt/vbox/Takeh
ENV_DIR=~/MyRoaming/env
FONTS=Cica.ttc

pkg_min="\
vim \
nodejs npm \
python3-pip \
python3-venv \
fzf \
fzy \
"
pkg_ext="\
vim-gtk3 \
neovim \
universal-ctags \
cmake \
clang \
clang-tools \
python3-dev \
img2pdf \
ffmpeg \
vlc \
gimp \
"

#======================================================
# functions
#======================================================
f_update() {
  sudo apt update
  sudo apt upgrade
  sudo apt autoremove
}

f_install_min() {
  sudo apt install $pkg_min
}

f_install_ext() {
  sudo apt install $pkg_ext
}

#------------------------------------------------------
f_init() {
  f_update
  f_install_min
}

#------------------------------------------------------
f_help() {
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
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
