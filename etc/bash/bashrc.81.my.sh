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

update-env() {
  source $HOME/.bashrc
}

#------------------------------------------------------
# mypython.sh
#------------------------------------------------------
mypython-set-python-anaconda() {
  mypython.sh --set python-anaconda $1
  update-env
}
mypython-set-python-miniconda() {
  mypython.sh --set python-miniconda $1
  update-env
}
mypython-set-python-win() {
  mypython.sh --set python-win $1
  update-env
}
mypython-set-python() {
  mypython.sh --set python $1
  update-env
}

#------------------------------------------------------
# mycmake.sh
#------------------------------------------------------
mycmake-set-ninja-release() {
  mycmake.sh --set ninja Release
  update-env
}
mycmake-set-ninja-debug() {
  mycmake.sh --set ninja Debug
  update-env
}
mycmake-set-make-release() {
  mycmake.sh --set make Release
  update-env
}
mycmake-set-make-debug() {
  mycmake.sh --set make Debug
  update-env
}
mycmake-set-vs2017-release() {
  mycmake.sh --set vs2017 Release
  update-env
}
mycmake-set-vs2017-debug() {
  mycmake.sh --set vs2017 Debug
  update-env
}
mycmake-set-vs2017-reldeb() {
  mycmake.sh --set vs2017 RelWithDebInfo
  update-env
}
mycmake-set-vs2019-release() {
  mycmake.sh --set vs2019 Release
  update-env
}
mycmake-set-vs2019-debug() {
  mycmake.sh --set vs2019 Debug
  update-env
}
mycmake-set-vs2019-reldeb() {
  mycmake.sh --set vs2019 RelWithDebInfo
  update-env
}

#------------------------------------------------------
# misc
#------------------------------------------------------
print-env-config() {
  echo "MY_HOME            = $MY_HOME"
  echo "MY_CONFIG          = $MY_CONFIG"
  echo "MY_REMOTE_CONFIG   = $MY_REMOTE_CONFIG"
  echo "MY_LOCAL_CONFIG    = $MY_LOCAL_CONFIG"
  echo "MY_PRIVATE_CONFIG  = $MY_PRIVATE_CONFIG"
  echo "MY_OS_NAME         = $MY_OS_NAME"
  echo "MY_PYTHON_EXE      = $MY_PYTHON_EXE"
  echo "                   = $(which $MY_PYTHON_EXE)"
}

print-env-build() {
  echo "MY_PUSHD_DIR       = $MY_PUSHD_DIR"
  echo "MY_PYTHON_TYPE     = $MY_PYTHON_TYPE"
  echo "MY_PYTHON_VENV     = $MY_PYTHON_VENV"
  echo "MY_BUILD_SYS       = $MY_BUILD_SYS"
  echo "MY_BUILD_CONFIG    = $MY_BUILD_CONFIG"
}

print-env-proxy() {
  echo "HTTP_PROXY         = $HTTP_PROXY"
  echo "HTTPS_PROXY        = $HTTPS_PROXY"
  echo "GIT_SSL_NO_VERIFY  = $GIT_SSL_NO_VERIFY"
  echo "CURL_SSL_NO_VERIFY = $CURL_SSL_NO_VERIFY"
}

print-env() {
  print-env-config
  print-env-build
  print-env-proxy
}

#------------------------------------------------------
# vimapi
#------------------------------------------------------
vimapi-lcd() {
  local dir=${*:-$PWD}
  vimapi.sh lcd --filepath "$dir"
}

vimapi-tcd() {
  local dir=${*:-$PWD}
  vimapi.sh tcd --filepath "$dir"
}

vimapi-cd() {
  local dir=${*:-$HOME}
  cd "$dir"
  vimapi-lcd
}

vimapi-pushd() {
  pushd "$@"
  vimapi-lcd
}

vimapi-popd() {
  popd "$@"
  vimapi-lcd
}

vimapi-resize() {
  local rows=${1:-10}
  vimapi.sh MyWinResize $rows
}

vimapi-tab-diff() {
  vimapi.sh MyTabDiff "$1" "$2"
}

