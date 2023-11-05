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

nnoremap <Space> :VisFzfBmk<CR>
nnoremap ,d      :VisFzfAll<CR>
nnoremap ,r      :VisFzfRg<CR>
nnoremap ,t      :VisFzfTags <cfile><CR>
nnoremap ,m      :VisFzfMemo<CR>
nnoremap ,h      :FzfHelptags<CR>
nnoremap ,b      :FzfBuffers<CR>
"------------------------------------------------------
" nmap C-?
"------------------------------------------------------
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>  " [ORIG] window command
 nnoremap <silent> <C-E>   :close<CR>
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>  " [ORIG] redo
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>  " [ORIG] prev tag

"nmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
"xmap     <silent> <C-A>   <Plug>(quickhl-manual-this-whole-word)
 nmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 xmap     <silent> <C-A>   <Plug>(quickhl-manual-this)
 nnoremap <silent> <C-S>   :VisFzfRg <cword><CR>
 nnoremap <silent> <C-D>   <C-B>
"nnoremap <silent> <C-F>   :echo 'C-F'<CR>  " [ORIG] next page
 nnoremap <silent> <C-G>   :VisRedraw<CR>

 nnoremap <silent> <C-Z>   :setl wrap! wrap?<CR>
 nnoremap <silent> <C-X>   d'm
 nmap     <silent> <C-C>   <Plug>(easymotion-overwin-f2)
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>  " [ORIG] block visual mode
 nnoremap <silent> <C-B>   :VisFzfRg <cfile><CR>
"------------------------------------------------------
 nnoremap <silent> <C-Y>   y'm
 nnoremap <silent> <C-U>   <C-W>:silent call wbl#open()<CR>
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

"nnoremap <silent> <C-]>   g<C-]>
"nnoremap <silent> <C-]>   :<C-U>call VisTjump(expand('<cword>'), v:count)<CR>
 nnoremap <silent> <C-]>   :VisFzfTags <cfile><CR>
"------------------------------------------------------
" tmap
"------------------------------------------------------
 tnoremap <silent> <C-S>   <BS>
 tnoremap <silent> <C-G>   <C-L>
" go to Terminal-Normal
 tnoremap <silent> <C-O>   <C-W>N
" paste register
 tnoremap <silent> <C-V>   <C-W>""
 tnoremap <silent> <C-;>   <C-W>:

func s:term_map()
  if &filetype == ''
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
" function keys
"------------------------------------------------------
nnoremap <silent> <F1>  <C-W>t
tnoremap <silent> <F1>  <C-W>t
nnoremap <silent> <F2>  <C-W>:2wincmd w<CR>
tnoremap <silent> <F2>  <C-W>:2wincmd w<CR>
nnoremap <silent> <F5>  :VisRedraw<CR>
tnoremap <silent> <F5>  <C-L>
nnoremap <silent> <F10> <C-W>b
tnoremap <silent> <F10> <C-W>b

nnoremap <silent> <C-F1>  <Nop>
tnoremap <silent> <C-F1>  <Nop>
nnoremap <silent> <C-F2>  <Nop>
tnoremap <silent> <C-F2>  <Nop>
nnoremap <silent> <C-F3>  <Nop>
tnoremap <silent> <C-F3>  <Nop>
nnoremap <silent> <C-F4>  <Nop>
tnoremap <silent> <C-F4>  <Nop>
nnoremap <silent> <C-F5>  <Nop>
tnoremap <silent> <C-F5>  <Nop>
nnoremap <silent> <C-F6>  <C-W>:tabprev<CR>
tnoremap <silent> <C-F6>  <C-W>:tabprev<CR>
nnoremap <silent> <C-F7>  <C-W>:tabnext<CR>
tnoremap <silent> <C-F7>  <C-W>:tabnext<CR>
nnoremap <silent> <C-F8>  <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <C-F8>  <C-W>:call VisTabEdit()<CR>
nnoremap <silent> <C-F9>  <C-W>:VisTabClosePrev<CR>
tnoremap <silent> <C-F9>  <C-W>:VisTabClosePrev<CR>
nnoremap <silent> <C-F10> <Nop>
tnoremap <silent> <C-F10> <Nop>
"------------------------------------------------------
" special keys
"------------------------------------------------------
nnoremap <silent> <C-Left>     <C-W>h
tnoremap <silent> <C-Left>     <C-W>h
nnoremap <silent> <C-Right>    <C-W>l
tnoremap <silent> <C-Right>    <C-W>l
nnoremap <silent> <C-Up>       <C-W>W
tnoremap <silent> <C-Up>       <C-W>W
nnoremap <silent> <C-Down>     <C-W>w
tnoremap <silent> <C-Down>     <C-W>w
nnoremap <silent> <C-Home>     <C-W>:tabprev<CR>
tnoremap <silent> <C-Home>     <C-W>:tabprev<CR>
nnoremap <silent> <C-End>      <C-W>:tabnext<CR>
tnoremap <silent> <C-End>      <C-W>:tabnext<CR>
nnoremap <silent> <C-PageUp>   <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <C-PageUp>   <C-W>:call VisTabEdit()<CR>
nnoremap <silent> <C-PageDown> <C-W>:VisTabClosePrev<CR>
tnoremap <silent> <C-PageDown> <C-W>:VisTabClosePrev<CR>
nnoremap <silent> <C-Insert>   <Nop>
tnoremap <silent> <C-Insert>   <Nop>
nnoremap <silent> <C-Del>      <Nop>
tnoremap <silent> <C-Del>      <Nop>

nnoremap <silent> <S-PageUp>   5<C-Y>
nnoremap <silent> <S-PageDown> 5<C-E>
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
