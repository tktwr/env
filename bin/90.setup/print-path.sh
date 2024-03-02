#!/bin/bash

_f_title() {
  echo "--- [$*] ----------"
}

f_format_path_unix() {
  sed 's+:+\n+g'
}

f_format_path_win() {
  sed 's+;+\n+g'
}

#------------------------------------------------------
f_print_sys_path() {
  _f_title "SYS_PATH"

  echo "$SYS_PATH" | f_format_path_unix
}

f_print_path() {
  _f_title "PATH"

  echo "$PATH" | f_format_path_unix
}

f_print_python_path() {
  _f_title "PYTHONPATH"

  case $MY_OS_NAME in
    msys|gitbash)
      echo "$PYTHONPATH" | f_format_path_win
      ;;
    *)
      echo "$PYTHONPATH" | f_format_path_unix
      ;;
  esac
}

#------------------------------------------------------
f_print_sys_path
f_print_path
f_print_python_path
