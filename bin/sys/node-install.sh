#!/bin/bash

sudo apt purge nodejs
sudo apt autoremove

#curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup_18.sh
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

cat /etc/apt/sources.list.d/nodesource.list
node --version
npm --version
