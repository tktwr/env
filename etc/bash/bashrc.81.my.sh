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
vimapi-cd() {
  local dir=${*:-$HOME}
  cd "$dir"
  vimapi.sh "lcd $PWD"
}

vimapi-pushd() {
  pushd "$@"
  vimapi.sh "lcd $PWD"
}

vimapi-popd() {
  popd "$@"
  vimapi.sh "lcd $PWD"
}

vimapi-dir() {
  local dir=${1:-$PWD}
  local winnr=${2:-1}
  vimapi.sh --winnr $winnr --edit-dir "$dir"
}

vimapi-dir2() {
  local dir=${1:-$PWD}
  local winnr=2
  vimapi.sh --winnr $winnr --edit-dir "$dir"
}

vimapi-vim() {
  local file="$1"
  local winnr=${2:--1}
  vimapi.sh --winnr $winnr --edit "$file"
}

vimapi-resize() {
  local rows=${1:-10}
  vimapi.sh VisWinResize $rows
}

vimapi-nerdtree() {
  local dir=${*:-$PWD}
  vimapi.sh VisNERDTreeFind "$dir/"
}

vimapi-fern() {
  local dir=${*:-$PWD}
  vimapi.sh VisFernDrawer "$dir/"
}

vimapi-termcd() {
  local winnr="$1"
  if [ -n "$winnr" ]; then
    vimapi.sh VisSendCdT2T "$PWD" $winnr
  fi
}

vimapi-tabline-set-label() {
  vimapi.sh VisTabLineSetLabel "$*"
}

vimapi-tabline-set-info() {
  info=""
  info="$info[$MY_PYTHON_TYPE,$MY_PYTHON_VENV]"
  info="$info[$MY_BUILD_SYS,$MY_BUILD_CONFIG]"
  vimapi.sh VisTabLineSetInfo "$info"
}

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
if [ "$VIM_TERMINAL" ]; then
  vim() { vimapi-vim "$@"; }

  alias cd='vimapi-cd'
  alias pushd='vimapi-pushd'
  alias popd='vimapi-popd'

  alias I='vimapi.sh VisWinInitSize'
  alias TV='vimapi.sh VisTermV'
  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias GV='vimapi.sh --in-new-tab MyGV'
  alias GS='vimapi.sh --in-new-tab VisGstatusToggle'
  alias E='vimapi.sh --in-new-tab VisIDE'
  alias T='vimapi.sh VisTerm'
  alias N='vimapi.sh new'

  alias D='vimapi-dir'
  alias D2='vimapi-dir2'

  alias ,tabe='vimapi.sh tabedit'

  alias ,termcd='vimapi-termcd'
  alias ,resize='vimapi-resize'
else
  alias GV='vim -c "MyGV"'
  alias GS='vim -c "VisGstatusToggle"'
  alias E='vim -c "VisIDE"'
  alias T='vim -c "VisTerm"'

  alias z='vim -c "DiaFull"'
  alias zh='vim -c "DiaFullH"'
fi

#------------------------------------------------------
alias pp='print-path.sh -p'

#------------------------------------------------------
alias make='mymake.sh'
alias vimdiff='vimdiff.sh'
alias vimdirdiff='vimdirdiff.sh'

