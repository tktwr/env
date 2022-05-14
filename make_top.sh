#!/bin/bash

#======================================================
# dirs
#======================================================
GIT_DIRS="\
env \
memo \
samples \
templates \
libtt \
"

TAGS_DIRS="libtt"

MEMO_DIRS="memo samples"

BUILD_DIRS="\
libtt \
samples/cpp \
samples/cpp_lib \
samples/mycmake.test \
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

f_tags() {
  for-dir.sh "./make.sh tags_memo" ${MEMO_DIRS}
  for-dir.sh "make tags" ${TAGS_DIRS}
}

f_build() {
  for-dir.sh "make all" ${BUILD_DIRS}
}

f_clean() {
  for-dir.sh "make all.clean" ${BUILD_DIRS}
}

f_print_build() {
  myfind.sh -b
}

#------------------------------------------------------
f_help() {
  echo "status      ... status in GIT_DIRS (default)"
  echo "graph       ... graph  in GIT_DIRS"
  echo "fetch       ... fetch  in GIT_DIRS"
  echo "pull        ... pull   in GIT_DIRS"
  echo "tags        ... tags   in TAGS_DIRS and MEMO_DIRS"
  echo "build       ... build  in BUILD_DIRS"
  echo "clean       ... clean  in BUILD_DIRS"
  echo "print_build ... print build directories"
  echo "help        ... print this help"
}

f_default() {
  f_status
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

