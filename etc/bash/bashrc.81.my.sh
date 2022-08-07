#!/bin/bash

#======================================================
# my
#======================================================

#------------------------------------------------------
# mv
#------------------------------------------------------
mv.desktop()    { mv "$@" $MY_DESKTOP; }
mv.downloads()  { mv "$@" $MY_DOWNLOADS; }

mv.work()       { mv "$@" $MY_WORK; }
mv.doc()        { mv "$@" $MY_DOC; }
mv.office()     { mv "$@" $MY_OFFICE; }
mv.proj()       { mv "$@" $MY_PROJ; }

mv.downloads2() { mv "$@" $MY_DOWNLOADS2; }
mv.papers()     { mv "$@" $MY_PAPERS; }
mv.opt()        { mv "$@" $MY_OPT; }
mv.data()       { mv "$@" $MY_DATA; }

#------------------------------------------------------
# mypushd.sh
#------------------------------------------------------
alias set.G='mypushd.sh --set `pwd`'
alias get.G='mypushd.sh --get'
alias cd.G='cd `mypushd.sh --get`'
mv.G()          { mv "$@" `mypushd.sh --get`; }
cp.G()          { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
alias pp='print-path.sh -p'
alias make='mymake.sh'

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
if [ "$VIM_TERMINAL" ]; then
  alias TV='vimapi.sh VisTermV'
  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias ,tabe='vimapi.sh tabedit'
  alias ,termcd='vimapi-termcd'
else
  alias z='vim -c "DiaFull"'
  alias zh='vim -c "DiaFullH"'
fi

