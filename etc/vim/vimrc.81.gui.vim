"======================================================
" gvim
"======================================================

"set ambiwidth=double

if has("gui_running")
  set guifont=Cica:h14
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
  set iminsert=0
  set imsearch=-1
  inoremap <ESC> <ESC>:set iminsert=0<CR>
  "inoremap <ESC> <ESC>:set iminsert=0 nopaste<CR>
endif

