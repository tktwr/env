#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
#------------------------------------------------------
# vim
#------------------------------------------------------
f_install_vim_stubs() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git
}

f_install_vim() {
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_update_vim() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

#------------------------------------------------------
# nvim
#------------------------------------------------------
f_install_nvim() {
  sudo -E npm install -g neovim
}

#------------------------------------------------------
# nodejs
#------------------------------------------------------
f_install_nodejs() {
  install-nodejs.sh
}

f_install_wsltty_config() {
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp $MY_ENV/setup/win/wsltty/config $wsltty_dir
}

#------------------------------------------------------
f_install_winget_min() {
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

#------------------------------------------------------
f_print_env() {
  print-env.sh
}

f_print_path() {
  print-path.sh
}

f_print_version() {
  print-version.sh
}

#------------------------------------------------------
f_set_hwclock() {
  set-hwclock.sh
}

#------------------------------------------------------
f_setup_ubuntu() {
  eval_fzf_cmd setup_ubuntu.sh
}

f_setup_python() {
  eval_fzf_cmd setup_python.sh
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
