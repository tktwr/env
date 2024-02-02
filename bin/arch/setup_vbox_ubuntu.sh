#!/bin/bash

#======================================================
# variables
#======================================================
WIN_HOME=/mnt/vbox/Takeh
ENV_DIR=~/MyRoaming/env
FONTS=Cica.ttc

pkg_min="\
vim \
fzf \
nodejs npm \
python3-pip \
python3-venv \
git-lfs \
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
ffmpegthumbnailer \
gstreamer1.0-libav \
vlc \
gimp \
imagemagick \
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

#======================================================
# main
#======================================================
f_fzf_main "$@"
