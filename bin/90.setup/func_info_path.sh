#!/bin/bash

_f_format_path_unix() {
  sed 's+:+\n+g'
}

_f_format_path_win() {
  sed 's+;+\n+g'
}

#------------------------------------------------------
f_info_path_sys() {
  _f_title "SYS_PATH"

  echo "$SYS_PATH" | _f_format_path_unix
}

f_info_path() {
  _f_title "PATH"

  echo "$PATH" | _f_format_path_unix
}

f_info_path_python() {
  _f_title "PYTHONPATH"

  case $MY_OS_NAME in
    msys|gitbash)
      echo "$PYTHONPATH" | _f_format_path_win
      ;;
    *)
      echo "$PYTHONPATH" | _f_format_path_unix
      ;;
  esac
}

