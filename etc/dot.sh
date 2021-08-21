#!/bin/bash

bin_name=`basename $0`

CMD=cmp
DST_DIR=$HOME

DOT_DIRS_COMMON="\
.mintty \
"
DOT_FILES_COMMON="\
.clang-format \
.gitignore_global \
.minttyrc \
.my/pushdrc \
"
DOT_FILES_DIFF="\
.gitconfig \
.my/buildrc \
.my/hostname \
.my/pythonrc \
"
DOT_FILES_ALL="$DOT_FILES_COMMON $DOT_FILES_DIFF"
DOT_FILES=""

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] [DST_DIR=$HOME]"
  echo
  echo "OPTIONS"
  echo "  -h, --help     ... print help"
  echo "  --backup       ... backup"
  echo "  --init         ... init"
  echo "  --all-files    ... all files"
  echo "  --common-files ... common files"
  echo "  --diff-files   ... diff files"
  echo "  --cp           ... copy files"
  echo "  --cmp          ... compare files"
  echo "  --diff         ... diff files"
  echo "  --vimdiff      ... vimdiff files"
  echo "  --vimdirdiff   ... vimdirdiff DST_DIR"
}

f_get_date() {
  echo `env LC_TIME=C date '+%Y%m%d'`
}

f_backup() {
  local BACKUP_DIR=$HOME/.dot.$(f_get_date)

  if [ ! -d $BACKUP_DIR ]; then
    mkdir $BACKUP_DIR
  fi

  cd

  # backup original files
  cp --parents $DOT_FILES_ALL $BACKUP_DIR
}

f_init() {
  # copy default dot files
  cp -n --parents $DOT_FILES_ALL $HOME
  cp -n -a $DOT_DIRS_COMMON $HOME
}

#------------------------------------------------------
# f_cp_files DST_DIR
#------------------------------------------------------
f_cp_files() {
  if [ -n "$DOT_FILES" ]; then
    echo "cp --parents $DOT_FILES $1"
    cp --parents $DOT_FILES $1
  fi
}

#------------------------------------------------------
# f_diff_dir DST_DIR
#------------------------------------------------------
f_diff_dir() {
  vimdirdiff . $1
}

#------------------------------------------------------
# f_args args
#------------------------------------------------------
f_args() {
  for i in "$@"; do
    case "$i" in
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
        DOT_FILES="$DOT_FILES_ALL"
        ;;
      --common-files)
        DOT_FILES="$DOT_FILES $DOT_FILES_COMMON"
        ;;
      --diff-files)
        DOT_FILES="$DOT_FILES $DOT_FILES_DIFF"
        ;;
      --cp)
        CMD=cp
        ;;
      --cmp)
        CMD=cmp
        ;;
      --diff)
        CMD=diff
        ;;
      --vimdiff)
        CMD=vimdiff
        ;;
      --vimdirdiff)
        CMD=vimdirdiff
        ;;
      *)
        DST_DIR="$i"
        ;;
    esac
  done
}

f_args "$@"

case $CMD in
  cmp|diff|vimdiff)
    diff-files.sh -c $CMD -d $DST_DIR $DOT_FILES
    ;;
  cp)
    f_cp_files $DST_DIR
    ;;
  vimdirdiff)
    f_diff_dir $DST_DIR
    ;;
esac

