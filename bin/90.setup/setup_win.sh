#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
_f_title() {
  echo "--- [$*] ----------"
}

f_win_net_info() {
  _f_title "port"
  netsh.exe interface portproxy show v4tov4

  _f_title "share"
  net.exe share

  _f_title "use"
  net.exe use
}

