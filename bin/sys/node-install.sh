#!/bin/bash

sudo apt purge nodejs
sudo apt autoremove

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

cat /etc/apt/sources.list.d/nodesource.list
node --version
npm --version
