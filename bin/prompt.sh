#!/bin/bash

f_prompt() {
  prompt="$1"
  default="$2"
  val="$3"
  if [ -z "$val" ]; then
    echo -n "$prompt ($default) > " 1>&2
    read val
    if [ -z "$val" ]; then
      val=$default
    fi
  fi
  echo $val
}

f_prompt "$@"
