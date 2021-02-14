#!/bin/bash

f_set_locale() {
  unset LANG LANGUAGE
  unset LC_ALL LC_COLLATE LC_MESSAGES LC_NUMERIC LC_CTYPE LC_MONETARY LC_TIME
  case $1 in
  C)
    export LANG=C
    ;;
  en)
    export LANG=en_US
    export LANGUAGE=en_US:en
    ;;
  ja.eucjp)
    export LANG=ja_JP.eucJP
    export LANGUAGE=ja_JP.eucJP:ja
    ;;
  ja.utf8)
    export LANG=ja_JP.UTF-8
    export LANGUAGE=ja_JP.UTF-8:ja
    ;;
  none)
    ;;
  esac
}

