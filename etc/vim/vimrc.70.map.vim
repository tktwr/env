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
"inoremap <C-P>   <Up>
"inoremap <C-N>   <Down>
inoremap <C-D>   <Del>

"------------------------------------------------------
" cmap
"------------------------------------------------------
" emacs-style editing in the command mode
cnoremap <C-A>   <Home>
cnoremap <C-E>   <End>
cnoremap <C-B>   <Left>
cnoremap <C-F>   <Right>
cnoremap <C-P>   <Up>
cnoremap <C-N>   <Down>
cnoremap <C-D>   <Del>

"------------------------------------------------------
" nmap
"------------------------------------------------------
" scroll
nnoremap <C-D>   <C-B>

" window
nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>j
nnoremap <C-K>   <C-W>k
nnoremap <C-L>   <C-W>l

nnoremap <C-E>   :only<CR>
nnoremap <C-X>   :close<CR>

" redraw screen
nnoremap <C-G>   :MyRedraw<CR>

" execute commands in the register q
nnoremap <C-Q>   @q

nnoremap <C-O>   :call MyOpen("")<CR>
nnoremap <C-N>   :call MyTermSendCd("")<CR>
nnoremap <C-CR>  :call MyTermSendCmd("")<CR>

"nnoremap <C-A>   NONE
"nnoremap <C-U>   NONE
"nnoremap <C-Y>   NONE

" tag
nnoremap <C-]>   g<C-]>

nnoremap '       `
nnoremap Q       :confirm qall<CR>
nnoremap --      :MyLineNumberToggle<CR>
" fold on/off
nnoremap ==      zi

"------------------------------------------------------
" map for plugins
"------------------------------------------------------

nnoremap <TAB>   :MyNERDTreeToggle<CR>
nmap <BS>        <Plug>(easymotion-overwin-line)
nmap <C-P>       <Plug>(quickhl-manual-this)
xmap <C-P>       <Plug>(quickhl-manual-this)
"nmap <C-Y>       <Plug>(quickhl-manual-reset)
"xmap <C-Y>       <Plug>(quickhl-manual-reset)
nnoremap <C-B>   :CocListResume<CR>
imap <C-L>       <Plug>(coc-snippets-expand)

"------------------------------------------------------
