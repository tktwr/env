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
# misc
#------------------------------------------------------
print-env() {
  echo "MY_PUSHD_DIR=$MY_PUSHD_DIR"
  echo "MY_PYTHON_TYPE=$MY_PYTHON_TYPE"
  echo "MY_PYTHON_VENV=$MY_PYTHON_VENV"
  echo "MY_BUILD_SYS=$MY_BUILD_SYS"
  echo "MY_BUILD_CONFIG=$MY_BUILD_CONFIG"
}

alias pe='print-env'
alias pp='print-path.sh -p'

#------------------------------------------------------
# vim
#------------------------------------------------------
alias GS='vim -c "MyGstatusToggle"'
alias GV='vim -c "MyGV"'
alias E='vim -c "MyIDE"'
alias T='vim -c "MyTerm"'
alias z='vim -c "DiaFull"'
alias zh='vim -c "DiaFullH"'

#------------------------------------------------------
# vimapi
#------------------------------------------------------
alias ,G=',LCD; vimapi.sh --in-above-win GitLog $PWD'
alias ,GS=',LCD; vimapi.sh --in-new-tab MyGstatusToggle'
alias ,GV=',LCD; vimapi.sh --in-new-tab MyGV'
alias ,E=',LCD; vimapi.sh --in-new-tab MyIDE'
alias ,T=',LCD; vimapi.sh MyTerm'
alias ,V=',LCD; vimapi.sh MyTermV'

alias ,e=',LCD; vimapi.sh BmkEditFile --filepath'
#alias ,e=',LCD; vimapi.sh --in-above-win edit --filepath'
alias ,sp=',LCD; vimapi.sh --in-above-win split --filepath'
alias ,tabe=',LCD; vimapi.sh tabedit --filepath'

alias ,diff=',LCD; vimapi.sh MyTabDiff'
alias ,dirdiff=',LCD; vimapi.sh MyTabDirDiff'

alias ,memo='vimapi.sh --in-above-win MyMemo'
alias ,help='vimapi.sh --in-above-win MyHelp'
alias ,man='vimapi.sh --in-above-win MyMan'
alias ,pydoc='vimapi.sh --in-above-win MyPydoc'

alias ,LCD='vimapi.sh lcd --filepath $PWD'
alias ,lcd='vimapi.sh lcd --filepath'
alias ,TCD='vimapi.sh tcd --filepath $PWD'
alias ,tcd='vimapi.sh tcd --filepath'
alias ,NERDTREE='vimapi.sh MyNERDTreeFind --filepath $PWD/'
alias ,nerdtree='vimapi.sh MyNERDTreeFind --filepath'
alias ,FERN='vimapi.sh MyFernDrawer --filepath $PWD/'
alias ,fern='vimapi.sh MyFernDrawer --filepath'

alias ,termcd='vimapi.sh MyIDESendCdT2T --filepath $PWD'

alias ,resize='vimapi.sh MyWinResize'
alias ,vresize='vimapi.sh MyIDEVResizeT2E'

alias ,vim='vimapi.sh'

alias ,set_tab='vimapi.sh MyTabSetLabel'

,cd() { cd "$@"; ,LCD; }
,nt() { cd "$@"; ,LCD; ,FERN; }
alias d=',cd'
alias D=',nt'

#------------------------------------------------------
# git
#------------------------------------------------------
alias G='gg-d -6'
alias GA='gg-d -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

