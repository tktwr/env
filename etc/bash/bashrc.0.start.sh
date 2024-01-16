#!/bin/bash

export MY_DEBUG=0
export TIME_PRINT=0

#------------------------------------------------------
# time
#------------------------------------------------------
declare -A TIME_START
declare -A TIME_END
declare -A TIME_DURATION

f_time_start() {
  if [ $TIME_PRINT -eq 0 ]; then
    return
  fi
  TIME_START[$1]=$(/usr/bin/date +"%s.%3N")
}

f_time_end() {
  if [ $TIME_PRINT -eq 0 ]; then
    return
  fi
  TIME_END[$1]=$(/usr/bin/date +"%s.%3N")
  TIME_DURATION[$1]=`echo "scale=1; ${TIME_END[$1]} - ${TIME_START[$1]}" | bc`
  printf "%-80s ${TIME_DURATION[$1]} sec\n" $1
}

#------------------------------------------------------
# source_file
#------------------------------------------------------
echo_err() {
  echo "$@" 1>&2
}

source_file() {
  local files="$@"

  local I
  for I in $files; do
    if [ -f $I ]; then
      f_time_start $I
      source $I
      f_time_end $I
    else
      if [ $MY_DEBUG -eq 1 ]; then
        echo_err "no file: $I"
      fi
    fi
  done
}

#------------------------------------------------------
# source_bashrc
#------------------------------------------------------
source_bashrc() {
  source $HOME/.bashrc
}

