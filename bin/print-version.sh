#!/bin/bash

f_print_os() {
  echo "=== [OS] ==="
  lsb_release -dc
}

#------------------------------------------------------
f_unexpand_env() {
  sed "s+$MY_PYTHON_VENV_DIR+\$MY_PYTHON_VENV_DIR+"
}

f_print_ver() {
  cmd=$1
  abspath=$(which $cmd 2> /dev/null)
  ver=$($cmd --version 2> /dev/null | head -1)

  abspath=$(echo $abspath | f_unexpand_env)
  if [ -n "$abspath" ]; then
    printf "%-40s $ver\n" $abspath
  fi
}

f_print_ver_all() {
  echo "=== [version] ==="
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
  node \
  npm \
  cmake \
  make \
  git \
  vim \
  "
  for i in $BIN_NAMES; do
    f_print_ver $i
  done
}

#------------------------------------------------------
f_print_os
f_print_ver_all
