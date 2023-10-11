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

map , <Nop>

nnoremap <Space> :VisFzfBmk<CR>
nnoremap ,d      :VisFzfAll<CR>
nnoremap ,r      :VisFzfRg<CR>
nnoremap ,a      :VisFzfRgAll<CR>
nnoremap ,c      :VisFzfRgCur<CR>
nnoremap ,t      :VisFzfTags<CR>
nnoremap ,m      :VisFzfMemo<CR>
nnoremap ,h      :FzfHelptags<CR>
nnoremap ,b      :FzfBuffers<CR>
nnoremap ,,      <C-W>:silent call wbl#open()<CR>

"------------------------------------------------------
" nmap C-?
"------------------------------------------------------
"nmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
"xmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
 nmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 xmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 nnoremap <silent> <C-B>   <Nop>
 nnoremap <silent> <C-C>   <Nop>
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
 nnoremap <silent> <C-N>   5<C-E>
 nnoremap <silent> <C-O>   <C-W>:silent call wbl#pop()<CR>
 nnoremap <silent> <C-P>   5<C-Y>
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>  " [FIXED] redo
 nnoremap <silent> <C-S>   <Nop>
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>  " [FIXED] prev tag
 nnoremap <silent> <C-U>   <C-W>:silent call wbl#open()<CR>
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>  " [FIXED] block visual mode
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>  " [FIXED] window command
 nnoremap <silent> <C-X>   d'm
 nnoremap <silent> <C-Y>   y'm
 nnoremap <silent> <C-Z>   :setl wrap! wrap?<CR>

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
  vnoremap <silent> Y    y:silent '<,'>w !clip.sh<CR>
else
  nnoremap ,p      "+p
  vnoremap Y       "+y
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
" function keys
"------------------------------------------------------
nnoremap <silent> <F1>  <C-W>t
tnoremap <silent> <F1>  <C-W>t

nnoremap <silent> <F2>  <C-W>:2wincmd w<CR>
tnoremap <silent> <F2>  <C-W>:2wincmd w<CR>

nnoremap <silent> <F10> <C-W>b
tnoremap <silent> <F10> <C-W>b
"------------------------------------------------------
" special keys
"------------------------------------------------------
nnoremap <silent> <BS>         <C-B>
nmap     <silent> <C-BS>       <Plug>(easymotion-overwin-line)
"------------------------------------------------------
nnoremap <silent> <Insert>     <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <Insert>     <C-W>:call VisTabEdit()<CR>

nnoremap <silent> <Del>        <C-W>:VisTabClosePrev<CR>
tnoremap <silent> <Del>        <C-W>:VisTabClosePrev<CR>
"------------------------------------------------------
nnoremap <silent> <C-^>        <C-W>:tabprev<CR>
tnoremap <silent> <C-^>        <C-W>:tabprev<CR>

nnoremap <silent> <C-_>        <C-W>:tabnext<CR>
tnoremap <silent> <C-_>        <C-W>:tabnext<CR>
"------------------------------------------------------
nnoremap <silent> <C-Left>     <C-W>:tabprev<CR>
tnoremap <silent> <C-Left>     <C-W>:tabprev<CR>

nnoremap <silent> <C-Right>    <C-W>:tabnext<CR>
tnoremap <silent> <C-Right>    <C-W>:tabnext<CR>

nnoremap <silent> <C-Up>       <Nop>
tnoremap <silent> <C-Up>       <Nop>

nnoremap <silent> <C-Down>     <Nop>
tnoremap <silent> <C-Down>     <Nop>
"------------------------------------------------------
nnoremap <silent> <C-PageUp>   <Nop>
tnoremap <silent> <C-PageUp>   <Nop>

nnoremap <silent> <C-PageDown> <Nop>
tnoremap <silent> <C-PageDown> <Nop>
"======================================================
" nvim
"======================================================
if has('nvim')
tnoremap <C-O>   <C-\><C-N>

tnoremap <C-H>   <C-\><C-N><C-W>h
tnoremap <C-J>   <C-\><C-N><C-W>w
tnoremap <C-K>   <C-\><C-N><C-W>W
tnoremap <C-L>   <C-\><C-N><C-W>l
endif

