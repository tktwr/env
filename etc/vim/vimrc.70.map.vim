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
nnoremap Q       :confirm qall<CR>

" mark
nnoremap '       `

" fold on/off
nnoremap ==      zi

"------------------------------------------------------
" nmap C-?
"------------------------------------------------------
"nmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
"xmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
 nmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 xmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 nnoremap <silent> <C-B>   :echo<CR>
 nnoremap <silent> <C-C>   :echo<CR>
 nnoremap <silent> <C-D>   <C-B>
 nnoremap <silent> <C-E>   :close<CR>
"nnoremap <silent> <C-F>   :echo 'C-F'<CR>  " [FIXED] next page
 nnoremap <silent> <C-G>   :VisRedraw<CR>
"nnoremap <silent> <C-H>   :echo 'C-H'<CR>  " [FIXED] left win
"nnoremap <silent> <C-I>   :echo 'C-I'<CR>  " [FIXED] TAB
"nnoremap <silent> <C-J>   :echo 'C-J'<CR>  " [FIXED] next win
"nnoremap <silent> <C-K>   :echo 'C-K'<CR>  " [FIXED] prev win
"nnoremap <silent> <C-L>   :echo 'C-L'<CR>  " [FIXED] right win
"nnoremap <silent> <C-M>   :echo 'C-M'<CR>  " [FIXED] CR
 nnoremap <silent> <C-N>   :cn<CR>
 nnoremap <silent> <C-O>   <C-W>:silent call wbl#pop()<CR>
 nnoremap <silent> <C-P>   :cp<CR>
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>  " [FIXED] redo
 nnoremap <silent> <C-S>   :echo<CR>
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>  " [FIXED] prev tag
 nnoremap <silent> <C-U>   <C-W>:silent call wbl#open()<CR>
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>  " [FIXED] block visual mode
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>  " [FIXED] window command
 nnoremap <silent> <C-X>   d'm
 nnoremap <silent> <C-Y>   y'm
 nnoremap <silent> <C-Z>   :echo<CR>

 nnoremap <C-;>   <C-W>:
 nnoremap <C-.>   :VisLcdHere<CR>
 nnoremap <C-,>   :VisModifiable<CR>

"nnoremap <C-]>   g<C-]>
"nnoremap <C-]>   :<C-U>call VisTjump(expand('<cword>'), v:count)<CR>
 nnoremap <C-]>   :VisFzfTags<CR>

"------------------------------------------------------
" tmap
"------------------------------------------------------
 tnoremap <silent> <C-G>   <C-L>
" go to Terminal-Normal
 tnoremap <silent> <C-O>   <C-W>N
" paste register
 tnoremap <silent> <C-V>   <C-W>""
 tnoremap <silent> <C-;>   <C-W>:

func s:term_map()
  if &filetype == ''
    tnoremap <buffer> <C-ScrollWheelUp>  <C-W>N<ScrollWheelUp>
  endif
endfunc

augroup ag_my
  autocmd!
  if has('nvim')
    autocmd TermOpen      *               call s:term_map()
  else
    autocmd TerminalOpen  *               call s:term_map()
  endif
augroup END

"------------------------------------------------------
" vmap
"------------------------------------------------------
"vmap C  <Plug>NERDCommenterToggle
 vmap C  gc

"------------------------------------------------------
" standard input
"------------------------------------------------------
vnoremap A       y:'<,'>w !sumcol.py<CR>

"------------------------------------------------------
" clipboard
"------------------------------------------------------
func YankUrlToClipboard()
  let url = expand(expand("<cfile>"))
  call setreg('*', url)
  echo url
endfunc

if IsWsl()
  "nnoremap ,p            "+p
  nnoremap ,p            :r !paste.sh<CR>
  vnoremap <silent> Y    y:silent '<,'>w !clip.exe<CR>
else
  nnoremap ,p      "*p
  vnoremap Y       "*y
  nnoremap Y       :call YankUrlToClipboard()<CR>
endif

