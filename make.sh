#!/bin/bash

#======================================================
# dirs
#======================================================
GIT_DIRS="\
$MY_ENV \
$MY_MEMO \
$MY_SAMPLES \
$MY_LIBTT \
$MY_REMOTE_CONFIG/templates \
$MY_VIM_PLUGGED_DIR/vim-winbuf-menu \
$MY_VIM_PLUGGED_DIR/vim-bmk-menu \
$MY_VIM_PLUGGED_DIR/vim-ide-style \
$MY_VIM_PLUGGED_DIR/vim-memo \
"
BUILD_DIRS="\
$MY_LIBTT \
$MY_SAMPLES/cpp \
$MY_SAMPLES/cpp_lib \
"
VIM_FILES="\
etc/vim/*.vim \
etc/vim/vim-plug/*.vim \
etc/vim/plugin \
$MY_VIM_PLUGGED_DIR/vim-winbuf-menu \
$MY_VIM_PLUGGED_DIR/vim-bmk-menu \
$MY_VIM_PLUGGED_DIR/vim-ide-style \
$MY_VIM_PLUGGED_DIR/vim-memo \
"

#======================================================
# functions
#======================================================
f_10_git_status() { for-dir.sh "git status -s"   $GIT_DIRS; }
f_11_git_graph()  { for-dir.sh "git-graph.sh -1" $GIT_DIRS; }
f_12_git_fetch()  { for-dir.sh "git fetch"       $GIT_DIRS; }
f_13_git_pull()   { for-dir.sh "git pull"        $GIT_DIRS; }
f_cpp_build()  { for-dir.sh "make all"        $BUILD_DIRS; }
f_cpp_clean()  { for-dir.sh "make all.clean"  $BUILD_DIRS; }
f_snap()       { git-tar.sh $MY_SNAP; }

f_tags() {
  ctags -o .tags.bin_sh -R bin/*.sh bin/*/*.sh
  ctags -o .tags.bin_py -R bin/py/*.py
  ctags -o .tags.bash   -R etc/bash/*.sh
  ctags -o .tags.vim    -R $VIM_FILES
}

#======================================================
# main
#======================================================
f_fzf_default() { f_10_git_status; }
f_fzf_main "$@"
