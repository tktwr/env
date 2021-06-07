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

nnoremap <C-A>   :MyMakeLink<CR>
nnoremap <C-B>   :edit $MY_DOTMY_COMMON/bmk.txt<CR>
nnoremap <C-D>   <C-B>
nnoremap <C-E>   :WinBufHistClear<CR>
nnoremap <C-G>   :MyRedraw<CR>
nnoremap <C-I>   :WinBufHistPrint<CR>
nnoremap <C-N>   :cn<CR>
nnoremap <C-O>   :WinBufHistPop<CR>
nnoremap <C-P>   :cp<CR>
nnoremap <C-Q>   @q
nnoremap <C-S>   :edit $MY_DIARY/scratchpad.md.html<CR>
nmap     <C-U>   <Plug>(quickhl-manual-this-whole-word)
xmap     <C-U>   <Plug>(quickhl-manual-this-whole-word)
nnoremap <C-X>   :close<CR>
nnoremap <C-Y>   :call MyIDESendCdE2T()<CR>

nnoremap <TAB>   :MyNERDTreeToggle<CR>
nnoremap <BS>    :MyTagbarToggle<CR>
nnoremap <CR>    :call BmkKeyCRThis()<CR>

nnoremap <C-CR>  :call BmkOpenThis()<CR>
nnoremap <S-CR>  :MyNERDTreeOpen<CR>

nnoremap <C-;>   <C-W>:
nnoremap <C-.>   :MyLcdHere<CR>
nnoremap <C-]>   g<C-]>

"nnoremap <C-TAB> :echo "C-TAB"<CR>
"nnoremap <C-BS>  :echo "C-BS"<CR>
"nnoremap <C-CR>  :echo "C-CR"<CR>

"nnoremap <S-TAB> :echo "S-TAB"<CR>
"nnoremap <S-BS>  :echo "S-BS"<CR>
"nnoremap <S-CR>  :echo "S-CR"<CR>

"------------------------------------------------------
" tmap
"------------------------------------------------------
tnoremap <C-G>   <C-L>
tnoremap <C-I>   <C-W>:MyWinInitSize<CR>
" go to Terminal-Normal
tnoremap <C-O>   <C-W>N
" paste register
tnoremap <C-V>   <C-W>""

tnoremap <C-;>   <C-W>:

tnoremap <ScrollWheelUp> <C-W>N<ScrollWheelUp>

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
" map.window
"------------------------------------------------------
nnoremap <silent> <C-1> <C-W>:silent call BmkSide(1)<CR>
nnoremap <silent> <C-2> <C-W>:silent call BmkSide(2)<CR>
nnoremap <silent> <C-@> <C-W>:silent call BmkSide(2)<CR>
nnoremap <silent> <C-3> <C-W>:silent call BmkSide(3)<CR>
nnoremap <silent> <C-4> <C-W>:silent call BmkSide(4)<CR>
nnoremap <silent> <C-5> <C-W>:silent call BmkSide(5)<CR>
nnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
nnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
nnoremap <silent> <C-7> <C-W>:silent call MyWinMaximizeXToggle(g:my_winwidth_max)<CR>
nnoremap <silent> <C-8> <C-W>:silent call MyWinMaximizeXYToggle(g:my_winwidth_max, "")<CR>
nnoremap <silent> <C-9> <C-W>:silent call MyWinMaximizeYToggle("")<CR>
nnoremap <silent> <C-0> <C-W>t

tnoremap <silent> <C-1> <C-W>:silent call BmkSide(1)<CR>
tnoremap <silent> <C-2> <C-W>:silent call BmkSide(2)<CR>
tnoremap <silent> <C-@> <C-W>:silent call BmkSide(2)<CR>
tnoremap <silent> <C-3> <C-W>:silent call BmkSide(3)<CR>
tnoremap <silent> <C-4> <C-W>:silent call BmkSide(4)<CR>
tnoremap <silent> <C-5> <C-W>:silent call BmkSide(5)<CR>
tnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
tnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
tnoremap <silent> <C-7> <C-W>:silent call MyWinMaximizeXToggle(g:my_winwidth_max)<CR>
tnoremap <silent> <C-8> <C-W>:silent call MyWinMaximizeXYToggle(g:my_winwidth_max, g:my_term_winheight_max)<CR>
tnoremap <silent> <C-9> <C-W>:silent call MyWinMaximizeYToggle(g:my_term_winheight_max)<CR>
tnoremap <silent> <C-0> <C-W>t

"------------------------------------------------------
" map.tab
"------------------------------------------------------
nnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
nnoremap <silent> <PageDown> <C-W>:tabnext<CR>
nnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
nnoremap <silent> <C-Down>   <C-W>:MyTerm<CR>
nnoremap <silent> <Insert>   <C-W>:tabedit<CR>
nnoremap <silent> <Del>      <C-W>:MyTabClosePrev<CR>

tnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
tnoremap <silent> <PageDown> <C-W>:tabnext<CR>
tnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
tnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
tnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
tnoremap <silent> <C-Down>   <C-W>:MyTerm<CR>
tnoremap <silent> <Insert>   <C-W>:tabedit<CR>
tnoremap <silent> <Del>      <C-W>:MyTabClosePrev<CR>

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
  nmap <buffer> 2       :call MyNERDTreeEdit(2)<CR>
  nmap <buffer> 3       :call MyNERDTreeEdit(3)<CR>
  nmap <buffer> 4       :call MyNERDTreeEdit(4)<CR>
  nmap <buffer> 5       :call MyNERDTreeEdit(5)<CR>
  nmap <buffer> 6       :call MyNERDTreeEdit(6)<CR>
  nmap <buffer> 7       :call MyNERDTreeEdit(7)<CR>
  nmap <buffer> 8       :call MyNERDTreeEdit(8)<CR>
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
