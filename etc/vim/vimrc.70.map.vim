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
"nmap    ,s      <Plug>(easymotion-overwin-f2)
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
"nnoremap <silent> <C-F>   :echo 'C-F'<CR>  " [ORIG] next page
 nnoremap <silent> <C-G>   :VisRedraw<CR>
 nnoremap <silent> <C-H>   <C-W>h
"nnoremap <silent> <C-I>   :echo 'C-I'<CR>  " [ORIG] TAB
 nnoremap <silent> <C-J>   <C-W>w
 nnoremap <silent> <C-K>   <C-W>W
 nnoremap <silent> <C-L>   <C-W>l
"nnoremap <silent> <C-M>   :echo 'C-M'<CR>  " [ORIG] CR
 nnoremap <silent> <C-N>   5<C-E>
 nnoremap <silent> <C-O>   <C-W>:silent call wbl#pop()<CR>
 nnoremap <silent> <C-P>   5<C-Y>
 nnoremap <silent> <C-Q>   @q
"nnoremap <silent> <C-R>   :echo 'C-R'<CR>  " [ORIG] redo
 nnoremap <silent> <C-S>   <Nop>
"nnoremap <silent> <C-T>   :echo 'C-T'<CR>  " [ORIG] prev tag
 nnoremap <silent> <C-U>   <C-W>:silent call wbl#open()<CR>
"nnoremap <silent> <C-V>   :echo 'C-V'<CR>  " [ORIG] block visual mode
"nnoremap <silent> <C-W>   :echo 'C-W'<CR>  " [ORIG] window command
 nnoremap <silent> <C-X>   d'm
 nnoremap <silent> <C-Y>   y'm
 nnoremap <silent> <C-Z>   :setl wrap! wrap?<CR>

 nnoremap <C-;>   <C-W>:
 nnoremap <C-.>   :VisLcdHere<CR>
 nnoremap <C-,>   :VisModifiable<CR>

"nnoremap <C-]>   g<C-]>
"nnoremap <C-]>   :<C-U>call VisTjump(expand('<cword>'), v:count)<CR>
 nnoremap <C-]>   :VisFzfTags <cfile><CR>
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
nnoremap <silent> <F10> <C-W>b
tnoremap <silent> <F10> <C-W>b
nnoremap <silent> <F5>  :VisRedraw<CR>
tnoremap <silent> <F5>  <C-L>
"------------------------------------------------------
" special keys
"------------------------------------------------------
nnoremap <silent> <BS>         <C-B>
nnoremap <silent> <C-Left>     <C-W>:tabprev<CR>
tnoremap <silent> <C-Left>     <C-W>:tabprev<CR>
nnoremap <silent> <C-Right>    <C-W>:tabnext<CR>
tnoremap <silent> <C-Right>    <C-W>:tabnext<CR>
nnoremap <silent> <C-Up>       <C-W>:call VisTabEdit()<CR>
tnoremap <silent> <C-Up>       <C-W>:call VisTabEdit()<CR>
nnoremap <silent> <C-Down>     <C-W>:VisTabClosePrev<CR>
tnoremap <silent> <C-Down>     <C-W>:VisTabClosePrev<CR>
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
