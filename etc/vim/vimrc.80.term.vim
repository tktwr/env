"======================================================
" term
"======================================================
if &term =~ "xterm"
  " mouse support
  set mouse=a
  set ttymouse=xterm2
endif

" terminal window
"set notimeout ttimeout
set timeoutlen=100
tnoremap <Esc>   <C-W>N
tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>j
tnoremap <C-K>   <C-W>k
tnoremap <C-L>   <C-W>l
tnoremap <C-V>   <C-W>""

