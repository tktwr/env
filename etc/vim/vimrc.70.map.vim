"======================================================
" map
"======================================================
"------------------------------------------------------
" imap
"------------------------------------------------------
" emacs-style editing in the insert mode
inoremap <C-A>   <Home>
inoremap <C-E>   <End>
inoremap <C-D>   <Del>
inoremap <C-B>   <Left>
inoremap <C-F>   <Right>
"inoremap <C-P>   <Up>
"inoremap <C-N>   <Down>

imap <C-L>       <Plug>(coc-snippets-expand)

"------------------------------------------------------
" cmap
"------------------------------------------------------
" emacs-style editing in the command mode
cnoremap <C-A>   <Home>
cnoremap <C-E>   <End>
cnoremap <C-D>   <Del>
cnoremap <C-B>   <Left>
cnoremap <C-F>   <Right>
cnoremap <C-P>   <Up>
cnoremap <C-N>   <Down>

"------------------------------------------------------
" nmap
"------------------------------------------------------
nnoremap '       `
nnoremap Q       :confirm qall<CR>
" fold on/off
nnoremap ==      zi

" tag
nnoremap <C-]>   g<C-]>
" scroll
nnoremap <C-D>   <C-B>
" execute commands in the register q
nnoremap <C-Q>   @q

nnoremap <C-B>   :call MyWinMoveTerm()<CR>
nnoremap <C-X>   :close<CR>
nnoremap <C-E>   :only<CR>

nnoremap <C-P>   :cp<CR>
nnoremap <C-N>   :cn<CR>

nnoremap <C-Y>   :call MyTermSendCd("")<CR>
nnoremap <C-A>   :MyMakeLink<CR>

nnoremap <C-.>   :MyLcdHere<CR>

nnoremap <TAB>   :MyNERDTreeToggle<CR>
nnoremap <BS>    :MyTagbarToggle<CR>
nnoremap <CR>    :call MyEdit("")<CR>

nnoremap <C-CR>  :MyNERDTreeOpen<CR>
nnoremap <S-CR>  :call MyOpen("")<CR>

"nnoremap <C-TAB> :echo "C-TAB"<CR>
"nnoremap <C-BS>  :echo "C-BS"<CR>
"nnoremap <C-CR>  :echo "C-CR"<CR>

"nnoremap <S-TAB> :echo "S-TAB"<CR>
"nnoremap <S-BS>  :echo "S-BS"<CR>
"nnoremap <S-CR>  :echo "S-CR"<CR>

nmap <C-U>       <Plug>(quickhl-manual-this)
xmap <C-U>       <Plug>(quickhl-manual-this)

nnoremap <C-;>   <C-W>:
nnoremap <C-G>   :MyRedraw<CR>

"------------------------------------------------------
" tmap
"------------------------------------------------------
" go to Terminal-Normal
tnoremap <C-O>   <C-W>N
" paste register
tnoremap <C-V>   <C-W>""

tnoremap <ScrollWheelUp> <C-W>N<ScrollWheelUp>

tnoremap <C-;>   <C-W>:
tnoremap <C-G>   <C-L>

"------------------------------------------------------
" map.window.move
"------------------------------------------------------
nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>w
tnoremap <C-K>   <C-W>W
tnoremap <C-L>   <C-W>l

"------------------------------------------------------
" map.window.resize
"------------------------------------------------------
nnoremap <C-0> <C-W>:echo "C-0"<CR>
nnoremap <C-1> <C-W>t
nnoremap <C-@> <C-W>:call MyWinBufExchange(2)<CR>
nnoremap <C-3> <C-W>:call MyWinBufExchange(3)<CR>
nnoremap <C-4> <C-W>:call MyWinBufExchange(4)<CR>
nnoremap <C-5> <C-W>:call MyWinBufExchange(5)<CR>
nnoremap <C-^> <C-W>:echo "C-6"<CR>
nnoremap <C-7> <C-W>:call MyWinMaximizeXToggle()<CR>
nnoremap <C-8> <C-W>:call MyWinMaximizeXYToggle()<CR>
nnoremap <C-9> <C-W>:call MyWinMaximizeYToggle()<CR>

tnoremap <C-0> <C-W>:echo "C-0"<CR>
tnoremap <C-1> <C-W>t
tnoremap <C-@> <C-W>:call MyWinBufExchange(2)<CR>
tnoremap <C-3> <C-W>:call MyWinBufExchange(3)<CR>
tnoremap <C-4> <C-W>:call MyWinBufExchange(4)<CR>
tnoremap <C-5> <C-W>:call MyWinBufExchange(5)<CR>
tnoremap <C-^> <C-W>:echo "C-6"<CR>
tnoremap <C-7> <C-W>:call MyWinMaximizeXToggle()<CR>
tnoremap <C-8> <C-W>:call MyWinMaximizeXYToggle()<CR>
tnoremap <C-9> <C-W>:call MyWinMaximizeYToggle()<CR>

"------------------------------------------------------
" map.tab
"------------------------------------------------------
nnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
nnoremap <silent> <C-Down>   <C-W>:MyTerm<CR>
nnoremap <silent> <Insert>   <C-W>:tabedit<CR>
nnoremap <silent> <Del>      <C-W>:tabclose<CR>

tnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
tnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
tnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
tnoremap <silent> <C-Down>   <C-W>:MyTerm<CR>
tnoremap <silent> <Insert>   <C-W>:tabedit<CR>
tnoremap <silent> <Del>      <C-W>:tabclose<CR>

"======================================================
" autocmd
"======================================================
"------------------------------------------------------
" autocmd for NERDTree
"------------------------------------------------------
func s:my_nerdtree_settings()
  nmap <buffer> <C-.>   C
  nmap <buffer> k       -
  nmap <buffer> j       +
  nmap <buffer> h       u
  nmap <buffer> l       go
  nmap <buffer> S       /\[scratchpad\]<CR>
  nmap <buffer> B       :Bookmark<CR>
  nmap <buffer> E       :EditBookmarks<CR>
  "nmap <buffer> D       :echo D<CR>  "delete bookmark
  nmap <buffer> <Space> goq
  nmap <buffer> <C-J>   <C-W>w
  nmap <buffer> <C-K>   <C-W>W
  nmap <buffer> 2       :call MyNERDTreeFileOpen(2)<CR>
  nmap <buffer> 3       :call MyNERDTreeFileOpen(3)<CR>
  nmap <buffer> 4       :call MyNERDTreeFileOpen(4)<CR>
  nmap <buffer> 5       :call MyNERDTreeFileOpen(5)<CR>
endfunc

autocmd FileType nerdtree call s:my_nerdtree_settings()

"------------------------------------------------------
" autocmd for fugitive
"------------------------------------------------------
func s:my_fugitive_settings()
  nmap <buffer> D       dd
endfunc

autocmd FileType fugitive call s:my_fugitive_settings()

"------------------------------------------------------
" autocmd for GV
"------------------------------------------------------
func s:my_gv_settings()
endfunc

func s:my_git_settings()
  nmap <buffer> D       O
endfunc

autocmd FileType GV       call s:my_gv_settings()
autocmd FileType git      call s:my_git_settings()

"------------------------------------------------------
" autocmd for diff mode
"------------------------------------------------------
func s:my_diff_settings()
  if &diff == 1
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
  else
    nnoremap <buffer> <C-P>   :cp<CR>
    nnoremap <buffer> <C-N>   :cn<CR>
  endif
endfunc

autocmd WinEnter * call s:my_diff_settings()

"------------------------------------------------------
