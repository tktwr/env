#!/bin/bash

TIME_PRINT=0

declare -A TIME_START
declare -A TIME_END
declare -A TIME_DURATION

f_time_start() {
  if [ $TIME_PRINT -eq 0 ]; then
    return
  fi
  TIME_START[$1]=$(date +"%s.%3N")
}

f_time_end() {
  if [ $TIME_PRINT -eq 0 ]; then
    return
  fi
  TIME_END[$1]=$(date +"%s.%3N")
  TIME_DURATION[$1]=`echo "scale=1; ${TIME_END[$1]} - ${TIME_START[$1]}" | bc`
  echo "$1: ${TIME_DURATION[$1]} sec"
}

f_time_start bashrc.00.init
#!/bin/bash

source $HOME/.hostname

# bash
HISTCONTROL=ignoreboth
#umask 022

# env variables
export PAGER='less -FRX'
export EDITOR='vim'
#export GIT_PAGER='less'
#export GIT_EDITOR='vim'

export WWW_HOME="https://tktwr.github.io/memo/"

unalias -a

f_time_end bashrc.00.init
f_time_start bashrc.10.colors
#!/bin/bash

# tw: スティッキビットありother書き込み権限つきディレクトリ
# ow: スティッキビットなしother書き込み権限つきディレクトリ

# ls colors
LS_COLORS=""
LS_COLORS="$LS_COLORS:di=34:ex=32:ln=33"
LS_COLORS="$LS_COLORS:tw=34:ow=34"
LS_COLORS="$LS_COLORS:*Makefile=41;37"
LS_COLORS="$LS_COLORS:*.c=31:*.C=31:*.cc=31:*.cpp=31:*.cxx=31:*.c++=31"
LS_COLORS="$LS_COLORS:*.h=32:*.H=32:*.hh=32:*.hpp=32:*.hxx=32:*.h++=32"
LS_COLORS="$LS_COLORS:*.o=33:*.a=35"
LS_COLORS="$LS_COLORS:*.java=31:*.class=33:*.jar=32"
LS_COLORS="$LS_COLORS:*.pl=31"
LS_COLORS="$LS_COLORS:*.html=31:*.htm=31:*.shtml=31:*.php=31"
LS_COLORS="$LS_COLORS:*.md.html=31"
LS_COLORS="$LS_COLORS:*.css=33"
LS_COLORS="$LS_COLORS:*.js=32"
LS_COLORS="$LS_COLORS:*.tex=31:*.cls=32:*.sty=32:*.bib=32:*.eps=35:*.ps=35:*.pdf=36:*.doc=36"
LS_COLORS="$LS_COLORS:*.bak=42;37:*.old=42;37"
LS_COLORS="$LS_COLORS:*.tar=32:*.tgz=32:*.zip=32:*.Z=32:*.gz=32:*.bz2=32:*.lzh=32"
LS_COLORS="$LS_COLORS:*.xbm=33:*.xpm=33:*.gif=33:*.ppm=33:*.png=33:*.jpg=33:*.jpeg=33:*.tif=33:*.tiff=33:*.tga=33:*.sgi=33:*.rgb=33:*.bmp=33"
LS_COLORS="$LS_COLORS:*.hdr=34:*.pic=34:*.i3f=34"
LS_COLORS="$LS_COLORS:*.mpg=35:*.avi=35:*.mov=35"
export LS_COLORS

# colors
export COLOR0="\033[30m"  # black
export COLOR1="\033[31m"  # red
export COLOR2="\033[32m"  # green
export COLOR3="\033[33m"  # yellow
export COLOR4="\033[34m"  # blue
export COLOR5="\033[35m"  # magenta
export COLOR6="\033[36m"  # cyan
export COLOR7="\033[37m"  # white
export COLORD="\033[0m"   # default
export COLORR="\033[7m"   # reverse

export ECO0="\[$COLOR0\]"
export ECO1="\[$COLOR1\]"
export ECO2="\[$COLOR2\]"
export ECO3="\[$COLOR3\]"
export ECO4="\[$COLOR4\]"
export ECO5="\[$COLOR5\]"
export ECO6="\[$COLOR6\]"
export ECO7="\[$COLOR7\]"
export ECOD="\[$COLORD\]"
export ECOR="\[$COLORR\]"

f_time_end bashrc.10.colors
f_time_start bashrc.10.func
#!/bin/bash

#======================================================
# function
#
# NOTE: Don't forget to add ";" at the end of the commands.
#======================================================

f_set_DISPLAY() { export DISPLAY="$*:0.0"; }
f_print_DISPLAY() { echo $DISPLAY; }

