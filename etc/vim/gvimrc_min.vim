"======================================================
" minimal gvimrc
"======================================================
if has("gui_running")
  set guifont=HackGen_Console_NF:h14
  "set guifont=Cica:h14
  "set guifont=Myrica_M:h14
  "set guifont=あくあフォント:h14

  " gui menu
  "set guioptions-=m
  set guioptions-=T
endif

"------------------------------------------------------
" IM off for start up
"------------------------------------------------------
if 0
  " IM off for start up
  set iminsert=0
  set imsearch=-1
  inoremap <ESC> <ESC>:set iminsert=0<CR>
  "inoremap <ESC> <ESC>:set iminsert=0 nopaste<CR>
endif

"------------------------------------------------------
" color
"------------------------------------------------------
"hi Normal ctermfg=223 ctermbg=236 guifg=#ebdbb2 guibg=#32302f
colorscheme slate
syntax on

