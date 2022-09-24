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
"

#======================================================
# functions
#======================================================
f_mirror() {
  echo "f_mirror: use MX Tools"
}

f_update() {
  sudo apt update
  sudo apt upgrade
}

f_install_min() {
  sudo apt install $pkg_min
}

f_install_ext() {
  sudo apt install $pkg_ext
}

#------------------------------------------------------
f_desktop() {
  LC_ALL=C xdg-user-dirs-gtk-update
}

f_font() {
  cp $FONTS ~/.local/share/fonts
}

f_im() {
  echo "f_im: use MX Tools"
}

f_dir() {
  sudo mkdir -p $WIN_HOME

  cd
  ln -s $WIN_HOME WinHome
  ln -s WinHome/MyConfig .
  ln -s WinHome/MyShare .
}

#------------------------------------------------------
f_python_venv() {
}

#------------------------------------------------------
f_init() {
  if [ ! -d $ENV_DIR ]; then
    echo "$ENV_DIR is not a directory"
    return
  fi

  f_mirror
  f_update
  f_install_min

  f_desktop
  #f_font
  #f_im
  f_dir

  #f_python_venv
}

#------------------------------------------------------
f_help() {
  echo "mirror      ... mirror"
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "----------- ... -----------------------------"
  echo "desktop     ... desktop"
  echo "font        ... font"
  echo "im          ... im"
  echo "dir         ... dir"
  echo "----------- ... -----------------------------"
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
