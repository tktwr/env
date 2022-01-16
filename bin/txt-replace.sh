#!/bin/sh

bin_name=`basename $0`

g_exec="true"
g_diff="false"
g_src=""
g_dst=""
g_files=""

f_help() {
  echo "NAME"
  echo "  $bin_name - replace words in files"
  echo
  echo "SYNOPSIS"
	echo "  $bin_name [options] src_word dst_word file|dir..."
	echo "  $bin_name [options] file|dir... < replaced-word-file"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
  echo "  -n         ... no execution"
  echo "  -d         ... print diff"
  echo
  echo "REPLACED-WORD-FILE"
  echo "  this file specifies the list of the pair of src and dst words."
  echo "  use \\\< and \\\> in your file to exactly match the src word."
  echo
  echo "REPLACED-WORD-FILE EXAMPLE"
  echo "  \\\<src_word\\\> dst_word"
  echo
  echo "NOTE"
  echo "  '|' can not be included in src_word."
}

f_replace() {
  src=$1
  dst=$2
  txt_files=`txt-find.sh $g_files`
  matched_files=`grep -l "$src" $txt_files`
  for i in $matched_files; do
    echo "replacing... $i (\"$src\" -> \"$dst\")"

    if [ $g_diff = "true" -o $g_exec = "true" ]; then
      sed "s|$src|$dst|g" $i > ${i}__tmp__
    fi

    if [ $g_diff = "true" ]; then
      echo "-- [diff] ---------------------------------------------"
      echo "diff $i ${i}__tmp__"
      diff $i ${i}__tmp__
    fi

    if [ $g_exec = "true" ]; then
      mv ${i}__tmp__ $i
    elif [ $g_diff = "true" ]; then
      rm ${i}__tmp__
    fi
  done
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      -n)
        g_exec="false"
        ;;
      -d)
        g_diff="true"
        ;;
      *)
        if [ -z "$g_src" ]; then
          g_src="$1"
        elif [ -z "$g_dst" ]; then
          g_dst="$1"
        else
          if [ -z "$g_files" ]; then
            g_files="$1"
          else
            g_files="$g_files $1"
          fi
        fi
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "== [args] ============================================="
  echo "exec  : $g_exec"
  echo "diff  : $g_diff"
  echo "src   : $g_src"
  echo "dst   : $g_dst"
  echo "files : $g_files"
  echo "======================================================="
}

f_check_args() {
  if [ -z "$g_src" -o -z "$g_dst" -o -z "$g_files" ]; then
    f_help
    exit
  fi
}

f_run() {
  if [ -n "$g_src" -a -n "$g_dst" ]; then
    f_replace $g_src $g_dst
  else
    while [ true ]; do
      read src dst
      if [ -n "$src" -a -n "$dst" ]; then
        f_replace $src $dst
      fi
    done
  fi
}

f_parse_args "$@"
f_print_args
f_check_args
f_run

