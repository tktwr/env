"======================================================
" term
"======================================================
if &term =~ "xterm"
  " mouse support
  set mouse=a
  set ttymouse=xterm2
endif

"------------------------------------------------------
" terminal window
"------------------------------------------------------
"set notimeout ttimeout
set timeoutlen=100

"tnoremap <Esc>      <C-W>N
"tnoremap <Esc>      <C-\><C-n>

tnoremap <C-O>      <C-W>N
tnoremap <C-V>      <C-W>""
tnoremap <C-G>      <C-L>
tnoremap <C-X>      <C-D>

tnoremap <C-H>      <C-W>h
tnoremap <C-J>      <C-W>j
tnoremap <C-K>      <C-W>k
tnoremap <C-L>      <C-W>l

nnoremap <C-Left>   :tabprev<CR>
nnoremap <C-Right>  :tabnext<CR>
tnoremap <C-Left>   <C-W>:tabprev<CR>
tnoremap <C-Right>  <C-W>:tabnext<CR>

