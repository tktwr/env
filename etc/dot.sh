#!/bin/bash

bin_name=`basename $0`
cmd=cmp
dir=$HOME

DOT_DIRS_COMMON="\
mintty \
w3m \
"
DOT_FILES_COMMON="\
.clang-format \
.gitignore_global \
.minttyrc \
.NERDTreeBookmarks \
.tmux.conf \
.my/pushdrc \
"
DOT_FILES_DIFF="\
.gitconfig \
.my/buildrc \
.my/hostname \
.my/pythonrc \
"
DOT_FILES=""

f_get_date() {
  echo `env LC_TIME=C date '+%Y%m%d'`
}

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] [dir]"
  echo
  echo "OPTIONS"
  echo "  -h, --help      print help"
  echo "  --backup        backup"
  echo "  --init          init"
  echo "  --common-files  common files"
  echo "  --diff-files    diff files"
  echo "  --cp            copy files"
  echo "  --cmp           compare files"
  echo "  --diff          diff files"
  echo "  --vimdiff       vimdiff files"
  echo "  --vimdirdiff    vimdirdiff dir"
}

f_backup() {
  local ORIG_DIR=$HOME/.dot.$(f_get_date)

  if [ ! -d $ORIG_DIR ]; then
    mkdir $ORIG_DIR
  fi

  cd

  # backup original files
  for i in $DOT_FILES_COMMON $DOT_FILES_DIFF; do
    cp --parents $i $ORIG_DIR
  done
}

f_init() {
  # copy default dot files
  for i in $DOT_FILES_COMMON $DOT_FILES_DIFF; do
    cp --parents $i $HOME
  done
}

f_diff() {
  if [ ! -f "$1" ]; then
    echo "[no file] $1"
  fi
  if [ ! -f "$2" ]; then
    echo "[no file] $2"
  fi
  if [ ! \( -f "$1" -a -f "$2" \) ]; then
    return
  fi
  cmp -s "$1" "$2"
  if [ $? -eq 0 ]; then
    echo "[==] $1 $2"
  elif [ $? -eq 1 ]; then
    echo "[!=] $1 $2"
    if [ "$cmd" = "diff" -o "$cmd" = "vimdiff" ]; then
      $cmd "$1" "$2"
    fi
  fi
}

f_diff_files() {
  for i in $DOT_FILES; do
    f_diff $i $1/$i
  done
}

f_cp_files() {
  if [ -n "$DOT_FILES" ]; then
    echo "cp --parents $DOT_FILES $1"
    cp --parents $DOT_FILES $1
  fi
}

f_diff_dir() {
  vimdirdiff . $1
}

f_main() {
  for i in $*; do
    case $i in
      -h|--help)
        f_help
        exit
        ;;
      --backup)
        f_backup
        exit
        ;;
      --init)
        f_init
        exit
        ;;
      --all-files)
        DOT_FILES="$DOT_FILES_COMMON $DOT_FILES_DIFF"
        ;;
      --common-files)
        DOT_FILES="$DOT_FILES $DOT_FILES_COMMON"
        ;;
      --diff-files)
        DOT_FILES="$DOT_FILES $DOT_FILES_DIFF"
        ;;
      --cp)
        cmd=cp
        ;;
      --cmp)
        cmd=cmp
        ;;
      --diff)
        cmd=diff
        ;;
      --vimdiff)
        cmd=vimdiff
        ;;
      --vimdirdiff)
        cmd=vimdirdiff
        ;;
      *)
        dir="$i"
        ;;
    esac
  done

  case $cmd in
    vimdirdiff)
      f_diff_dir $dir
      ;;
    cmp|diff|vimdiff)
      f_diff_files $dir
      ;;
    cp)
      f_cp_files $dir
      ;;
  esac
}

f_main $*