vimapi-tab-dirdiff() {
  vimapi.sh MyTabDirDiff "$1" "$2"
}

vimapi-nerdtree() {
  local dir=${*:-$PWD}
  vimapi.sh MyNERDTreeFind --filepath "$dir"/
}

vimapi-fern() {
  local dir=${*:-$PWD}
  vimapi.sh MyFernDrawer --filepath "$dir"/
}

vimapi-dir() {
  local dir="${1:-$PWD}"
  local winnr=${2:-1}
  if [ -n "$dir" ]; then
    vimapi.sh BmkEditDir --filepath "$dir"/ $winnr
  fi
}

vimapi-edit() {
  local file="$1"
  local winnr="${2:--1}"
  if [ -n "$file" ]; then
    vimapi.sh BmkEditFile --filepath "$file" "$winnr"
  fi
}

vimapi-split() {
  local file="$1"
  if [ -n "$file" ]; then
    vimapi.sh --in-above-win "below split" --filepath "$file"
  else
    vimapi.sh --in-above-win "below split"
  fi
}

vimapi-tabedit() {
  local file="$1"
  if [ -n "$file" ]; then
    vimapi.sh tabedit --filepath "$file"
  else
    vimapi.sh tabedit
  fi
}

vimapi-termcd() {
  local winnr="$1"
  if [ -n "$winnr" ]; then
    vimapi.sh MyIDESendCdT2T --filepath "$PWD" $winnr
  fi
}

vimapi-tabline-set-label() {
  vimapi.sh MyTabLineSetLabel "$*"
}

vimapi-tabline-set-info() {
  info=""
  info="$info[$MY_PYTHON_TYPE,$MY_PYTHON_VENV]"
  info="$info[$MY_BUILD_SYS,$MY_BUILD_CONFIG]"
  vimapi.sh MyTabLineSetInfo "$info"
}

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
export MY_VIM_USE_FERN=1

if [ "$VIM_TERMINAL" ]; then
  alias cd='vimapi-cd'
  alias pushd='vimapi-pushd'
  alias popd='vimapi-popd'
  alias vimdiff='vimapi-tab-diff'
  alias vimdirdiff='vimapi-tab-dirdiff'
  vim() { vimapi-edit "$@"; }

  alias I='vimapi.sh MyWinInitSize'
  alias TV='vimapi.sh MyTermV'
  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias GS='vimapi.sh --in-new-tab MyGstatusToggle'
  alias GV='vimapi.sh --in-new-tab MyGV'
  alias E='vimapi.sh --in-new-tab MyIDE'
  alias T='vimapi.sh MyTerm'
  alias N='vimapi.sh new'

  if [ $MY_VIM_USE_FERN -eq 1 ]; then
    #alias D='vimapi-fern'
    alias D='vimapi-dir "$PWD"'
    alias F='vimapi.sh MyFernDrawerToggle'
  else
    alias D='vimapi-nerdtree'
    alias F='vimapi.sh MyNERDTreeToggle'
  fi

  alias ,e='vimapi-edit'
  alias ,sp='vimapi-split'
  alias ,new='vimapi.sh "new"'
  alias ,tabe='vimapi-tabedit'

  alias ,termcd='vimapi-termcd'
  alias ,resize='vimapi-resize'
else
  alias GS='vim -c "MyGstatusToggle"'
  alias GV='vim -c "MyGV"'
  alias E='vim -c "MyIDE"'
  alias T='vim -c "MyTerm"'

  if [ $MY_VIM_USE_FERN -eq 1 ]; then
    alias F='vim -c "MyFernDrawerToggle"'
  else
    alias F='vim -c "MyNERDTreeToggle"'
  fi

  alias z='vim -c "DiaFull"'
  alias zh='vim -c "DiaFullH"'
fi

#------------------------------------------------------
# git
#------------------------------------------------------
alias G='gg-d -6'
alias GA='gg-d -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

#------------------------------------------------------
alias pp='print-path.sh -p'

#------------------------------------------------------
alias make='mymake.sh'

