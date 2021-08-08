#!/bin/bash

pkg="\
vim \
vim-gtk3 \
vifm \
universal-ctags \
cmake \
clang \
clang-tools-7 \
python3-venv \
python3-dev \
nodejs npm \
fzf \
"

pkg_lib="\
"

sudo apt install $pkg $pkg_lib

