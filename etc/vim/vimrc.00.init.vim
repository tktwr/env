"======================================================
" .vimrc
"======================================================

set nocompatible

"------------------------------------------------------
" path
"------------------------------------------------------
"set shell=/bin/sh

set path=.,,/usr/local/include,/usr/include

set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set runtimepath^=$MY_VIM
set runtimepath+=$MY_VIM/after

set tags=./tags
set tags+=../tags
set tags+=../../tags
set tags+=../../../tags
set tags+=../../../../tags
set tags+=../../../../../tags
set tags+=../../../../../../tags
set tags+=../../../../../../../tags
set tags+=tags

set dictionary=$MY_VIM/words
"------------------------------------------------------
" basic
"------------------------------------------------------
set hidden
set autowrite
set noswapfile
set nobackup
set nowritebackup
set noundofile

set timeoutlen=300

set signcolumn=yes
set scrolloff=0
set backspace=2
set cmdheight=2
set showtabline=2
set winheight=10
set previewheight=10
"set previewpopup=height:10,width:60
set eadirection=ver
set listchars=tab:>-,trail:-,eol:$

set wildignore+=*/build*/**
set hlsearch
set incsearch

set complete=.,w,b,u,i

"set showcmd
"set ignorecase
"set smartcase
"set viminfo='50,\"50,%
"set efm=%AERROR\ File\ =\ %f,\ Line\ =\ %l,%C%m
"set formatoptions=tcq

"set modeline
"set modelines=5

"------------------------------------------------------
" color
"------------------------------------------------------
set termguicolors
set t_Co=256
set background=dark
"------------------------------------------------------
" indent
"------------------------------------------------------
set noautoindent
set tabstop=2
set shiftwidth=2
set expandtab
"------------------------------------------------------
" folding
"------------------------------------------------------
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1
set foldclose=all
set nofoldenable
"------------------------------------------------------
" diff
"------------------------------------------------------
set diffopt=filler,vertical,iwhite
"------------------------------------------------------
" vim >= 700
"------------------------------------------------------
if !has('nvim')
  if v:version >= 700
    " disable popup menu for completion
    "set completeopt=
    "set textwidth=0
    "set paste
    "set ambiwidth=double
    set cm=blowfish2
  endif
endif
"------------------------------------------------------
" encoding
"------------------------------------------------------
set encoding=utf-8
if has("win32unix") || has("win32") || has("win64")
  "set fileencodings=ucs-bom,utf-8,euc-jp,cp932,cp936
  set fileencodings=utf-8,euc-jp,cp932,cp936
elseif has("unix")
  set fileencodings=utf-8,euc-jp,sjis,euc-cn
endif
"------------------------------------------------------
" Windows
"------------------------------------------------------
if has("win32unix") || has("win32") || has("win64")
  "source $VIMRUNTIME/mswin.vim
  "behave mswin
endif

