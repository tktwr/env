#!/bin/sh

cd

# for cygwin
ln -s /cygdrive/c/Users/$USER WinHome

# for linux on VMware
#ln -s /mnt/hgfs/$USER WinHome

ln -s WinHome/Desktop Desktop
ln -s WinHome/Downloads Downloads
ln -s WinHome/Dropbox Dropbox
ln -s "WinHome/Google\ ドライブ" GoogleDrive

ln -s WinHome/tktwr.github/env/etc/vim .vim

