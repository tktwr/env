#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
#------------------------------------------------------
# popup
#------------------------------------------------------
f_popup_nvidia_smi()     { vimapi_exec "VisShellPopup nvidia_smi.sh"; }
f_popup_nvidia_smi_exe() { vimapi_exec "VisShellPopup nvidia_smi_exe.sh"; }
f_popup_info()           { vimapi_exec "VisShellPopup neofetch.sh"; }
f_popup_btop()           { vimapi_exec "VisShellPopup btop"; }
f_popup_htop()           { vimapi_exec "VisShellPopup htop.sh"; }
f_popup_cal()            { vimapi_exec "VisShellPopup cal.sh"; }
f_popup_gs()             { vimapi_exec "VisShellPopup gs.sh"; }
f_popup_gv()             { vimapi_exec "VisShellPopup gv.sh"; }
f_popup_lazygit()        { vimapi_exec "VisShellPopup lazygit.sh"; }
f_popup_man()            { vimapi_exec "VisShellPopup fzf_man.sh"; }
f_popup_apt()            { vimapi_exec "VisShellPopup fzf_apt.sh"; }
f_popup_pip()            { vimapi_exec "VisShellPopup fzf_pip.sh"; }
f_popup_dpkg()           { vimapi_exec "VisShellPopup fzf_dpkg.sh"; }
#------------------------------------------------------
cmd_files="\
  $MY_BIN/90.setup/cmd_*.sh \
  $SYS_CONFIG_HOME/lconfig/bin/cmd_*.sh \
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
