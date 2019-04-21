"------------------------------------------------------
" mapping
"------------------------------------------------------
" emacs-style editing in the insert mode
inoremap <C-A>   <Home>
inoremap <C-E>   <End>
inoremap <C-B>   <Left>
inoremap <C-F>   <Right>
"inoremap <C-P>   <Up>
"inoremap <C-N>   <Down>
inoremap <C-D>   <Del>

" emacs-style editing in the command mode
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
nnoremap <C-J>   2<C-E>
nnoremap <C-K>   2<C-Y>

" window
nnoremap <C-E>   :only<CR>
nnoremap <C-D>   :close<CR>

"------------------------------------------------------
" develop
"------------------------------------------------------
" tag
nnoremap <C-]>      g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>
nnoremap [I         [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[<C-I>"<CR>

" global
"nnoremap <silent> <Space>f :Gtags -f %<CR>
"nnoremap <silent> <Space>j :GtagsCursor<CR>
"nnoremap <silent> <Space>d :<C-u>exe('Gtags '.expand('<cword>'))<CR>
"nnoremap <silent> <Space>r :<C-u>exe('Gtags -r '.expand('<cword>'))<CR>

" indent between { and }
"nnoremap <Left><Left>	%ma%:.+1,'a-1<<CR>+%
"nnoremap <Right><Right>	%ma%:.+1,'a-1><CR>+%/{<CR>

"------------------------------------------------------
" misc
"------------------------------------------------------
nnoremap '     `
nnoremap Q     :confirm qall<CR>
nnoremap --    :set invnumber<CR>:set invlist<CR>
nnoremap ++    :GitGutterToggle<CR>
" fold on/off
nnoremap ==    zi

" yank a line as commands into the register q
nnoremap ,q    0"qy$
" execute commands in the register q
nnoremap q     @q

" execute commands under the cursor
nnoremap X ^y$:silent exec "<C-R>""<CR>

" man
"nnoremap M :Man <cword><CR>

"------------------------------------------------------
" visual mode mapping
"------------------------------------------------------
" add column
vnoremap A1 y:'<,'>w !sumcol 1<CR>
vnoremap A2 y:'<,'>w !sumcol 2<CR>
vnoremap A3 y:'<,'>w !sumcol 3<CR>

" calc
"vnoremap C y:!expr.sh "<C-R>""<CR>

"------------------------------------------------------
" insert mode mapping
"------------------------------------------------------
" insert date 
"inoremap <C-X>   <ESC>:r!env LC_TIME=C date '+\%Y/\%m/\%d (\%a)'<CR>kgJA
" insert time
"inoremap <C-Z>   <ESC>:r!env LC_TIME=C date '+\%R'<CR>kgJA

" expand abbr with no space
"inoremap <S-Space>	<C-]>

"------------------------------------------------------
" web
"------------------------------------------------------
" transform the following two lines to a hyper link in the markdeep format
"
" label
" http://...
"   to
" [label](http://...)
nnoremap <C-H> I[A]Jr(A)I- 

" open the current file in a web browser
nnoremap <C-Y> :silent !chrome "%"<CR>

" open a hyper link in the markdeep format by chrome
nnoremap <C-U> 0f(lyt):silent !chrome "<C-R>""<CR>

" open a hyper link in the markdeep format by w3m.vim
nnoremap <C-I> 0f(lyt):silent W3m <C-R>"<CR>

"------------------------------------------------------
" Plugin & Func key
"------------------------------------------------------
" nerd commenter
vmap C <Leader>c<Space>

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :GstatusToggle<CR>
nnoremap <F4> :Agit<CR>

" tab
nnoremap <F5> :tabclose<CR>
nnoremap <F6> :tabn<CR>

" copy to the clipboard
vnoremap <F11> "*y

" paste from the clipboard
nnoremap <F12> "*p
inoremap <F12> <ESC>"*p

" build
"nnoremap <F?> :make<CR>:cw<CR>

" save session
"nnoremap <F?> :mksession! ~/.vim/session.vim<CR>

" load session
"nnoremap <F?> :source ~/.vim/session.vim<CR>

"nnoremap <F?> :TagbarToggle<CR>

