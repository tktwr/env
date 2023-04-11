#!/bin/bash

f_init() {
  BLOCK_SIZE=M
  MIN_CN=1000

  which zip > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    PACK_CMD=zip
  else
    PACK_CMD=win-zip.sh
  fi

  which fdfind > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    FIND_CMD=fdfind
  else
    FIND_CMD=find
  fi

  printf "PACK_CMD   : %s\n" $PACK_CMD
  printf "FIND_CMD   : %s\n" $FIND_CMD
  printf "BLOCK_SIZE : %s\n" $BLOCK_SIZE
  printf "MIN_CN     : %d\n" $MIN_CN
}

f_du() {
  dir="$1"
  du -B$BLOCK_SIZE -s "$dir" | awk '{print $1}'
}

f_count() {
  dir="$1"
  case $FIND_CMD in
    fdfind)
      fdfind -IH . "$dir" | wc -l
      ;;
    find)
      find "$dir" | wc -l
      ;;
  esac
}

f_pack() {
  dir="$1"
  case $PACK_CMD in
    zip)
      time zip --quiet -r "$dir.zip" "$dir"
      ;;
    7z.sh)
      time 7z.sh a "$dir.zip" "$dir"
      ;;
    win-zip.sh)
      time win-zip.sh "$dir"
      ;;
    tgz)
      time tar czf "$dir.tar.gz" "$dir"
      ;;
  esac
}

f_rm_dir() {
  dir="$1"
  if [ -f "$dir.zip" ]; then
    rm -rf "$dir"
  fi
}

f_pack_dirs() {
  for i in "$@"; do
    if [ ! -d "$i" ]; then
      continue
    fi

    size=$(f_du "$i")
    cn=$(f_count "$i")
    printf "%10s %10d %20s " $size $cn "$i"

    if [ $cn -gt $MIN_CN ]; then
      echo "pack"
      f_pack "$i"
      #f_rm_dir "$i"
    else
      echo
    fi
  done
}

f_init
if [ $# -eq 0 ]; then
  f_pack_dirs *
else
  f_pack_dirs "$@"
fi
