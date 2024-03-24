#!/bin/bash

#------------------------------------------------------
# linux
#------------------------------------------------------
f_linux_services() {
  systemctl list-unit-files -t service
}
f_linux_ls_mount() {
  mount | grep 9p | $GIT_PAGER
}
f_linux_ip() {
  ip -4 a
}
f_linux_ncdu() {
  ncdu
}
#------------------------------------------------------
f_linux_ls_config_dir() {
  local dirs="\
    $HOME/.config \
    $HOME/.local/share \
    $HOME/.cache \
    "
  for i in $dirs; do
    _f_title $i
    ls.sh $i
  done
}
#------------------------------------------------------
# popup
#------------------------------------------------------
f_linux_info()    { vimapi_exec 'VisShellPop pop_neofetch.sh'; }
f_linux_btop()    { vimapi_exec 'VisShellPop btop'; }
f_linux_htop()    { vimapi_exec 'VisShellPop pop_htop.sh'; }
f_linux_cal()     { vimapi_exec 'VisShellPop pop_cal.sh'; }
f_linux_lazygit() { vimapi_exec 'VisShellPop lazygit.sh'; }
f_linux_man()     { vimapi_exec 'VisShellPop fzf_man.sh'; }
f_linux_apt()     { vimapi_exec 'VisShellPop fzf_apt.sh'; }
f_linux_pip()     { vimapi_exec 'VisShellPop fzf_pip.sh'; }
f_linux_dpkg()    { vimapi_exec 'VisShellPop fzf_dpkg.sh'; }
#------------------------------------------------------
# nvidia
#------------------------------------------------------
f_nvidia_smi()     { watch nvidia-smi; }
f_nvidia_smi_exe() { watch nvidia-smi.exe; }
#------------------------------------------------------
# batcat
#------------------------------------------------------
f_batcat_list()  { batcat -L; }
f_batcat_build() { batcat cache --build; }
f_batcat_clear() { batcat cache --clear; }
