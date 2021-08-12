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
# vimapi
#------------------------------------------------------
vimapi-lcd() {
  local dir=${1:-$PWD}
  vimapi.sh lcd --filepath $dir
}

vimapi-tcd() {
  local dir=${1:-$PWD}
  vimapi.sh tcd --filepath $dir
}

vimapi-cd() {
  local dir=${1:-$HOME}
  cd $dir
  vimapi-lcd
}

vimapi-tab-diff() {
  vimapi.sh MyTabDiff "$1" "$2"
  read -p "Enter to proceed. "
}

vimapi-tab-dirdiff() {
  vimapi.sh MyTabDirDiff "$1" "$2"
  read -p "Enter to proceed. "
}

vimapi-nerdtree() {
  local dir=${1:-$PWD}
  vimapi.sh MyNERDTreeFind --filepath $dir/
}

vimapi-fern() {
  local dir=${1:-$PWD}
  vimapi.sh MyFernDrawer --filepath $dir/
}

vimapi-resize() {
  local rows=${1:-10}
  vimapi.sh MyWinResize $rows
}

vimapi-edit() {
  local file="$1"
  local winnr="$2"
  vimapi.sh BmkEditFile --filepath "$file" "$winnr"
  #vimapi.sh --in-above-win edit --filepath "$file"
}

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
if [ "$VIM_TERMINAL" ]; then
  alias cd='vimapi-cd'
  alias vimdiff='vimapi-tab-diff'
  alias vimdirdiff='vimapi-tab-dirdiff'

  alias D='vimapi-fern'

  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias GS='vimapi.sh --in-new-tab MyGstatusToggle'
  alias GV='vimapi.sh --in-new-tab MyGV'
  alias E='vimapi.sh --in-new-tab MyIDE'
  alias V='vimapi.sh MyFernDrawerToggle'
  alias T='vimapi.sh MyTerm'
  alias TV='vimapi.sh MyTermV'

  alias ,e='vimapi-edit'
  alias ,sp='vimapi.sh --in-above-win "below split" --filepath'
  alias ,tabe='vimapi.sh tabedit --filepath'

  alias ,termcd='vimapi.sh MyIDESendCdT2T --filepath $PWD'
  alias ,resize='vimapi-resize'
else
  alias GS='vim -c "MyGstatusToggle"'
  alias GV='vim -c "MyGV"'
  alias E='vim -c "MyIDE"'
  alias V='vim -c "MyFernDrawerToggle"'
  alias T='vim -c "MyTerm"'

  alias z='vim -c "DiaFull"'
  alias zh='vim -c "DiaFullH"'
fi

#------------------------------------------------------
# git
#------------------------------------------------------
alias G='gg-d -6'
alias GA='gg-d -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

