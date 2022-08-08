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
"

TAGS_DIRS="$MY_LIBTT"

MEMO_DIRS="$MY_MEMO $MY_SAMPLES"

BUILD_DIRS="\
$MY_LIBTT \
$MY_SAMPLES/cpp \
$MY_SAMPLES/cpp_lib \
$MY_SAMPLES/mycmake.test \
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
  echo "----------- ... -----------------------------"
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

