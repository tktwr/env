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

func s:MyTerm(type)
  if a:type == 0
    exec "bot term ++rows=".g:my_term_winheight
  elseif a:type == 1
    tabedit
    bot term
    only
  elseif a:type == 2
    tabedit
    bot term
    only
    bot term
  endif
endfunc

command -nargs=1 MyTerm       call s:MyTerm("<args>")

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
tnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
tnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
tnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
nnoremap <silent> <C-Down>   <C-W>:MyTerm 0<CR>
tnoremap <silent> <C-Down>   <C-W>:MyTerm 0<CR>

nmap <Insert> <C-Up>
tmap <Insert> <C-Up>
nmap <Del>    <C-Down>
tmap <Del>    <C-Down>

