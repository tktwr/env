#!/bin/bash

#======================================================
# alias
#======================================================
f_alias() {
  # source
  alias s='source $HOME/.bashrc'
  alias s.venv='source .venv/bin/activate'
  alias s.zero='source $MY_BASH/bashrc_zero.sh'

  # shell
  alias h='history 20'
  alias j='jobs -l'
  alias where='type -all'

  # remap
  alias sudo='sudo -E'
  alias grep='grep -s'
  alias nm='nm -C'
  alias df='df -h'
  alias more='$PAGER'
  alias fd='fdfind'

  # ps
  alias psu='ps -H -u $USER'
  alias psall='ps -aefH'

  # ls
  alias lsd='\ls -d --color=auto */'
  alias tree2='tree -L 2'

  # python
  alias p='python'

  # vim
  alias vi='vim'
  alias vim-none='/usr/bin/vim -u NONE'
  alias vim-zero='/usr/bin/vim -u $MY_VIM/vimrc_zero.vim'
  alias vim-test-plug='/usr/bin/vim -u $MY_VIM/vimrc_test_plug.vim'

  # vifm
  alias vf='vifm'
  alias vf.='vifm -c "OneCol" . ~'
  alias vf..='vifm -c "TwoCol" . .'

  # net
  alias wget-page='wget -N -k -p -L -np'
  alias wget-page1='wget -N -k -p -L -np -r -l1'
  alias wget-page2='wget -N -k -p -L -np -r -l2'
  alias wget-local-all='wget -N -k -p -L -np -r --no-proxy'

  # misc
  alias www='w3m -B'
}

ll()  { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -5; }
ff()  { find . -name "$*" -print; }
vid() { display "vid:$*"; }
