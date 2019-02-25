#!/bin/sh

bin_name=`basename $0`
cmd=cmp
dir=$HOME

DOT_FILES_COMMON="\
.bashrc \
.clang-format \
.gitignore_global \
.minttyrc \
.tmux.conf \
.vimrc \
_vimrc \
"
DOT_FILES_DIFF="\
.gitconfig \
.hostname \
"

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] [dir]"
  echo
  echo "OPTIONS"
  echo "  -h, --help   print help"
  echo "  --cp         copy files"
  echo "  --cmp        compare files"
  echo "  --diff       diff files"
  echo "  --vimdiff    vimdiff files"
  echo "  --vimdirdiff vimdirdiff dir"
}

f_diff() {
  if [ ! -f "$1" ]; then
    echo "[no file] $1"
  fi
  if [ ! -f "$2" ]; then
    echo "[no file] $2"
  fi
  if [ ! \( -f "$1" -a -f "$2" \) ]; then
    return
  fi
  cmp -s "$1" "$2"
  if [ $? -eq 0 ]; then
    echo "[==] $1 $2"
  elif [ $? -eq 1 ]; then
    echo "[!=] $1 $2"
    if [ "$cmd" = "diff" -o "$cmd" = "vimdiff" ]; then
      $cmd "$1" "$2"
    fi
  fi
}

f_diff_files() {
  # common for all shells
  for i in $DOT_FILES_COMMON; do
    f_diff $i $1/$i
  done

  echo

  # different for each shell
  for i in $DOT_FILES_DIFF; do
    f_diff $i $1/$i
  done
}

f_diff_dir() {
  vimdirdiff . $1
}

f_main() {
  for i in $*; do
    case $i in
      -h|--help)
        f_help
        exit
        ;;
      --cp)
        cmd=cp
        ;;
      --cmp)
        cmd=cmp
        ;;
      --diff)
        cmd=diff
        ;;
      --vimdiff)
        cmd=vimdiff
        ;;
      --vimdirdiff)
        cmd=vimdirdiff
        ;;
      *)
        dir="$i"
        ;;
    esac
  done

  case $cmd in
    vimdirdiff)
      f_diff_dir $dir
      ;;
    *)
      f_diff_files $dir
      ;;
  esac
}

f_main $*

