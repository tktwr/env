#!/bin/bash

#======================================================
# variables
#======================================================
DOT_FILES_COMMON="\
.config/lazygit \
.config/nvim \
.mintty \
.minttyrc \
.clang-format \
.gitignore_global \
.rsync_exclude \
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
f_sub() {
  cd $1
  ./make.sh $2
  cd ..
}

#------------------------------------------------------
f_cp_common() {
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

f_min_plug() {
  f_sub bash min
  f_sub vim min_plug
}

f_min() {
  f_sub bash min
  f_sub vim min
}

f_zero() {
  f_sub bash zero
  f_sub vim zero
}

#------------------------------------------------------
f_init() {
  f_cp_all
  f_min
}

f_backup() {
  cd
  snap-dir.sh $MY_BACKUP/dotfiles $DOT_FILES_ALL $DOT_FILES_INIT
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
f_apt_update() {
  sudo -E apt update
}

f_apt_list_upgradable() {
  apt list --upgradable
}

f_apt_upgrade() {
  sudo -E apt upgrade
}

f_apt_autoremove() {
  sudo -E apt autoremove
}

#------------------------------------------------------
f_help() {
  echo "all                 ... full settings (default)"
  echo "min_plug            ... minimum settings with plugins"
  echo "min                 ... minimum settings"
  echo "zero                ... minimum settings without any dependencies"
  echo "-----------         ... -----------------------------"
  echo "init                ... init"
  echo "backup              ... backup"
  echo "-----------         ... -----------------------------"
  echo "cmp                 ... cmp"
  echo "diff                ... diff"
  echo "vimdiff             ... vimdiff"
  echo "vimdirdiff          ... vimdirdiff"
  echo "-----------         ... -----------------------------"
  echo "apt_update          ... apt update"
  echo "apt_list_upgradable ... apt list --upgradable"
  echo "apt_upgrade         ... apt upgrade"
  echo "apt_autoremove      ... apt autoremove"
  echo "-----------         ... -----------------------------"
  echo "help                ... print this help"
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
