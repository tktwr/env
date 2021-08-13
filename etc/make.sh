#!/bin/bash

bin_name=`basename $0`

source ./lib/common_etc.sh

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
  echo "  --init     ... init"
  echo "  --all      ... all"
  echo "  --min      ... min"
  echo "  --bmk-push ... push bmk"
  echo "  --bmk-pull ... pull bmk"
  echo "  --clean    ... clean"
}

f_init() {
  ./dot.sh --init
  f_make --min
}

f_bmk_push() {
  cp bmk/bmk.txt $MY_DOTMY_COMMON/bmk.txt
  cp bmk/cmd.txt $MY_DOTMY_COMMON/cmd.txt
}

f_bmk_pull() {
  grep -v '^\+ ' $MY_DOTMY_COMMON/bmk.txt > bmk/bmk.txt
	grep -v '^\+ ' $MY_DOTMY_COMMON/cmd.txt > bmk/cmd.txt
}

f_nerdtree_bmk() {
  $MY_PYTHON_EXE ./nerdtree_bmk.py $MY_ETC/.NERDTreeBookmarks $MY_DOTMY_COMMON/NERDTreeBookmarks > ~/.NERDTreeBookmarks
}

f_make() {
  ./dot.sh --common-files --cp

  f_nerdtree_bmk

  cd bash
  ./make.sh "$@"
  cd ..

  cd vim
  ./make.sh "$@"
  cd ..
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        ;;
      --init)
        f_init
        ;;
      --all)
        f_make --all
        ;;
      --min)
        f_make --min
        ;;
      --bmk-push)
        #f_bmk_push
        ;;
      --bmk-pull)
        #f_bmk_pull
        ;;
      --clean)
        f_make --clean
        ;;
    esac
  done
}

f_args "$@"