f_add_path() { export PATH="$PATH:$*"; }
f_add_ld_path() { export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$*"; }
f_add_man_path() { export MANPATH="$MANPATH:$*"; }
f_add_info_path() { export INFOPATH="$INFOPATH:$*"; }

f_ins_path() { export PATH="$*:$PATH"; }
f_ins_ld_path() { export LD_LIBRARY_PATH="$*:$LD_LIBRARY_PATH"; }
f_ins_man_path() { export MANPATH="$*:$MANPATH"; }
f_ins_info_path() { export INFOPATH="$*:$INFOPATH"; }

f_set_core_off() { ulimit -S -c 0; }
f_set_core_on() { ulimit -S -c unlimited; }

f_set_prompt() {
  local COLOR_USER
  local COLOR_HOST
  local COLOR_DEF

  if [ $TERM = "xterm" -o $TERM = "vt100" ]; then
    # set title bar
    PROMPT_COMMAND='echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;`dirs`\007"'

    COLOR_USER="\[$COLORR$COLOR6\]"
    COLOR_DEF="\[$COLORD\]"
    case $MY_HOST_NAME in
    *)
      COLOR_HOST="\[$COLOR2\]"
      ;;
    esac
  fi

  PS1="$COLOR_USER\u$COLOR_HOST@\h$COLOR_DEF[\w]\$ "

  export PS1
}

f_set_locale() {
  unset LANG LANGUAGE
  unset LC_ALL LC_COLLATE LC_MESSAGES LC_NUMERIC LC_CTYPE LC_MONETARY LC_TIME
  case $1 in
  C)
    export LANG=C
    ;;
  en)
    export LANG=en_US
    export LANGUAGE=en_US:en
    ;;
  ja)
    export LANG=ja_JP.eucJP
    export LANGUAGE=ja_JP.eucJP:ja
    ;;
  none)
    ;;
  esac
}

f_time_end bashrc.10.func
f_time_start bashrc.10.path
#!/bin/bash

# system path
if [ -z "$SYS_PATH" ]; then
  export SYS_PATH=$PATH
  export SYS_MANPATH=$MANPATH
  export SYS_INFOPATH=$INFOPATH
  export SYS_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
fi

export PATH="$SYS_PATH"
export MANPATH="$SYS_MANPATH"
export INFOPATH="$SYS_INFOPATH"
export LD_LIBRARY_PATH="$SYS_LD_LIBRARY_PATH"

MANPATH="/usr/local/share/man:$MANPATH"

for i in $MY_LOCAL_CONFIG/local $MY_LOCAL_CONFIG/opt.$MY_OS_NAME; do
  PATH="$i/bin:$PATH"
  LD_LIBRARY_PATH="$i/bin:$LD_LIBRARY_PATH"
  LD_LIBRARY_PATH="$i/lib:$LD_LIBRARY_PATH"
  MANPATH="$i/share/man:$MANPATH"
  INFOPATH="$i/share/info:$INFOPATH"
done

for i in $MY_REMOTE_CONFIG/env $MY_LOCAL_CONFIG/env; do
  PATH="$i/bin:$PATH"
  PATH="$i/bin/os.$MY_OS_NAME:$PATH"
  PATH="$i/bin/shell.$MY_SHELL_NAME:$PATH"
  PATH="$i/bin/site.$MY_SITE_NAME:$PATH"
  PATH="$i/bin/host.$MY_HOST_NAME:$PATH"
  PATH="$i/share/dict:$PATH"
done

f_time_end bashrc.10.path
f_time_start bashrc.11.alias
#!/bin/bash

# directory stack
alias .='pushd'
alias ..='pushd +2'
alias ...='pushd +3'
alias ,='popd'
alias ,,='popd +1'
alias ?='dirs -v'
alias .c='dirs -c'
alias .i='dirs -c; cd'

# remap
alias nm='nm -C'
alias df='df -h'
alias more='$PAGER'

# shell
alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'
alias lsd='\ls -d --color=auto */'
alias psu='ps -u $USER'
ll() { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -15; }
psall() { ps -aef | grep $*; }
ff() { find . -name "$*" -print; }

# net
alias myrsync='rsync -auvR'
alias mymirror='rsync -avR --delete'
alias mymirrorfat='rsync -avR --delete --size-only -O --no-g --no-p'
alias wgetpage='wget -N -k -p -L -np'
alias wgetpage1='wget -N -k -p -L -np -r -l1'
alias wgetpage2='wget -N -k -p -L -np -r -l2'

# vim
alias vi='vim'
alias vimtags='vim -e -c "helptags . | quit"'
alias vimzero='vim -u NONE'
alias V='vim -c "NERDTreeToggle"'
vimwhich() { vim `which $*`; }

# cmake, build
alias cmake-unix-release='cmake -G "Unix Makefiles" -D CMAKE_BUILD_TYPE=Release'
alias cmake-unix-debug='cmake -G "Unix Makefiles" -D CMAKE_BUILD_TYPE=Debug'
alias cmake-vs2017='cmake -G "Visual Studio 15 2017 Win64"'
alias cmake-build-release='cmake --build . --config Release'
alias cmake-build-debug='cmake --build . --config Debug'

# misc
alias www='w3m -B'
vid() { display "vid:$*"; }

#======================================================
# private
#======================================================
# cd
alias cd-rconfig='cd $MY_REMOTE_CONFIG'
alias cd-lconfig='cd $MY_LOCAL_CONFIG'

alias cd-env='cd $MY_ENV'
alias cd-memo='cd $MY_MEMO'
alias cd-samples='cd $MY_SAMPLES'

