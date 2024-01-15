#!/bin/bash

#======================================================
# alias
#======================================================

# shell
alias s-zero='source $MY_BASH/bashrc_zero.sh'
alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'

# directory stack
alias ,pushd='pushd'
alias ,pushd1='pushd +1'
alias ,pushd2='pushd +2'
alias ,popd='popd'
alias ,popd1='popd +1'
alias ,popd2='popd +2'
alias ,dirs_v='dirs -v'
alias ,dirs_c='dirs -c'
alias ,dirs_i='dirs -c; cd'

# remap
alias sudo='sudo -E'
alias grep='grep -s'
alias nm='nm -C'
alias df='df -h'
alias more='$PAGER'

# ps
alias psu='ps -H -u $USER'
alias psall='ps -aefH'

# ls
alias lsd='\ls -d --color=auto */'
ll() { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -5; }
alias tree2='tree -L 2'

# find
ff() { find . -name "$*" -print; }

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
vid() { display "vid:$*"; }
