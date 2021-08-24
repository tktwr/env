#!/bin/bash

pkg_min="\
vim \
nodejs npm \
python3-venv \
"

pkg_ext="\
vim-gtk3 \
vifm \
universal-ctags \
cmake \
clang \
clang-tools-7 \
python3-dev \
fzf \
"

pkg="$pkg_min $pkg_ext"

sudo apt install $pkg

