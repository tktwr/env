#!/bin/bash

f_zero2_apt() {
  apt_pkg_min="\
    vim fzf fd-find ripgrep bat \
    zip unzip universal-ctags tree ncdu \
    git-lfs \
    "
  sudo -E apt install $apt_pkg_min
}
f_zero2_pip() {
  pip_pkg_min="\
    wheel numpy \
    "
  pip install $pip_pkg_min
}
f_zero2_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  \. "$HOME/.nvm/nvm.sh"
  nvm install 24
}
f_zero2_vim() {
  vim -c 'PlugUpgrade'
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}
#------------------------------------------------------
f_zero2_apt
f_zero2_pip
f_zero2_nvm
f_zero2_vim
