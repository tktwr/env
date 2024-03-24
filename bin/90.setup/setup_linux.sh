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
f_linux_info() { vimapi_exec 'VisShellOpen neofetch pop_neofetch.sh pop'; }
f_linux_btop() { vimapi_exec 'VisShellOpen btop     btop pop'; }
f_linux_htop() { vimapi_exec 'VisShellOpen htop     pop_htop.sh pop'; }
f_linux_cal()  { vimapi_exec 'VisShellOpen cal      pop_cal.sh pop'; }
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
