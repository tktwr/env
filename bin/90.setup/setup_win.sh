#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_win_ip() {
  ipconfig.exe
}
f_win_net_info() {
  _f_title "port"
  netsh.exe interface portproxy show v4tov4

  _f_title "share"
  net.exe share

  _f_title "use"
  net.exe use
}
#------------------------------------------------------
f_win_ls_config_dir() {
  local dirs="\
    $SYS_WIN_HOME/AppData/Roaming \
    $SYS_WIN_HOME/AppData/Local \
    $SYS_WIN_HOME/AppData/Local/Temp \
    "
  for i in $dirs; do
    _f_title $i
    ls.sh $i
  done
}