alias cd-private='cd $MY_PRIVATE'
alias cd-protected='cd $MY_PROTECTED'
alias cd-public='cd $MY_PUBLIC'

alias cd-github='cd $MY_WORK/github'
alias cd-git='cd $MY_WORK/git'
alias cd-svn='cd $MY_WORK/svn'

alias cd-repo='cd $MY_REPO'
alias cd-work='cd $MY_WORK'
alias cd-doc='cd $MY_DOC'

alias cd-opt='cd $MY_OPT'
alias cd-downloads='cd $MY_DOWNLOADS'
alias cd-papers='cd $MY_PAPERS'

# dia
alias z='dia'
alias zv='dia -v'
alias zh='dia -h'

f_time_end bashrc.11.alias
f_time_start bashrc.11.git
#!/bin/bash

export GIT_BRANCH
export PREVPWD

f_checkgit() {
  if [ "$PWD" != "$PREVPWD" ]; then
    GIT_BRANCH=`__git_ps1`
    PREVPWD="$PWD"
  fi
}

f_checkgit_force() {
  PREVPWD=""
  f_checkgit
}

f_git_ps1() {
  echo "$GIT_BRANCH"
}

f_set_git_prompt() {
  PROMPT_COMMAND='echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007";f_checkgit'

  GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
  COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
  COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
  COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
  if [ -f "$COMPLETION_PATH/git-prompt.sh" ]; then
    source "$COMPLETION_PATH/git-completion.bash"
    source "$COMPLETION_PATH/git-prompt.sh"
    #GIT_BRANCH_FUNC='`__git_ps1`'
    GIT_BRANCH_FUNC='`f_git_ps1`'
  fi

  export PROMPT_DIRTRIM=2
  export PS1="$ECOR$ECO2${MY_SHELL_NAME}$ECOD$ECO3[\w]$ECO6${GIT_BRANCH_FUNC}$ECOD\$ "
}

gb() {
  git remote -v
  echo "[BRANCH]"
  git branch -a -vv
  echo "[TAG]"
  git tag
  git ls-remote --tags
}

# less options
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init
gg()   { git graph --color=always $* | less -EFRSX; }
gg-d() { git graph --color=always --date-order  $* | less -EFRSX; }
gg-s() { git graph --color=always --name-status $* | less -EFRSX; }

alias gs='git status'
alias gf='git fetch'
alias gu='f_checkgit_force'

alias gR='git reset --hard'
alias gRom='git reset --hard origin/master'
alias gPom='git push origin master'

alias git-pull-no-commit='git pull --no-commit'
alias git-merge-no-commit='git merge --no-commit'

alias gA='git add'
alias gAu='git add -u'
alias gC='git commit -m'

alias git-add-chmod-x='git update-index --add --chmod=+x'
alias git-ls-filemode='git ls-files -s'

alias git-stage='git add'
alias git-unstage='git reset --'

alias git-track='git add'
alias git-untrack-file='git rm --cached'
alias git-untrack-dir='git rm --cached -r'

alias git-submodule-update-all='git submodule update --init --recursive'
alias git-dirdiff='git difftool --dir-diff'

alias G='gg -15'
alias GG='vim -c "Agit"'
alias S='vim -c "Gstatus"'

f_time_end bashrc.11.git
f_time_start bashrc.50.os.windows
#!/bin/bash

f_set_win_env() {
  export SYS_PROG64_DIR=`cygpath -u 'C:\Program Files'`
  export SYS_PROG32_DIR=`cygpath -u 'C:\Program Files (x86)'`
  export SYS_WIN_HOME=`cygpath -u C:/Users/$USER`
  export SYS_MSYS2_HOME=`cygpath -u C:/msys64/home/$USER`
  export SYS_CYGWIN_HOME=`cygpath -u C:/cygwin64/home/$USER`

  export JAVA_HOME=`cygpath -u 'C:\Program Files\Android\Android Studio\jre'`
  export ANDROID_SDK="$SYS_WIN_HOME/AppData/Local/Android/sdk"
  export ANACONDA_HOME="$SYS_WIN_HOME/Anaconda3"
}

if [ -z "$SYS_PROG64_DIR" ]; then
  f_set_win_env
fi

PATH="$JAVA_HOME/bin:$PATH"
PATH="$ANDROID_SDK/platform-tools:$PATH"
PATH="$ANACONDA_HOME/Scripts:$ANACONDA_HOME:$PATH"

alias x='explorer.exe'
alias ls='ls.sh'

alias cd-win-home='cd $SYS_WIN_HOME'
alias cd-msys2-home='cd $SYS_MSYS2_HOME'
alias cd-cygwin-home='cd $SYS_CYGWIN_HOME'

alias python='winpty python'
alias ipython='winpty ipython'
alias jupyter='winpty jupyter'
alias adb='winpty adb'
f_time_end bashrc.50.os.windows
f_time_start bashrc.90.setup
#!/bin/bash

#======================================================
# setup
#======================================================

f_set_core_off
f_set_git_prompt

f_time_end bashrc.90.setup
