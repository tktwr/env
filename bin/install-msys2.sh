#!/bin/bash

pkg="\
winpty \
vim \
bc \
fzy \
zip unzip \
man-pages-posix \
base-devel \
mingw-w64-x86_64-toolchain \
mingw-w64-x86_64-clang \
mingw-w64-x86_64-clang-tools-extra \
mingw-w64-x86_64-clang-analyzer \
mingw-w64-x86_64-compiler-rt \
mingw-w64-x86_64-universal-ctags-git \
mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz \
mingw-w64-x86_64-qpdf \
mingw-w64-x86_64-ghostscript \
"

pkg_lib="\
mingw-w64-x86_64-glfw \
mingw-w64-x86_64-glew \
mingw-w64-x86_64-freeglut \
mingw-w64-x86_64-glm \
mingw-w64-x86_64-opencv \
"

pkg_uninstalled="\
tmux \
ctags \
git \
subversion \
vimpager \
global \
python \
vifm \
mingw-w64-x86_64-cmake \
mingw-w64-x86_64-python3-pip \
mingw-w64-x86_64-python2-pip \
mingw-w64-x86_64-gnuplot \
"

pacman -S --needed $pkg $pkg_lib

