#!/bin/bash

pkg_min="\
virtualbox-guest-utils \
xdg-user-dirs-gtk \
fcitx-im fcitx-mozc fcitx-configtool \
vim \
nodejs npm \
"

pkg_default="\
neovim \
make \
cmake \
clang \
ctags \
"

pkg="$pkg_min $pkg_default"

sudo pacman -S --needed $pkg

