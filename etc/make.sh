#!/bin/bash

#======================================================
# variables
#======================================================
DOT_FILES_CONFIG="\
.config/bat \
.config/lazygit \
.config/nvim \
"
DOT_FILES_COMMON="\
$DOT_FILES_CONFIG \
.mintty \
.minttyrc \
.clang-format \
.gitconfig \
.gitignore_global \
.rsync_exclude \
.my/pushdrc.sh \
"
DOT_FILES_DIFF="\
.my/buildrc.sh \
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
_f_cp_all() {
  cp -a --parents    $DOT_FILES_COMMON $HOME
  cp -a --parents -n $DOT_FILES_DIFF   $HOME

  if [ -n "$APPDATA" ]; then
    cp -a $DOT_FILES_CONFIG $APPDATA
  fi
}

_f_sub() {
  cd $1
  ./make.sh $2
  cd ..
}

#------------------------------------------------------
f_10_install_all() {
  _f_cp_all
  _f_sub bash
  _f_sub vim
}

f_11_install_zero() {
  _f_cp_all
  _f_sub bash f_install_zero
  _f_sub vim  f_install_zero
}

f_12_install_min() {
  _f_cp_all
  _f_sub bash f_install_min
  _f_sub vim  f_install_min
}

f_13_install_min_plug() {
  _f_cp_all
  _f_sub bash f_install_min
  _f_sub vim  f_install_min_plug
}

#------------------------------------------------------
f_cmp()            { diff-files.sh -c cmp        -d $HOME $DOT_FILES_ALL; }
f_cmp_diff()       { diff-files.sh -c diff       -d $HOME $DOT_FILES_ALL; }
f_cmp_vimdiff()    { diff-files.sh -c vimdiff.sh -d $HOME $DOT_FILES_ALL; }
f_cmp_vimdirdiff() { vimdirdiff.sh . $HOME; }
f_backup()         { cd; snap-dir.sh $MY_BACKUP/dotfiles $DOT_FILES_ALL $DOT_FILES_INIT; }

#======================================================
# main
#======================================================
f_fzf_default() { f_10_install_all; }
f_fzf_main "$@"
