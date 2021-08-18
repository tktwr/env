#!/bin/bash

pkg_min="\
virtualbox-guest-utils \
git \
vim \
nodejs npm \
python3-venv \
"

pkg_ext="\
universal-ctags \
cmake \
vim-gtk3 \
vifm \
clang \
clang-tools-7 \
python3-dev \
fzf \
"

pkg="$pkg_min $pkg_ext"

sudo apt install $pkg

