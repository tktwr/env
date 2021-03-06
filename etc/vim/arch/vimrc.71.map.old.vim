" scroll
"nnoremap <Space> <C-F>
"nnoremap <BS>    <C-B>
"nnoremap <C-J>   2<C-E>
"nnoremap <C-K>   2<C-Y>

"nnoremap <C-W><C-]> <C-W>g<C-]>
"nnoremap [I         [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[<C-I>"<CR>

" indent between { and }
"nnoremap <Left><Left>	%ma%:.+1,'a-1<<CR>+%
"nnoremap <Right><Right>	%ma%:.+1,'a-1><CR>+%/{<CR>

" yank a line as commands into the register q
"nnoremap ,q    0"qy$
" execute commands in the register q
"nnoremap q     @q

" execute commands under the cursor
"nnoremap X ^y$:silent exec "<C-R>""<CR>

" man
"nnoremap M :Man <cword><CR>

"------------------------------------------------------
" map: visual mode mapping
"------------------------------------------------------
" add column
"vnoremap A1 y:'<,'>w !sumcol 1<CR>
"vnoremap A2 y:'<,'>w !sumcol 2<CR>
"vnoremap A3 y:'<,'>w !sumcol 3<CR>

" calc
"vnoremap C y:!expr.sh "<C-R>""<CR>

"------------------------------------------------------
" map: insert mode mapping
"------------------------------------------------------
" insert date 
"inoremap <C-X>   <ESC>:r!env LC_TIME=C date '+\%Y/\%m/\%d (\%a)'<CR>kgJA
" insert time
"inoremap <C-Z>   <ESC>:r!env LC_TIME=C date '+\%R'<CR>kgJA

" expand abbr with no space
"inoremap <S-Space>	<C-]>

"------------------------------------------------------
" map: web
"------------------------------------------------------
" transform the following two lines to a hyper link in the markdeep format
"
" label
" http://...
"   to
" [label](http://...)
"nnoremap <C-A> I[A]Jr(A)I- 
"nnoremap <C-A> :MyMakeLink<CR>

" open an URL in the markdeep format by chrome
"nnoremap <C-O> 0f(lyt):silent !chrome.sh "<C-R>""<CR>

" open an URL under the cursor
"nnoremap <C-O> :!chrome.sh <cfile><CR>
"nnoremap <C-O> :OpenURL <cfile><CR>

" open an URL in the markdeep format by w3m.vim
"nnoremap <C-?> 0f(lyt):silent W3m <C-R>"<CR>

"------------------------------------------------------
" map: function key
"------------------------------------------------------
"nnoremap <F2> :MyNERDTreeToggle<CR>
"nnoremap <F3> :MyGstatusToggle<CR>
"nnoremap <F4> :GgrepHere<CR>

" tab
"nnoremap <F5> :tabclose<CR>
"nnoremap <F6> :tabnext<CR>

" build
"nnoremap <F5> :make<CR>:cw<CR>


" copy to the clipboard
"vnoremap <F11> "*y

" paste from the clipboard
"nnoremap <F12> "*p
"inoremap <F12> <ESC>"*p

" save session
"nnoremap <F?> :mksession! $MY_VIM/session.vim<CR>

" load session
"nnoremap <F?> :source $MY_VIM/session.vim<CR>

"nnoremap <F?> :Agit<CR>
"nnoremap <F?> :GV --all<CR>

"------------------------------------------------------
" map: plugin's key map
"------------------------------------------------------
" nerd commenter
"vmap C  <Leader>c<Space>
"vmap C  <plug>NERDCommenterToggle

