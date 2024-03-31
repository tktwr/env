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
# batcat
#------------------------------------------------------
f_batcat_list()  { batcat -L; }
f_batcat_build() { batcat cache --build; }
f_batcat_clear() { batcat cache --clear; }
