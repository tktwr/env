#!/bin/bash

#======================================================
# variables
#======================================================
DOT_FILES_COMMON="\
.clang-format \
.gitignore_global \
.my/pushdrc \
"
DOT_FILES_DIFF="\
.gitconfig \
.my/buildrc \
.my/pythonrc \
"
DOT_FILES_INIT="\
.bash_logout \
.bashrc \
.profile \
"
DOT_FILES_ALL="$DOT_FILES_COMMON $DOT_FILES_DIFF"

#======================================================
# functions
#======================================================
f_get_date() {
  echo `env LC_TIME=C date '+%Y%m%d'`
}

f_get_time() {
  echo `env LC_TIME=C date '+%H%M%S'`
}

f_sub() {
  cd $1
  ./make.sh $2
  cd ..
}

#------------------------------------------------------
f_cp_common() {
  local WSLTTY_DIR="$HOME/WinHome/AppData/Roaming/wsltty"
  if [ -d $WSLTTY_DIR ]; then
    cp -a .wsltty/config $WSLTTY_DIR
  fi
  cp -a .mintty .minttyrc $HOME
  cp -a --parents $DOT_FILES_COMMON $HOME
}

f_cp_diff() {
  cp -a --parents -n $DOT_FILES_DIFF $HOME
}

f_cp_all() {
  f_cp_common
  f_cp_diff
}

#------------------------------------------------------
f_all() {
  f_cp_common
  f_sub bash
  f_sub vim
}

f_min() {
  f_sub bash min
  f_sub vim min
}

f_min_plug() {
  f_sub bash min
  f_sub vim min_plug
}

#------------------------------------------------------
f_init() {
  f_cp_all
  f_min
}

f_backup() {
  local BACKUP_DIR=$HOME/.backup/dotfiles_$(f_get_date)_$(f_get_time)
  if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
  fi

  cd

  # backup original files
  cp --parents $DOT_FILES_ALL  $BACKUP_DIR
  cp --parents $DOT_FILES_INIT $BACKUP_DIR
}

#------------------------------------------------------
f_cmp() {
  diff-files.sh -c cmp -d $HOME $DOT_FILES_ALL
}

f_diff() {
  diff-files.sh -c diff -d $HOME $DOT_FILES_ALL
}

f_vimdiff() {
  diff-files.sh -c vimdiff.sh -d $HOME $DOT_FILES_ALL
}

f_vimdirdiff() {
  vimdirdiff.sh . $HOME
}

#------------------------------------------------------
f_help() {
  echo "all         ... full settings (default)"
  echo "min         ... minimum settings"
  echo "min_plug    ... minimum settings with plugins"
  echo "----------- ... -----------------------------"
  echo "init        ... init"
  echo "backup      ... backup"
  echo "----------- ... -----------------------------"
  echo "cmp         ... cmp"
  echo "diff        ... diff"
  echo "vimdiff     ... vimdiff"
  echo "vimdirdiff  ... vimdirdiff"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help"
}

f_default() {
  f_all
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
