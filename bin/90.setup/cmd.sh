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
f_popup_cal()            { vimapi_exec "VisShellPopup pause.sh cal -y"; }
f_popup_gs()             { vimapi_exec "VisShellPopup gs.sh"; }
f_popup_gv()             { vimapi_exec "VisShellPopup gv.sh"; }
f_popup_lazygit()        { vimapi_exec "VisShellPopup lazygit.sh"; }
f_popup_man()            { vimapi_exec "VisShellPopup fzf_man.sh"; }
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
