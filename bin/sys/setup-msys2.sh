#!/bin/bash

pkg_min="\
winpty \
vim \
bc \
zip unzip \
openssh \
"

pkg_ext="\
make \
rsync \
diffstat \
diffutils \
patch \
patchutils \
man-db \
man-pages-posix \
fzy \
mingw-w64-x86_64-ninja \
mingw-w64-x86_64-universal-ctags-git \
mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz \
mingw-w64-x86_64-qpdf \
mingw-w64-x86_64-ghostscript \
mingw-w64-x86_64-ffmpeg \
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

pkg="$pkg_min $pkg_ext $pkg_dev"

pacman -S --needed $pkg

