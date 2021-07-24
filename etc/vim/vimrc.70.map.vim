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

 nmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
 xmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
 nnoremap <silent> <C-B>   :edit $MY_DOTMY_COMMON/bmk.txt<CR>
"nnoremap <silent> <C-C>   :echo 'C-C'<CR>
 nnoremap <silent> <C-D>   <C-B>
 nnoremap <silent> <C-E>   :MyGitLog<CR>
"nnoremap <silent> <C-F>   :echo 'C-F'<CR>
 nnoremap <silent> <C-G>   :MyRedraw<CR>
"nnoremap <silent> <C-H>   :echo 'C-H'<CR>
 nnoremap <silent> <C-I>   :silent WinBufHistPrint<CR>
"nnoremap <silent> <C-J>   :echo 'C-J'<CR>
"nnoremap <silent> <C-K>   :echo 'C-K'<CR>
"nnoremap <silent> <C-L>   :echo 'C-L'<CR>
"nnoremap <silent> <C-M>   :echo 'C-M'<CR>
 nnoremap <silent> <C-N>   :cn<CR>
 nnoremap <silent> <C-O>   :silent WinBufHistPop<CR>
 nnoremap <silent> <C-P>   :cp<CR>
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>
 nnoremap <silent> <C-S>   :call MyIDESendCdE2T("")<CR>
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>
 nnoremap <silent> <C-U>   :silent WinBufHistNext<CR>
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>
 nnoremap <silent> <C-X>   :close<CR>
 nnoremap <silent> <C-Y>   :silent WinBufHistPrev<CR>
"nnoremap <silent> <C-Z>   :echo 'C-Z'<CR>

nnoremap <TAB>   :MyFernToggle<CR>
"nnoremap <TAB>   :MyNERDTreeToggle<CR>
"nnoremap <BS>    <C-B>
"nnoremap <CR>    <C-F>

nnoremap <C-CR>  :call BmkOpenThis()<CR>
nnoremap <S-CR>  :call BmkViewThis()<CR>

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
" vmap
"------------------------------------------------------
vmap C  <Plug>NERDCommenterToggle

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
" clipboard
"------------------------------------------------------
"nnoremap P       "*p
vnoremap Y       "*y

"------------------------------------------------------
" popup menu
"------------------------------------------------------
nnoremap <Space>   :call MyMenuPopupMenu(0)<CR>
vnoremap <Space>   :'<,'>MyTestRange<CR>

tnoremap <C-Space> <C-W>:call MyMenuPopupMenu(0)<CR>

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
nnoremap <silent> <C-1> <C-W>t
nnoremap <silent> <C-2> <C-W>:call MyMenuPopupMenu(2)<CR>
nnoremap <silent> <C-@> <C-W>:call MyMenuPopupMenu(2)<CR>
nnoremap <silent> <C-3> <C-W>:call MyMenuPopupMenu(0)<CR>
nnoremap <silent> <C-4> <C-W>:call MyMenuPopupMenu(1)<CR>
nnoremap <silent> <C-5> <C-W>:echo 'C-5'<CR>
nnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
nnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
nnoremap <silent> <C-7> <C-W>:silent call MyWinMaximizeXToggle(g:my_winwidth_max)<CR>
nnoremap <silent> <C-8> <C-W>:silent call MyWinMaximizeXYToggle(g:my_winwidth_max, "")<CR>
nnoremap <silent> <C-9> <C-W>:silent call MyWinMaximizeYToggle("")<CR>
nnoremap <silent> <C-0> <C-W>b

tnoremap <silent> <C-1> <C-W>t
tnoremap <silent> <C-2> <C-W>:call MyMenuPopupMenu(2)<CR>
tnoremap <silent> <C-@> <C-W>:call MyMenuPopupMenu(2)<CR>
tnoremap <silent> <C-3> <C-W>:call MyMenuPopupMenu(0)<CR>
tnoremap <silent> <C-4> <C-W>:call MyMenuPopupMenu(1)<CR>
tnoremap <silent> <C-5> <C-W>:echo 'C-5'<CR>
tnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
tnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
tnoremap <silent> <C-7> <C-W>:silent call MyWinMaximizeXToggle(g:my_winwidth_max)<CR>
tnoremap <silent> <C-8> <C-W>:silent call MyWinMaximizeXYToggle(g:my_winwidth_max, g:my_term_winheight_max)<CR>
tnoremap <silent> <C-9> <C-W>:silent call MyWinMaximizeYToggle(g:my_term_winheight_max)<CR>
tnoremap <silent> <C-0> <C-W>b

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
func s:my_map_win()
  if &diff == 1
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
  else
    nnoremap <buffer> <C-P>   :cp<CR>
    nnoremap <buffer> <C-N>   :cn<CR>
  endif
endfunc

augroup ag-my
  autocmd!
  autocmd WinEnter *        call s:my_map_win()
augroup END

