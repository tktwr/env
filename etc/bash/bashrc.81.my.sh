#!/bin/bash

#======================================================
# my
#======================================================
#------------------------------------------------------
# mypushd.sh
#------------------------------------------------------
alias set.G='mypushd.sh --set `pwd`'
alias get.G='mypushd.sh --get'
alias cd.G='cd `mypushd.sh --get`'
mv.G() { mv "$@" `mypushd.sh --get`; }
cp.G() { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
alias l='exa-short.sh'
alias ls='ls.sh'
alias make='mymake.sh'

mycmake-set() {
  mycmake.sh --set $1 $2
  source_bashrc
}

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
if [ "$VIM_TERMINAL" ]; then
  alias GL='vimapi_exec_above GitLog $PWD'
  alias t=',toggle'
  alias tv=',toggle_v'
  alias t0=',resize 5'
  alias t1=',resize 10'
  alias t2=',resize 20'
  alias t3=',resize 30'
  alias t4=',resize 40'
fi

