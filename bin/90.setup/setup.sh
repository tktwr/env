#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_print_env() {
  print-env.sh
}

f_print_path() {
  print-path.sh
}

f_print_version() {
  print-version.sh
}

#------------------------------------------------------
f_set_hwclock() {
  set-hwclock.sh
}

#------------------------------------------------------
f_setup_wsl() {
  eval_fzf_cmd setup_wsl.sh
}

f_setup_ubuntu() {
  eval_fzf_cmd setup_ubuntu.sh
}

f_setup_python() {
  eval_fzf_cmd setup_python.sh
}

f_setup_vim() {
  eval_fzf_cmd setup_vim.sh
}

#------------------------------------------------------
f_help() {
  echo "print_env     ... print env"
  echo "print_path    ... print path"
  echo "print_version ... print version"
  echo "-----------   ... -----------------------------"
  echo "set_hwclock   ... set hwclock"
  echo "-----------   ... -----------------------------"
  echo "setup_wsl     ... setup wsl"
  echo "setup_ubuntu  ... setup ubuntu"
  echo "setup_python  ... setup python"
  echo "setup_vim     ... setup vim"
  echo "-----------   ... -----------------------------"
  echo "help          ... print help"
}

f_default() {
  f_help
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
