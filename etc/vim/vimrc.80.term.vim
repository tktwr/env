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

" go to Terminal-Normal
tnoremap <C-O>      <C-W>N
" paste register
tnoremap <C-V>      <C-W>""
" clear screen
tnoremap <C-G>      <C-L>
" close terminal
tnoremap <C-X>      <C-D>

tnoremap <C-H>      <C-W>h
tnoremap <C-J>      <C-W>j
tnoremap <C-K>      <C-W>k
tnoremap <C-L>      <C-W>l

nnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
nnoremap <silent> <C-Down>   <C-W>:MyTerm 0<CR>

tnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
tnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
tnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
tnoremap <silent> <C-Down>   <C-W>:MyTerm 0<CR>

nmap <Insert> <C-Up>
nmap <Del>    <C-Down>

tmap <Insert> <C-Up>
tmap <Del>    <C-Down>

tnoremap <ScrollWheelUp> <C-W>N<ScrollWheelUp>

tnoremap <silent> <C-1> <C-W>:call MyTermPlace("K", g:my_term_winheight)<CR>
tnoremap <silent> <C-8> <C-W>:call MyTermPlace("J", "4")<CR>
tnoremap <silent> <C-9> <C-W>:call MyTermPlace("J", "")<CR>
tnoremap <silent> <C-0> <C-W>:call MyTermPlace("J", g:my_term_winheight)<CR>

