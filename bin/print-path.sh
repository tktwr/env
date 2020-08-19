#!/bin/bash

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] [path]"
  echo
  echo "OPTIONS"
  echo "  -h, --help   print help"
  echo "  -p, --path   print path"
  echo "  -d, --dos    format dos path"
  echo "  -u, --unix   format unix path"
  echo
}

f_format_unix_path() { sed 's+:+\n+g'; }
f_format_dos_path() { sed 's+;+\n+g'; }
FORMAT=f_format_unix_path

f_print_path() {
  echo "=== [SYS_PATH] ==="
  echo "$SYS_PATH" | $FORMAT
  echo
  echo "=== [PATH] ==="
  echo "$PATH" | $FORMAT
  echo
  echo "=== [env] ==="
  echo "MY_PYTHON_TYPE: $MY_PYTHON_TYPE"
  echo "MY_PYTHON_VENV: $MY_PYTHON_VENV"
  echo "MY_PYTHON_VENV_DIR: $MY_PYTHON_VENV_DIR"
  echo "MY_PYTHON_EXE: $MY_PYTHON_EXE"
  echo
  echo "=== [which] ==="
  which python
  python --version
  which pip
  pip --version
  which python3
  python3 --version
  which pip3
  pip3 --version
  which pyls
  which pylint
  which clang
  which clangd
  which node
}

f_main() {
  str=""

  for i in $*; do
    case $i in
    -h|--help)
      f_help
      exit
      ;;
    -p|--path)
      f_print_path
      exit
      ;;
    -d|--dos)
      FORMAT=f_format_dos_path
      ;;
    -u|--unix)
      FORMAT=f_format_unix_path
      ;;
    *)
      if [ "x$str" == "x" ]; then
        str="$i"
      else
        str="$str $i"
      fi
      ;;
    esac
  done

  if [ "x$str" == "x" ]; then
    $FORMAT
  else
    echo "$str" | $FORMAT
  fi
}

f_main $*

