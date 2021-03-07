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

" send a cmd to a terminal
func MyTermSendCmd(cmd)
  let l:nr = bufnr("!/usr/bin/bash")
  let l:cmd = a:cmd
  if (l:cmd == "")
    let l:cmd = getline('.')
  endif
	call term_sendkeys(l:nr, l:cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func MyTermSendCd(dir)
  let l:nr = bufnr("!/usr/bin/bash")
  let l:dir = expand(a:dir)
  if (l:dir == "")
    let l:dir = expand("<cfile>")
    "let l:dir = getline('.')
  endif
	call term_sendkeys(l:nr, "cd ".l:dir."\<CR>")
  let l:winnr = bufwinnr("!/usr/bin/bash")
  exec l:winnr."wincmd w"
endfunc

" recieve a dir from a terminal
func Tapi_NERDTree(_, dir)
  exec "NERDTree" a:dir
  exec "wincmd p"
  call MyTermPlace("J", g:my_term_winheight)
  exec "wincmd p"
endfunc

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

func MyTermPlace(place, height)
  exec "wincmd " a:place
  exec "resize" a:height
endfunc

command -nargs=1 MyTerm  call s:MyTerm("<args>")

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

