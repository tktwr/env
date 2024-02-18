#!/bin/bash

#======================================================
# variables
#======================================================
apt_pkg_min="\
vim fzf fd-find ripgrep bat \
tree ncdu \
zip unzip \
universal-ctags \
eblook \
python3-pip \
python3-venv \
python3-poetry \
pipx \
"
apt_pkg_ext="\
vim-gtk3 \
neovim \
imagemagick \
img2pdf \
poppler-utils \
fontforge \
subversion \
neofetch \
btop \
ncal \
googler \
ghostscript \
x11-apps \
lhasa \
encfs \
"
apt_pkg_dev="\
cmake \
clang \
clangd \
clang-format \
libglfw3-dev \
libopencv-dev \
python3-tk \
python3-opencv \
python3-doc \
"
apt_pkg_not_install="\
blender \
nvidia-cuda-toolkit \
baobab \
nodejs npm \
exa \
"
#======================================================
# functions
#======================================================
f_apt_update() {
  sudo -E apt update
  sudo -E apt upgrade
  sudo -E apt autoremove
}
#------------------------------------------------------
f_apt_install_min() { sudo -E apt install $apt_pkg_min; }
f_apt_install_ext() { sudo -E apt install $apt_pkg_ext; }
f_apt_install_dev() { sudo -E apt install $apt_pkg_dev; }
#------------------------------------------------------
# linux
#------------------------------------------------------
f_linux_services() { systemctl list-unit-files -t service; }
f_linux_mount()    { mount | grep 9p | $GIT_PAGER; }
#------------------------------------------------------
# nvidia
#------------------------------------------------------
f_nvidia_smi()          { watch nvidia-smi; }
f_nvidia_smi_exe()      { watch nvidia-smi.exe; }
#------------------------------------------------------
# batcat
#------------------------------------------------------
f_batcat_list()  { batcat -L; }
f_batcat_build() { batcat cache --build; }
f_batcat_clear() { batcat cache --clear; }
