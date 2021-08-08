#!/bin/bash

pkg="\
vim \
make \
cmake \
fcitx-im fcitx-mozc fcitx-configtool \
nodejs npm \
clang \
"

pkg_lib="\
"

sudo pacman -S --needed $pkg $pkg_lib

