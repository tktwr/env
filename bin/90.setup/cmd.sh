#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_11_setup_time() {
  sync-time.sh
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
# info
#------------------------------------------------------
f_info_env()     { print-env.sh     | fzf; }
f_info_path()    { print-path.sh    | fzf; }
f_info_version() { print-version.sh | fzf; }
#------------------------------------------------------
# popup
#------------------------------------------------------
f_popup_nvidia_smi()     { vimapi_exec "VisShellPopup watch nvidia-smi"; }
f_popup_nvidia_smi_exe() { vimapi_exec "VisShellPopup watch nvidia-smi.exe"; }
f_popup_info_os()        { vimapi_exec "VisShellPopup pause.sh neofetch"; }
f_popup_btop()           { vimapi_exec "VisShellPopup btop"; }
f_popup_htop()           { vimapi_exec "VisShellPopup htop -t"; }
f_popup_pip()            { vimapi_exec "VisShellPopup fzf_pip.sh"; }
f_popup_dpkg()           { vimapi_exec "VisShellPopup fzf_dpkg.sh"; }
#------------------------------------------------------
f_popup_cal()            { vimapi_exec "VisShellPopup pause.sh cal -y"; }
f_popup_gs()             { vimapi_exec "VisShellPopup gs.sh"; }
f_popup_gv()             { vimapi_exec "VisShellPopup gv.sh"; }
f_popup_lazygit()        { vimapi_exec "VisShellPopup lazygit.sh"; }
f_popup_man()            { vimapi_exec "VisShellPopup fzf_man.sh"; }
f_popup_apt()            { vimapi_exec "VisShellPopup fzf_apt.sh"; }
#------------------------------------------------------
cmd_files="\
  $MY_BIN/90.setup/func_*.sh \
  $SYS_CONFIG_HOME/lconfig/bin/func_*.sh \
  "
for cmd_file in $cmd_files; do
  if [ -f $cmd_file ]; then
    source $cmd_file
  fi
done

#======================================================
# main
#======================================================
f_fzf_main "$@"
