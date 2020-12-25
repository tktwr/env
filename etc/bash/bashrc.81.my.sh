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
alias cd.G='cd `mypushd.sh --get`'
mv.G()           { mv "$@" `mypushd.sh --get`; }
cp.G()           { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
# mypython.sh
#------------------------------------------------------
mypython-set-python-anaconda() {
  mypython.sh --set python-anaconda $1
  source $HOME/.bashrc
}
mypython-set-python-miniconda() {
  mypython.sh --set python-miniconda $1
  source $HOME/.bashrc
}
mypython-set-python-win() {
  mypython.sh --set python-win $1
  source $HOME/.bashrc
}
mypython-set-python() {
  mypython.sh --set python $1
  source $HOME/.bashrc
}

#------------------------------------------------------
# mycmake.sh
#------------------------------------------------------
alias mycmake-set-ninja-release='mycmake.sh --set ninja Release'
alias mycmake-set-ninja-debug='mycmake.sh --set ninja Debug'
alias mycmake-set-make-release='mycmake.sh --set make Release'
alias mycmake-set-make-debug='mycmake.sh --set make Debug'
alias mycmake-set-vs2017-release='mycmake.sh --set vs2017 Release'
alias mycmake-set-vs2017-debug='mycmake.sh --set vs2017 Debug'
alias mycmake-set-vs2017-reldeb='mycmake.sh --set vs2017 RelWithDebInfo'
alias mycmake-set-vs2019-release='mycmake.sh --set vs2019 Release'
alias mycmake-set-vs2019-debug='mycmake.sh --set vs2019 Debug'
alias mycmake-set-vs2019-reldeb='mycmake.sh --set vs2019 RelWithDebInfo'

#------------------------------------------------------
# dia
#------------------------------------------------------
alias dia='vim -c "Dia"'
alias todo='vim -c "Todo"'
alias z='vim -c "VDia"'
alias zv='vim -c "VDia"'
alias zh='vim -c "HDia"'

#------------------------------------------------------
# misc
#------------------------------------------------------
alias pp='print-path.sh -p'
