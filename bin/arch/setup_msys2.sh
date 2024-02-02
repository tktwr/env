#!/bin/bash

#======================================================
# variables
#======================================================
pkg_min="\
winpty \
vim \
bc \
zip unzip \
openssh \
"

pkg_ext="\
fzy \
make \
rsync \
diffstat \
diffutils \
patch \
patchutils \
man-db \
man-pages-posix \
mingw-w64-x86_64-ninja \
mingw-w64-x86_64-universal-ctags-git \
mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz \
mingw-w64-x86_64-qpdf \
mingw-w64-x86_64-ghostscript \
mingw-w64-x86_64-ffmpeg \
mingw-w64-x86_64-ripgrep \
mingw-w64-x86_64-ag \
"

pkg_dev="\
mingw-w64-x86_64-clang \
mingw-w64-x86_64-clang-tools-extra \
mingw-w64-x86_64-clang-analyzer \
mingw-w64-x86_64-compiler-rt \
mingw-w64-x86_64-glfw \
mingw-w64-x86_64-glew \
mingw-w64-x86_64-freeglut \
mingw-w64-x86_64-glm \
mingw-w64-x86_64-opencv \
mingw-w64-x86_64-openexr \
"

pkg_uninstalled="\
ninja \
tmux \
ctags \
git \
subversion \
vimpager \
global \
python \
vifm \
base-devel \
mingw-w64-x86_64-toolchain \
mingw-w64-x86_64-cmake \
mingw-w64-x86_64-python3-pip \
mingw-w64-x86_64-python2-pip \
mingw-w64-x86_64-gnuplot \
"

#======================================================
# functions
#======================================================
f_update() {
  pacman -Syyu
}

f_install_min() {
  pacman -S --needed $pkg_min
}

f_install_ext() {
  pacman -S --needed $pkg_ext
}

f_install_dev() {
  pacman -S --needed $pkg_dev
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
