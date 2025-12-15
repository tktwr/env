#!/bin/bash

f_github_tags() {
  local C_TAGS_DIRS="\
    $MY_GITHUB \
    "
  for-dir.sh "mymake.sh f_tags" $C_TAGS_DIRS
}

f_blender_clean() {
  rm $APP_L/Temp/*_autosave.blend
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

