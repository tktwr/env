#!/bin/bash

#======================================================
# variables
#======================================================
WIN_HOME=/mnt/vbox/Takeh
FONTS=Cica.ttc

pkg_min="\
virtualbox-guest-utils \
xdg-user-dirs-gtk \
fcitx-im fcitx-mozc fcitx-configtool \
vim \
nodejs npm \
"

pkg_ext="\
neovim \
make \
cmake \
clang \
ctags \
"

#======================================================
# functions
#======================================================
f_mirror() {
  sudo pacman-mirrors --country Japan
}

f_update() {
  sudo pacman -Syyu
}

f_install_min() {
  sudo pacman -S --needed $pkg_min
}

f_install_ext() {
  sudo pacman -S --needed $pkg_ext
}

f_desktop() {
  LC_ALL=C xdg-user-dirs-gtk-update
}

f_font() {
  cp $FONTS ~/.local/share/fonts
}

f_im() {
  echo "f_im:"
}

f_dir() {
  sudo usermod -a -G vboxsf `whoami`
  sudo mkdir -p $WIN_HOME

  cd
  ln -s $WIN_HOME WinHome
  ln -s WinHome/MyConfig .
  ln -s WinHome/MyShare .
}

f_python() {
  mypython-venv-create torch
  pip-upgrade.sh
  pip-install.sh
}

#======================================================
# init
#======================================================
f_default() {
  f_help
}

f_init() {
  f_mirror
  f_update
  f_install_min
  #f_install_ext
  f_desktop
  #f_font
  #f_im
  f_dir
  #f_python
}

f_help() {
  echo "init        ... init"
  echo "mirror      ... mirror"
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "desktop     ... desktop"
  echo "font        ... font"
  echo "im          ... im"
  echo "dir         ... dir"
  echo "python      ... python"
  echo "help        ... print help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"

