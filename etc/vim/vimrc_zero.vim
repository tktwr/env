"======================================================
" variables
"======================================================
set nocompatible

"------------------------------------------------------
" buffer
"------------------------------------------------------
set hidden
set autowrite
set noswapfile
set nobackup
set nowritebackup
set noundofile
set viminfo=

"------------------------------------------------------
" indent
"------------------------------------------------------
set tabstop=2
set shiftwidth=2
set expandtab

"------------------------------------------------------
" color
"------------------------------------------------------
set hlsearch
syntax on

"======================================================
" map
"======================================================
nnoremap Q       :confirm qall<CR>
nnoremap '       `

nnoremap <C-D>   <C-B>

nnoremap <C-G>   <C-L>
tnoremap <C-G>   <C-L>

"------------------------------------------------------
" map: window/terminal
"------------------------------------------------------
tnoremap <C-O>   <C-W>N

nnoremap <C-;>   <C-W>:
tnoremap <C-;>   <C-W>:

nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>w
tnoremap <C-K>   <C-W>W
tnoremap <C-L>   <C-W>l
