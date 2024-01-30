#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_install_nodejs() {
sudo -E apt purge nodejs
sudo -E apt autoremove

#curl -L https://deb.nodesource.com/setup_18.x -o nodesource_setup_18.sh
curl -L https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo -E apt install -y nodejs
}

f_nodejs_version() {
  cat /etc/apt/sources.list.d/nodesource.list
  node --version
  npm --version
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
