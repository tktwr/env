"======================================================
" map
"======================================================
"------------------------------------------------------
" imap
"------------------------------------------------------
" emacs-style editing in the insert mode
inoremap <C-A>   <Home>
inoremap <C-E>   <End>
inoremap <C-B>   <Left>
inoremap <C-F>   <Right>
inoremap <C-S>   <BS>
inoremap <C-D>   <Del>
"inoremap <C-N>   <Down>
"inoremap <C-P>   <Up>
"------------------------------------------------------
" cmap
"------------------------------------------------------
" emacs-style editing in the command mode
cnoremap <C-A>   <Home>
cnoremap <C-E>   <End>
cnoremap <C-B>   <Left>
cnoremap <C-F>   <Right>
cnoremap <C-S>   <BS>
cnoremap <C-D>   <Del>
cnoremap <C-N>   <Down>
cnoremap <C-P>   <Up>
"------------------------------------------------------
" nmap
"------------------------------------------------------
nnoremap Q       :confirm qall<CR>

" mark
nnoremap '       `

" fold on/off
nnoremap ==      zi

map , <Nop>

vnoremap <Space> y:VisFzfBmk<CR>
nnoremap <Space> :VisFzfBmk<CR>
nnoremap ,,      :VisFzfWinbuf<CR>
nnoremap ,b      :FzfBuffers<CR>
nnoremap ,f      :VisFzfFd<CR>
nnoremap ,r      :VisFzfRg<CR>
nnoremap ,t      :VisFzfTags<CR>

nmap ,s          <Plug>(easymotion-overwin-f2)
nmap ,j          <Plug>(easymotion-j)
vmap ,j          <Plug>(easymotion-j)
nmap ,k          <Plug>(easymotion-k)
vmap ,k          <Plug>(easymotion-k)
"------------------------------------------------------
" nmap C-?
"------------------------------------------------------
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>  " [ORIG] window command
 nnoremap <silent> <C-E>   :close<CR>
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>  " [ORIG] redo
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>  " [ORIG] prev tag

 nnoremap <silent> <C-A>   :VisFzfRg <cfile><CR>
 nnoremap <silent> <C-S>   :VisFzfRg <cword><CR>
 nnoremap <silent> <C-D>   <C-B>
"nnoremap <silent> <C-F>   :echo 'C-F'<CR>  " [ORIG] next page
 nnoremap <silent> <C-G>   :VisRedraw<CR>

 nnoremap <silent> <C-Z>   :setl wrap! wrap?<CR>
 nnoremap <silent> <C-X>   d'm
 nnoremap <silent> <C-C>   y'm
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>  " [ORIG] block visual mode
 nmap     <silent> <C-B>   <Plug>(easymotion-overwin-f2)
"------------------------------------------------------
 nnoremap <silent> <C-Y>   :VisWinMaximizeXToggle<CR>
 nmap     <silent> <C-U>   <Plug>(quickhl-manual-this)
 xmap     <silent> <C-U>   <Plug>(quickhl-manual-this)
"nnoremap <silent> <C-I>   :echo 'C-I'<CR>  " [ORIG] TAB
 nnoremap <silent> <C-O>   <C-W>:silent call wbl#pop()<CR>
 nnoremap <silent> <C-P>   5<C-Y>

 nnoremap <silent> <C-H>   <C-W>h
 nnoremap <silent> <C-J>   <C-W>w
 nnoremap <silent> <C-K>   <C-W>W
 nnoremap <silent> <C-L>   <C-W>l
 nnoremap <silent> <C-;>   <C-W>:

 nnoremap <silent> <C-N>   5<C-E>
"nnoremap <silent> <C-M>   :echo 'C-M'<CR>  " [ORIG] CR
 nnoremap <silent> <C-,>   :VisModifiable<CR>
 nnoremap <silent> <C-.>   :VisLcdHere<CR>
"nnoremap <silent> <C-/>   <Nop>

 nnoremap <silent> <C-]>   g<C-]>
