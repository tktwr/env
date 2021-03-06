#!/bin/bash

bin_name=`basename $0`

BUILD_DIR=build

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
  echo "  --all      ... all"
  echo "  --min      ... min"
  echo "  --clean    ... clean"
}

f_make() {
	mkdir -p $BUILD_DIR
	./make.00.bashrc.env.sh > $BUILD_DIR/.bashrc.env
	./make.01.bashrc.sh > $BUILD_DIR/.bashrc
}

f_install() {
	cp $BUILD_DIR/.bashrc.env $HOME
	cp $BUILD_DIR/.bashrc $HOME
}

f_install_min() {
	cp bashrc.min.sh $HOME/.bashrc
}

f_clean() {
	rm -rf $BUILD_DIR
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        ;;
      --all)
        f_make
        f_install
        ;;
      --min)
        f_install_min
        ;;
      --clean)
        f_clean
        ;;
    esac
  done
}

f_args "$@"
