#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_10_setup_daily() {
  f_vim_plug_update
}
f_11_setup_time() {
  sync-time.sh
}
f_21_setup_weekly() {
  weekly-tags.sh
}
f_22_setup_monthly() {
  monthly-tags.sh
}
f_90_setup_init() {
  f_apt_update
  f_apt_install_min
  f_pip_upgrade
  f_pip_install_min
  f_nodejs_install
  f_vim_plug_upgrade
  f_vim_plug_install
}
f_91_setup_update() {
  f_apt_update
  f_pip_upgrade
  f_vim_plug_update
}
#------------------------------------------------------
f_info_env()     { print-env.sh; }
f_info_path()    { print-path.sh; }
f_info_version() { print-version.sh; }

f_popup_nvidia_smi()     { vimapi_exec "VisShellPopup watch nvidia-smi"; }
f_popup_nvidia_smi_exe() { vimapi_exec "VisShellPopup watch nvidia-smi.exe"; }
f_popup_info_os()        { vimapi_exec "VisShellPopup pause.sh neofetch"; }
f_popup_btop()           { vimapi_exec "VisShellPopup btop"; }
f_popup_htop()           { vimapi_exec "VisShellPopup htop -t"; }
f_popup_apt()            { vimapi_exec "VisShellPopup fzf_apt.sh"; }
f_popup_pip()            { vimapi_exec "VisShellPopup fzf_pip.sh"; }
f_popup_dpkg()           { vimapi_exec "VisShellPopup fzf_dpkg.sh"; }
#------------------------------------------------------
setup_files="\
  $MY_BIN/90.setup/setup_*.sh \
  $SYS_CONFIG_HOME/lconfig/bin/setup_*.sh \
  "
for setup_file in $setup_files; do
  if [ -f $setup_file ]; then
    source $setup_file
  fi
done

#======================================================
# main
#======================================================
f_fzf_main "$@"
