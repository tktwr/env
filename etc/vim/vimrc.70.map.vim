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
" scroll
nnoremap <C-D>   <C-B>

" execute commands in the register q
nnoremap <C-Q>   @q

nnoremap <C-N>   :cn<CR>
nnoremap <C-P>   :cp<CR>

nnoremap <C-O>   :call MyOpen("")<CR>
nnoremap <C-Y>   :call MyTermSendCd("")<CR>
nnoremap <C-CR>  :call MyTermSendCmd("")<CR>
nnoremap <C-A>   :MyMakeLink<CR>
nnoremap <C-.>   :MyCdHere<CR>
nnoremap <C-;>   <C-W>:

" tag
nnoremap <C-]>   g<C-]>

nnoremap '       `
nnoremap Q       :confirm qall<CR>
nnoremap --      :MyLineNumberToggle<CR>
" fold on/off
nnoremap ==      zi

"------------------------------------------------------
" tmap
"------------------------------------------------------
"tnoremap <Esc>   <C-W>N
"tnoremap <Esc>   <C-\><C-n>

" go to Terminal-Normal
tnoremap <C-O>   <C-W>N
" paste register
tnoremap <C-V>   <C-W>""

tnoremap <C-;>   <C-W>:

tnoremap <ScrollWheelUp> <C-W>N<ScrollWheelUp>

"------------------------------------------------------
" map.window
"------------------------------------------------------
nnoremap <C-E>   :only<CR>
nnoremap <C-X>   :close<CR>
" redraw screen
nnoremap <C-G>   :MyRedraw<CR>

" close terminal
tnoremap <C-X>   <C-D>
" clear screen
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
" cannot map <C-2>
"nnoremap <C-2> :echo 2<CR>
" cannot map <C-6>
"nnoremap <C-6> :echo 6<CR>

nnoremap <C-3> :echo 3<CR>
nnoremap <C-4> :echo 4<CR>
nnoremap <C-5> :echo 5<CR>
nnoremap <C-7> :echo 7<CR>

nnoremap <C-0> <C-W>:call MyWinPlace("J", g:my_winheight)<CR>
nnoremap <C-1> <C-W>:call MyWinPlace("K", g:my_winheight)<CR>
nnoremap <C-3> <C-W>:call MyWinResize(2)<CR>
nnoremap <C-7> <C-W>:call MyWinMaximizeToggle("x")<CR>
nnoremap <C-8> <C-W>:call MyWinMaximizeToggle("xy")<CR>
nnoremap <C-9> <C-W>:call MyWinMaximizeToggle("y")<CR>

tnoremap <C-0> <C-W>:call MyWinPlace("J", g:my_term_winheight)<CR>
tnoremap <C-1> <C-W>:call MyWinPlace("K", g:my_term_winheight)<CR>
tnoremap <C-3> <C-W>:call MyWinResize(2)<CR>
tnoremap <C-7> <C-W>:call MyWinMaximizeToggle("x")<CR>
tnoremap <C-8> <C-W>:call MyWinMaximizeToggle("xy")<CR>
tnoremap <C-9> <C-W>:call MyWinMaximizeToggle("y")<CR>

"------------------------------------------------------
" map.tab
"------------------------------------------------------
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

"------------------------------------------------------
" map.plugins
"------------------------------------------------------
nnoremap <C-B>   :CocListResume<CR>
nnoremap <TAB>   :MyNERDTreeToggle<CR>
nmap <BS>        <Plug>(easymotion-overwin-line)
nmap <C-U>       <Plug>(quickhl-manual-this)
xmap <C-U>       <Plug>(quickhl-manual-this)
imap <C-L>       <Plug>(coc-snippets-expand)

"------------------------------------------------------
" map.plugins.au
"------------------------------------------------------
func s:my_fugitive_settings()
  nnoremap <buffer> <C-X>   :tabclose<CR>
endfunc

func s:my_nerdtree_settings()
  nmap <buffer> <C-.>   C
  nmap <buffer> k       -
  nmap <buffer> j       +
  nmap <buffer> h       u
  nmap <buffer> l       go
  nmap <buffer> E       /r.etc<CR>
  nmap <buffer> M       /\[memo\]<CR>
  nmap <buffer> T       /\[todo\]<CR>
  nmap <buffer> D       /\[dia\]<CR>
  nmap <buffer> S       /\[scratchpad\]<CR>
  nmap <buffer> <Space> goq
  nmap <buffer> <C-J>   <C-W>w
  nmap <buffer> <C-K>   <C-W>W
endfunc

func s:my_gv_settings()
  nnoremap <buffer> <C-X>   :tabclose<CR>
endfunc

func s:my_git_settings()
  nnoremap <buffer> <C-X>   :tabclose<CR>
  nmap     <buffer> D       O
endfunc

au FileType fugitive call s:my_fugitive_settings()
au FileType nerdtree call s:my_nerdtree_settings()
au FileType GV       call s:my_gv_settings()
au FileType git      call s:my_git_settings()

"------------------------------------------------------
" diff.au
"------------------------------------------------------
func s:my_diff_settings()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc

au VimEnter,FilterWritePre * call s:my_diff_settings()

"------------------------------------------------------
