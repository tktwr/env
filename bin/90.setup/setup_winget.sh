#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_winget_install_min() {
  winget.exe install sharkdp.fd
  winget.exe install sharkdp.bat
  winget.exe install junegunn.fzf
  winget.exe install BurntSushi.ripgrep.MSVC
  winget.exe install dandavison.delta
  winget.exe install JesseDuffield.lazygit
}

f_winget_cp_exe() {
  src_dir=$SYS_WIN_HOME/AppData/Local/Microsoft/WinGet/Packages
  dst_dir=$SYS_ROAMING_HOME/opt/bin
  mkdir -p $dst_dir
  find $src_dir -name '*.exe' -exec cp {} $dst_dir \;
  cd $dst_dir
  mv fd.exe fdfind.exe
  mv bat.exe batcat.exe
}

#======================================================
# main
#======================================================
f_fzf_main "$@"

