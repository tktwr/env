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
$MY_VIM/plugged/vim-winbuf-menu \
$MY_VIM/plugged/vim-bmk-menu \
$MY_VIM/plugged/vim-ide-style \
$MY_VIM/plugged/vim-memo \
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
etc/vim/plugged/vim-winbuf-menu \
etc/vim/plugged/vim-bmk-menu \
etc/vim/plugged/vim-ide-style \
etc/vim/plugged/vim-memo \
"

#======================================================
# functions
#======================================================
f_status() {
  for-dir.sh "git status -s" ${GIT_DIRS}
}

f_graph() {
  for-dir.sh "git graph -1" ${GIT_DIRS}
}

f_fetch() {
  for-dir.sh "git fetch" ${GIT_DIRS}
}

f_pull() {
  for-dir.sh "git pull" ${GIT_DIRS}
}

#------------------------------------------------------
f_build() {
  for-dir.sh "make all" ${BUILD_DIRS}
}

f_clean() {
  for-dir.sh "make all.clean" ${BUILD_DIRS}
}

#------------------------------------------------------
f_snap() {
  git-tar.sh $MY_SNAP
}

f_tags() {
  myctags.sh bin/*.sh > .tags.bin_sh
  myctags.sh bin/py/*.py > .tags.bin_py
  myctags.sh etc/bash/*.sh > .tags.bash
  myctags.sh $VIM_FILES > .tags.vim
}

#------------------------------------------------------
f_help() {
  echo "status      ... status in GIT_DIRS"
  echo "graph       ... graph  in GIT_DIRS"
  echo "fetch       ... fetch  in GIT_DIRS"
  echo "pull        ... pull   in GIT_DIRS"
  echo "----------- ... -----------------------------"
  echo "build       ... build  in BUILD_DIRS"
  echo "clean       ... clean  in BUILD_DIRS"
  echo "----------- ... -----------------------------"
  echo "snap        ... make a snapshot"
  echo "tags        ... make tags"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help (default)"
}

f_default() {
  f_help
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
