#!/bin/bash

source common.sh

#======================================================
# dirs
#======================================================
GIT_DIRS="\
$MY_ENV \
$MY_MEMO \
$MY_SAMPLES \
$MY_LIBTT \
$MY_REMOTE_CONFIG/templates \
"

BUILD_DIRS="\
$MY_LIBTT \
$MY_SAMPLES/cpp \
$MY_SAMPLES/cpp_lib \
$MY_SAMPLES/mycmake.test \
"

#======================================================
# functions
#======================================================
f_snap() {
  fname=$(git-tar.sh)
  if [ -d "$MY_SNAP" ]; then
    echo "$fname $MY_SNAP"
    mv $fname $MY_SNAP
  fi
}

f_tags() {
  f_eval 'myctags.sh bin/*.sh > .tags.bin_sh'
  f_eval 'myctags.sh bin/py/*.py > .tags.bin_py'
  f_eval 'myctags.sh etc/bash/*.sh > .tags.bash'

  vim_files='\
    etc/vim/*.vim \
    etc/vim/vim-plug/*.vim \
    etc/vim/plugin \
    etc/vim/plugged/vim-winbuf-menu \
    etc/vim/plugged/vim-bmk-menu \
    etc/vim/plugged/vim-ide-style \
    etc/vim/plugged/vim-memo \
    '
  f_eval "myctags.sh $vim_files > .tags.vim"
}

#------------------------------------------------------
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
f_help() {
  echo "snap        ... make a snapshot"
  echo "tags        ... make tags"
  echo "----------- ... -----------------------------"
  echo "status      ... status in GIT_DIRS"
  echo "graph       ... graph  in GIT_DIRS"
  echo "fetch       ... fetch  in GIT_DIRS"
  echo "pull        ... pull   in GIT_DIRS"
  echo "----------- ... -----------------------------"
  echo "build       ... build  in BUILD_DIRS"
  echo "clean       ... clean  in BUILD_DIRS"
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
eval "f_$func_name"

