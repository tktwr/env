"======================================================
" minimal gvimrc
"======================================================

set nocompatible

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936

set noswapfile
set nobackup
set noundofile

set background=dark

nnoremap Q     :confirm qall<CR>

"------------------------------------------------------
" gui
"------------------------------------------------------
set ambiwidth=double

set guifont=Cica:h14
"set guifont=Myrica_M:h14
"set guifont=あくあフォント:h14

" gui menu
"set guioptions-=m
set guioptions-=T

"hi Normal ctermfg=223 ctermbg=236 guifg=#ebdbb2 guibg=#32302f
colorscheme desert
syntax on

if 0
  " IM off for start up
  set iminsert=0
  set imsearch=-1
  inoremap <ESC> <ESC>:set iminsert=0<CR>
endif

