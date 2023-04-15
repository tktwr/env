#!/bin/bash

f_title() {
  echo "=== [$*] =========="
}

f_info() {
  f_title "port"
  netsh.exe interface portproxy show v4tov4

  f_title "share"
  net.exe share

  f_title "use"
  net.exe use
}

#------------------------------------------------------
f_info
