#!/bin/bash

_f_unexpand_env() {
  #sed "s+$MY_PYTHON_VENV_DIR+\$MY_PYTHON_VENV_DIR+"
  cat
}

_f_print_ver() {
  cmd=$1
  abspath=$(which $cmd 2> /dev/null)
  ver=$($cmd --version 2> /dev/null | head -1)

  abspath=$(echo $abspath | _f_unexpand_env)
  if [ -n "$abspath" ]; then
    printf "%-40s %s\n" "$abspath" "$ver"
  fi
}

#------------------------------------------------------
f_info_ver_os() {
  _f_title "OS"

  lsb_release -dc
}

f_info_ver_exe() {
  _f_title "VERSION"

  BIN_NAMES="\
  python \
  pip \
  python3 \
  pip3 \
  pyls \
  pylint \
  flake8 \
  clang \
  clangd \
  nvm \
  node \
  npm \
  cmake \
  make \
  git \
  vim \
  fzf \
  batcat \
  fdfind \
  rg \
  "
  for i in $BIN_NAMES; do
    _f_print_ver $i
  done
}

