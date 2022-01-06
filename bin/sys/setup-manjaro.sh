#!/bin/bash

WIN_HOME=/mnt/vbox/Takeh

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
f_default() {
  f_help
}

f_init() {
  sudo pacman-mirrors --country Japan
  sudo pacman -Syyu
  sudo usermod -a -G vboxsf `whoami`
  sudo mkdir -p $WIN_HOME

  LC_ALL=C xdg-user-dirs-gtk-update

  cd
  ln -s $WIN_HOME WinHome
  ln -s WinHome/MyConfig .
  ln -s WinHome/MyShare .
}

f_install_min() {
  sudo pacman -S --needed $pkg_min
}

f_install_ext() {
  sudo pacman -S --needed $pkg_ext
}

f_font() {
  cp Cica.ttc ~/.local/share/fonts
}

f_python() {
  mypython-venv-create torch
  pip-upgrade.sh
  pip-install.sh
}

f_help() {
  echo "init        ... init"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "font        ... font"
  echo "python      ... python"
  echo "help        ... print help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"

