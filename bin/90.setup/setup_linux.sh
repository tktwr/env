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
#------------------------------------------------------
