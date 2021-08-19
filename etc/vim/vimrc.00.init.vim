"======================================================
" .vimrc
"======================================================

set nocompatible

"------------------------------------------------------
" path
"------------------------------------------------------
"set shell=/bin/sh

set path=.,,/usr/local/include,/usr/include
set path+=$QTDIR/include

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
set tags+=$MY_ENV/tags.bin.sh
set tags+=$MY_ENV/tags.bin.py
set tags+=$MY_ENV/tags.etc.sh
set tags+=$MY_ENV/tags.etc.vim
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt
set tags+=$MY_REMOTE_CONFIG/samples/tags.memo
set tags+=$MY_REMOTE_CONFIG/memo/tags.memo
set tags+=$MY_LOCAL_CONFIG/memo/tags.memo
set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nativefiledialog
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.stb
set tags+=$MY_OPT/tags.json11
set tags+=$MY_OPT/tags.win

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

"set showcmd
set showtabline=2

set updatetime=300
set signcolumn=yes
set cmdheight=2
set scrolloff=0
set backspace=2

set wildignore+=*/build*/**
set hlsearch
set incsearch
"set ignorecase
"set smartcase
"set viminfo='50,\"50,%
set listchars=tab:>-,trail:-,eol:$
"set efm=%AERROR\ File\ =\ %f,\ Line\ =\ %l,%C%m
"set formatoptions=tcq

"set modeline
"set modelines=5

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
"------------------------------------------------------
" window
"------------------------------------------------------
set eadirection=ver

set winheight=10
let g:my_winheight = 10
let g:my_term_winheight = 10
let g:my_term_winheight_max = 20
let g:my_trans_winheight = 10
let g:my_gstatus_winheight = 10

let g:my_winwidth_max = 110
let g:my_help_winwidth = 82
let g:my_left_winwidth = 30
let g:my_right_winwidth = 30

let g:my_dia_file = "$MY_DIARY/diary.md.html"
let g:my_todo_file = "$MY_DIARY/todo.md.html"

let g:cpm_files = [
  \ "$MY_ETC/bmk/cmd.txt",
  \ "$MY_ETC/bmk/bmk.txt",
  \ "$MY_ETC/bmk/links.txt",
  \ "$MY_ETC/bmk/papers.txt",
  \ "$MY_COMMON_CONFIG/bmk_local.txt",
  \ ]
let g:cpm_titles = {
  \ 'buffer': ['buffer:main', 'buffer:sub', 'buffer:coc', 'ref'],
  \ 'terminal': ['terminal:main', 'terminal:git', 'bmk:dir', 'bmk:local'],
  \ 'fern': ['bmk:dir', 'bmk:local', 'buffer:fern'],
  \ }

let g:bmk_winwidth = g:my_left_winwidth

let g:mapleader = "\<Space>"
"let g:mapleader = ','
let g:maplocalleader = ','
"------------------------------------------------------
func SourceFile(fname)
  let fname = expand(a:fname)
  if filereadable(fname)
    exec "source" fname
  else
    if $MY_DEBUG == 1
      echo "no file:" fname
    endif
  endif
endfunc

command -nargs=1 SourceFile    call SourceFile(<f-args>)

