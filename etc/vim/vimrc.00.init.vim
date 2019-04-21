"------------------------------------------------------
" .vimrc
"------------------------------------------------------

set nocompatible

"set shell=/bin/sh

set path=.,,/usr/local/include,/usr/include
set path+=$QTDIR/include

set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after

set tags=./tags,../tags,../../tags,../../../tags,tags
set tags+=$MY_REMOTE_CONFIG/memo/tags.memo
set tags+=$MY_REMOTE_CONFIG/samples/tags.memo
set tags+=$MY_LOCAL_CONFIG/memo/tags.memo
set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nativefiledialog
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.stb

set dictionary=~/.vim/words

set autowrite

set noswapfile
set nobackup
set noundofile

set showcmd

set cmdheight=2
set winheight=3
"set scrolloff=5
set backspace=2

set hlsearch
set incsearch
"set ignorecase
set viminfo='50,\"50,%
set listchars=tab:>-,trail:-,eol:$
"set efm=%AERROR\ File\ =\ %f,\ Line\ =\ %l,%C%m
set formatoptions=tcq

"set modeline
"set modelines=5

set encoding=utf-8
" encodings for unix
"set fileencodings=utf-8,sjis,euc-jp,euc-cn
" encodings for windows
"set fileencodings=ucs-bom,utf-8,cp932,euc-jp,cp936
set fileencodings=utf-8,cp932,euc-jp,cp936

" indent
set noautoindent
set tabstop=2
set shiftwidth=2
set expandtab

" folding
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1
set foldclose=all
set nofoldenable

" IM off for start up
set iminsert=0
set imsearch=-1
inoremap <ESC> <ESC>:set iminsert=0 nopaste<CR>

"source $VIMRUNTIME/mswin.vim
"behave mswin

if version >= 700
  "set completeopt=
  "set textwidth=0
  "set paste
  "set ambiwidth=double
  set cm=blowfish2
endif

let mapleader = ","

