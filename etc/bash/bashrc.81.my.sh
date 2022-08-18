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
mv.G()          { mv "$@" `mypushd.sh --get`; }
cp.G()          { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
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
  alias TV='vimapi.sh VisTermV'
  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias ,tabe='vimapi.sh tabedit'
  alias ,termcd='vimapi-termcd'
fi

