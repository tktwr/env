#!/bin/bash

source cmd_proj.sh

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
.code-workspace \
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

  if [ -n "$APP_L" -a -d "$APP_L" ]; then
    mkdir -p $APP_L/nvim
    cp -a vim/vimrc_zero.vim $APP_L/nvim/init.vim
  fi
  if [ -n "$APP_R" -a -d "$APP_R" ]; then
    cp -a $DOT_FILES_CONFIG $APP_R
  fi
}
_f_sub() {
  cd $1
  ./make.sh $2
  cd ..
}
#------------------------------------------------------
f_11_install_all() {
  ./zero_hostname.sh
  _f_cp_all
  _f_sub bash
  _f_sub vim
}
f_12_install_zero() {
  ./zero.sh
  _f_cp_all
}
#------------------------------------------------------
f_cmp()            { diff-files.sh -c cmp        -d $HOME $DOT_FILES_ALL; }
f_cmp_diff()       { diff-files.sh -c diff       -d $HOME $DOT_FILES_ALL; }
f_cmp_vimdiff()    { diff-files.sh -c vimdiff.sh -d $HOME $DOT_FILES_ALL; }
f_cmp_vimdirdiff() { vimdirdiff.sh . $HOME; }
f_dot_backup_cp()  { cd; snap-dir.sh $MY_BACKUP/dotfiles $DOT_FILES_ALL $DOT_FILES_INIT; }
f_dot_backup_tar() { cd; snap-tar.sh $MY_SNAP dotfiles $DOT_FILES_ALL $DOT_FILES_INIT; }
#======================================================
# main
#======================================================
f_fzf_default() { f_11_install_all; }
f_fzf_main "$@"
