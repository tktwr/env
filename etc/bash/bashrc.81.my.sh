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
alias pp='print-path.sh -p'
alias make='mymake.sh'

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
if [ "$VIM_TERMINAL" ]; then
  alias I='vimapi.sh VisWinInitSize'
  alias TV='vimapi.sh VisTermV'
  alias GL='vimapi.sh --in-above-win GitLog $PWD'

  alias ,tabe='vimapi.sh tabedit'
  alias ,termcd='vimapi-termcd'
else
  alias z='vim -c "DiaFull"'
  alias zh='vim -c "DiaFullH"'
fi

export MY_VIM_IDE="$MY_VIM/plugged/vim-ide-style"
export PATH="$MY_VIM_IDE/bin:$PATH"
source $MY_VIM_IDE/etc/bashrc
