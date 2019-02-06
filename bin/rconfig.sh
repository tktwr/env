#!/bin/sh

bin_name=`basename $0`
top_dir=`pwd`

GIT_DIRS="\
env \
memo \
samples \
templates \
libtt \
tools \
"
TAGS_DIRS="\
libtt/tt \
"
MEMO_DIRS="\
memo \
samples \
"
BUILD_DIRS="\
samples/cpp \
samples/app_cmd \
samples/app_imgui \
tools/imgedit \
tools/imgview \
"

declare -A COMMAND
COMMAND['graph']="git graph -3"
COMMAND['status']="git status -s"
COMMAND['fetch']="git fetch"
COMMAND['push']="git push origin master"
COMMAND['build']="make"
COMMAND['clean']="make clean.all"
COMMAND['tags']="ctags -R"
COMMAND['tags.memo']="make tags.memo"
COMMAND['dot']="dot.sh --cmp"

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help       print help"
  echo "  -g, --graph      ${COMMAND['graph']}"
  echo "  -s, --status     ${COMMAND['status']}"
  echo "  -f, --fetch      ${COMMAND['fetch']}"
  echo "  -p, --push       ${COMMAND['push']}"
  echo "  -b, --build      ${COMMAND['build']}"
  echo "  -c, --clean      ${COMMAND['clean']}"
  echo "  -t, --tags       ${COMMAND['tags']}"
  echo "  -m, --tags.memo  ${COMMAND['tags.memo']}"
  echo "  -d, --dot        ${COMMAND['dot']}"
}

f_exec_in_dirs() {
  cmd=${COMMAND[$1]}
  shift
  dirs=$*
  for i in $dirs; do
    echo "=== [$i] ==="
    cd "$i"
    $cmd
    cd $top_dir
  done
}

f_args() {
  for i in $*; do
    case $i in
      -h|--help)
        f_help
        ;;
      -g|--graph)
        f_exec_in_dirs graph $GIT_DIRS
        ;;
      -s|--status)
        f_exec_in_dirs status $GIT_DIRS
        ;;
      -f|--fetch)
        f_exec_in_dirs fetch $GIT_DIRS
        ;;
      -p|--push)
        f_exec_in_dirs push $GIT_DIRS
        ;;
      -b|--build)
        f_exec_in_dirs build $BUILD_DIRS
        ;;
      -c|--clean)
        f_exec_in_dirs clean $BUILD_DIRS
        ;;
      -t|--tags)
        ${COMMAND['tags']} $TAGS_DIRS
        ;;
      -m|--tags.memo)
        f_exec_in_dirs tags.memo $MEMO_DIRS
        ;;
      -d|--dot)
        cd env/dot
        ${COMMAND['dot']}
        ;;
    esac
  done
}

f_args $*

