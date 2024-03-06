#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_nodejs_install() {
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

f_npm_list() {
  npm list
}

f_npm_config() {
  npm config ls -l
}