"nnoremap <silent> <C-]>   :<C-U>call VisTjump(expand('<cword>'), v:count)<CR>
"nnoremap <silent> <C-]>   :VisFzfTags <cword><CR>
"------------------------------------------------------
" tmap
"------------------------------------------------------
 tnoremap <silent> <C-Q>   <C-W>:VisWinMaximizeYToggleTerm<CR>
 tnoremap <silent> <C-Y>   <C-W>:VisWinMaximizeXToggleTerm<CR>
 tnoremap <silent> <C-S>   <BS>
 tnoremap <silent> <C-G>   <C-L>
" go to Terminal-Normal
 tnoremap <silent> <C-O>   <C-W>N
" paste register
 tnoremap <silent> <C-V>   <C-W>""
 tnoremap <silent> <C-;>   <C-W>:

func s:term_map()
  if &filetype != ''
    return
  endif
  if has('nvim')
    tnoremap <buffer> <C-O>   <C-\><C-N>
    tnoremap <buffer> <C-H>   <C-\><C-N><C-W>h
    tnoremap <buffer> <C-J>   <C-\><C-N><C-W>w
    tnoremap <buffer> <C-K>   <C-\><C-N><C-W>W
    tnoremap <buffer> <C-L>   <C-\><C-N><C-W>l
  else
    tnoremap <buffer> <C-ScrollWheelUp>  <C-W>N<ScrollWheelUp>
    tnoremap <buffer> <C-H>   <C-W>h
    tnoremap <buffer> <C-J>   <C-W>w
    tnoremap <buffer> <C-K>   <C-W>W
    tnoremap <buffer> <C-L>   <C-W>l
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

vnoremap A       y:'<,'>w !sumcol.py<CR>

func R_SumCol(col=2, sep='|')
  echom printf("R_SumCol: col=%d sep=%s", a:col, a:sep)
  echom system(printf("sumcol.py -c %d -s '%s'", a:col, a:sep), @")
endfunc

"------------------------------------------------------
" clipboard
"------------------------------------------------------
func YankUrlToClipboard()
  let url = expand(expand("<cfile>"))
  call setreg('+', url)
  echo url
endfunc

if has('clipboard')
  nnoremap ,p      "+p
  vnoremap Y       "+y
  nnoremap Y       :call YankUrlToClipboard()<CR>
else
  nnoremap ,p            :r !paste.sh<CR>
  vnoremap <silent> Y    y:silent '<,'>w !clip.sh<CR>
endif
"------------------------------------------------------
" function keys
"------------------------------------------------------
nnoremap <silent> <F1>  <C-W>t
nnoremap <silent> <F2>  <C-W>:2wincmd w<CR>
nnoremap <silent> <F5>  :VisRedraw<CR>
nnoremap <silent> <F10> <C-W>b

tnoremap <silent> <F1>  <C-W>t
tnoremap <silent> <F2>  <C-W>:2wincmd w<CR>
tnoremap <silent> <F5>  <C-L>
tnoremap <silent> <F10> <C-W>b
"------------------------------------------------------
" special keys
"------------------------------------------------------
nnoremap <silent> <C-Left>     <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>    <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>       <C-W>:call VisTabEdit()<CR>
nnoremap <silent> <C-Down>     <C-W>:VisTabClosePrev<CR>
nnoremap <silent> <C-Home>     <C-W>:tabedit %<CR>
nnoremap <silent> <C-End>      <C-W>:split .<CR>
nnoremap <silent> <C-PageUp>   <C-W>:tabmove -<CR>
nnoremap <silent> <C-PageDown> <C-W>:tabmove +<CR>
nnoremap <silent> <C-Insert>   <Nop>
nnoremap <silent> <C-Del>      <Nop>

tnoremap <silent> <C-Left>     <C-W>:tabprev<CR>
tnoremap <silent> <C-Right>    <C-W>:tabnext<CR>
tnoremap <silent> <C-Up>       <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <C-Down>     <C-W>:VisTabClosePrev<CR>
tnoremap <silent> <C-Home>     <Nop>
tnoremap <silent> <C-End>      <Nop>
tnoremap <silent> <C-PageUp>   <C-W>:tabmove -<CR>
tnoremap <silent> <C-PageDown> <C-W>:tabmove +<CR>
tnoremap <silent> <C-Insert>   <Nop>
tnoremap <silent> <C-Del>      <Nop>

nnoremap <silent> <S-PageUp>   5<C-Y>
nnoremap <silent> <S-PageDown> 5<C-E>
