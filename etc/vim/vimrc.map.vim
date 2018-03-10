"--------------------------------------------------------------------------
" mapping
"--------------------------------------------------------------------------
" emacs-style editing
inoremap <C-A>   <Home>
inoremap <C-E>   <End>
inoremap <C-B>   <Left>
inoremap <C-F>   <Right>
inoremap <C-D>   <Del>

cnoremap <C-A>   <Home>
cnoremap <C-E>   <End>
cnoremap <C-B>   <Left>
cnoremap <C-F>   <Right>
cnoremap <C-P>   <Up>
cnoremap <C-N>   <Down>
cnoremap <C-D>   <Del>

" scroll
nnoremap <Space> <C-F>
nnoremap <BS>    <C-B>
nnoremap <C-K>   <C-Y>
nnoremap <C-J>   <C-E>

" window
nnoremap <C-E>   :only<CR>
nnoremap <C-D>   :close<CR>

" tag
nnoremap <C-]>      g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>
nnoremap [I         [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[<C-I>"<CR>

"--------------------------------------------------------------------------
" misc
"--------------------------------------------------------------------------
nnoremap '     `
nnoremap Q     :confirm qall<CR>
nnoremap --    :set invnumber<CR>:set invlist<CR>
" fold on/off
nnoremap == zi

" yank a line as commands into the register q
nnoremap ,q    0"qy$
" execute commands in the register q
nnoremap q     @q

" execute commands under the cursor
nnoremap X ^y$:silent exec "<C-R>""<CR>

"--------------------------------------------------------------------------
" lookup
"--------------------------------------------------------------------------
" man
nnoremap M :Man <cword><CR>

" lookup
nnoremap K  :call Lookup("translate :ja -b", "", expand("<cword>"))<CR>
nnoremap Y  :call Lookup("translate :en -b", "", expand("<cword>"))<CR>
nnoremap S  :call Lookup("translate :zh -b", "", expand("<cword>"))<CR>
vnoremap K y:call Lookup("translate :ja -b", "", "<C-R>"")<CR>
vnoremap Y y:call Lookup("translate :en -b", "", "<C-R>"")<CR>
vnoremap S y:call Lookup("translate :zh -b", "", "<C-R>"")<CR>

"--------------------------------------------------------------------------
" misc
"--------------------------------------------------------------------------
" add column
vnoremap A1 y:'<,'>w !sumcol 1<CR>
vnoremap A2 y:'<,'>w !sumcol 2<CR>
vnoremap A3 y:'<,'>w !sumcol 3<CR>

" calc
vnoremap C y:!expr.sh "<C-R>""<CR>

" expand abbr with no space
"inoremap <S-Space>	<C-]>

" indent between { and }
"nnoremap <Left><Left>	%ma%:.+1,'a-1<<CR>+%
"nnoremap <Right><Right>	%ma%:.+1,'a-1><CR>+%/{<CR>

"--------------------------------------------------------------------------
" Func key
"--------------------------------------------------------------------------

" copy to the clipboard
vnoremap <F11> "*y

" paste from the clipboard
nnoremap <F12> "*p
inoremap <F12> <ESC>"*p

" hyper link
nnoremap <F4> y$:silent !firefox-remote "<C-R>""<CR>

" build
nnoremap <F5> :make<CR>:cw<CR>

nnoremap <F6> :Grep <cword> *.h *.cxx *.cpp<CR>

nnoremap <F7> 0y$:InsertDate "<C-R>""<CR>kdd

" bookmarks
"nnoremap <F8> :sp $MEMO_DIR/bookmark.txt<CR>

" save session
"nnoremap <F11> :mksession! ~/.vim/session.vim<CR>

" load session
"nnoremap <F12> :source ~/.vim/session.vim<CR>


" insert date 
inoremap <C-X>   <ESC>:r!env LC_TIME=C date '+\%Y/\%m/\%d (\%a)'<CR>kgJA
" insert time
inoremap <C-Z>   <ESC>:r!env LC_TIME=C date '+\%R'<CR>kgJA

"nnoremap <C-X> :call <SID>LastModification()<CR>
nnoremap <C-X> I[A]Jr(A)I- 

