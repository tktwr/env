"------------------------------------------------------
" minimal gvimrc
"------------------------------------------------------

set guifont=Myrica_M:h14
"set guifont=あくあフォント:h14

" gui menu
set guioptions-=m
set guioptions-=T

set background=dark
hi Normal guifg=#D0D0D0 guibg=#303030

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936

set noswapfile
set nobackup
set noundofile

" IM off for start up
set iminsert=0
set imsearch=-1
inoremap <ESC> <ESC>:set iminsert=0<CR>

nnoremap Q     :confirm qall<CR>
