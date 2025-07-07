#!/bin/bash

#======================================================
# variables
#======================================================
winget_pkg="\
  sharkdp.fd \
  sharkdp.bat \
  junegunn.fzf \
  BurntSushi.ripgrep.MSVC \
  dandavison.delta \
  JesseDuffield.lazygit \
  OpenJS.NodeJS.LTS \
  Kitware.CMake \
  Neovim.Neovim \
  CondaForge.Miniforge3 \
  Genymobile.scrcpy \
  "

#======================================================
# functions
#======================================================
f_winget_install() {
  for i in $winget_pkg; do
    winget.exe install -e --id $i
  done
}

f_winget_upgrade() {
  for i in $winget_pkg; do
    winget.exe upgrade -e --id $i
  done
}

f_winget_upgradable() {
  winget.exe upgrade
}

f_winget_cp_exe() {
  src_dir=$SYS_WIN_HOME/AppData/Local/Microsoft/WinGet/Packages
  dst_dir=$SYS_CONFIG_HOME/opt/winget
  mkdir -p $dst_dir
  find $src_dir -name '*.exe' -exec cp {} $dst_dir \;
  cd $dst_dir
  mv fd.exe fdfind.exe
  mv bat.exe batcat.exe
}