"------------------------------------------------------
" map: window
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
" C-Number
"------------------------------------------------------
nnoremap <silent> <C-1> <C-W>t
nnoremap <silent> <C-2> <C-W>:2wincmd w<CR>
nnoremap <silent> <C-@> <C-W>:2wincmd w<CR>
nnoremap <silent> <C-3> <C-W>:echo 'C-3'<CR>
nnoremap <silent> <C-4> <C-W>:echo 'C-4'<CR>
nnoremap <silent> <C-5> <C-W>:echo 'C-5'<CR>
nnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
nnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
nnoremap <silent> <C-7> <C-W>:silent call VisWinMaximizeXToggle(g:my_winwidth_max)<CR>
nnoremap <silent> <C-8> <C-W>:silent call VisWinMaximizeXYToggle(g:my_winwidth_max, "")<CR>
nnoremap <silent> <C-9> <C-W>:silent call VisWinMaximizeYToggle("")<CR>
nnoremap <silent> <C-0> <C-W>b

tnoremap <silent> <C-1> <C-W>t
tnoremap <silent> <C-2> <C-W>:2wincmd w<CR>
tnoremap <silent> <C-@> <C-W>:2wincmd w<CR>
tnoremap <silent> <C-3> <C-W>:echo 'C-3'<CR>
tnoremap <silent> <C-4> <C-W>:echo 'C-4'<CR>
tnoremap <silent> <C-5> <C-W>:echo 'C-5'<CR>
tnoremap <silent> <C-6> <C-W>:echo 'C-6'<CR>
tnoremap <silent> <C-^> <C-W>:echo 'C-^'<CR>
tnoremap <silent> <C-7> <C-W>:silent call VisWinMaximizeXToggle(g:my_winwidth_max)<CR>
tnoremap <silent> <C-8> <C-W>:silent call VisWinMaximizeXYToggle(g:my_winwidth_max, g:my_term_winheight_max)<CR>
tnoremap <silent> <C-9> <C-W>:silent call VisWinMaximizeYToggle(g:my_term_winheight_max)<CR>
tnoremap <silent> <C-0> <C-W>b

"------------------------------------------------------
" special keys
"------------------------------------------------------
nnoremap <silent> <F1>       <C-W>:FzfHelptags<CR>

nnoremap <silent> <Space>    <C-W>:CpmOpen<CR>
nnoremap <silent> <C-Space>  <C-W>:CpmOpen coc<CR>
tnoremap <silent> <C-Space>  <C-W>:CpmOpen<CR>

nnoremap <silent> <End>      <C-W>:silent call wbl#open()<CR>
tnoremap <silent> <End>      <C-W>:silent call wbl#open()<CR>

nnoremap <silent> <BS>       <C-B>
nmap     <silent> <C-BS>     <Plug>(easymotion-overwin-line)

nnoremap <silent> <C-CR>     :call bmk#ViewThis()<CR>
nnoremap <silent> <S-CR>     :call bmk#OpenThis()<CR>
"------------------------------------------------------
nnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
nnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>

tnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
tnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>

tnoremap <silent> <PageDown> <C-W>:silent call VisWinMaximizeYToggle(g:my_term_winheight_max)<CR>
"------------------------------------------------------
nnoremap <silent> <Insert>   <C-W>:call VisTabEdit()<CR>
nnoremap <silent> <Del>      <C-W>:VisTabClosePrev<CR>

tnoremap <silent> <Insert>   <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <Del>      <C-W>:VisTabClosePrev<CR>
"------------------------------------------------------
nnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
nnoremap <silent> <C-Down>   <C-W>:below VisTerm<CR>

tnoremap <silent> <C-Left>   <C-W>:tabprev<CR>
tnoremap <silent> <C-Right>  <C-W>:tabnext<CR>
tnoremap <silent> <C-Up>     <C-W>:tabedit<CR>
tnoremap <silent> <C-Down>   <C-W>:below VisTerm<CR>

"======================================================
" nvim
"======================================================
if has('nvim')
tnoremap <C-O>   <C-\><C-N>

tnoremap <C-H>   <C-\><C-N><C-W>h
tnoremap <C-J>   <C-\><C-N><C-W>w
tnoremap <C-K>   <C-\><C-N><C-W>W
tnoremap <C-L>   <C-\><C-N><C-W>l

tnoremap <silent> <C-Space>  <C-\><C-N>:CpmOpen<CR>
tnoremap <silent> <PageDown> <C-\><C-N>:silent call VisWinMaximizeYToggle(g:my_term_winheight_max)<CR>i
endif

