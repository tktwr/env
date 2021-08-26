#!/bin/sh

cd

# for cygwin
ln -s /cygdrive/c/Users/$USER WinHome

# for linux on VMware
#ln -s /mnt/hgfs/$USER WinHome

ln -s WinHome/Desktop .
ln -s WinHome/Downloads .
ln -s WinHome/MyConfig .
ln -s WinHome/MyShare .

ln -s WinHome/Dropbox .
ln -s WinHome/GoogleDrive .
#ln -s MyConfig/tktwr.github/env/etc/vim .vim

