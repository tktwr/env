"======================================================
" map
"======================================================
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
"nnoremap <Space> <C-F>
"nnoremap <BS>    <C-B>
"nnoremap <C-J>   2<C-E>
"nnoremap <C-K>   2<C-Y>
nnoremap <C-D>    <C-B>

" window
nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>j
nnoremap <C-K>   <C-W>k
nnoremap <C-L>   <C-W>l

nnoremap <C-E>   :only<CR>
nnoremap <C-X>   :close<CR>

" redraw screen
nnoremap <C-N>   <C-L>

"------------------------------------------------------
" map: develop
"------------------------------------------------------
" tag
nnoremap <C-]>      g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>
nnoremap [I         [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[<C-I>"<CR>

" indent between { and }
"nnoremap <Left><Left>	%ma%:.+1,'a-1<<CR>+%
"nnoremap <Right><Right>	%ma%:.+1,'a-1><CR>+%/{<CR>

"------------------------------------------------------
" map: misc
"------------------------------------------------------
nnoremap '     `
nnoremap Q     :confirm qall<CR>
nnoremap --    :set invnumber<CR>:set invlist<CR>
" fold on/off
nnoremap ==    zi

" yank a line as commands into the register q
"nnoremap ,q    0"qy$
" execute commands in the register q
"nnoremap q     @q

" execute commands under the cursor
nnoremap X ^y$:silent exec "<C-R>""<CR>

" man
"nnoremap M :Man <cword><CR>

"------------------------------------------------------
" map: visual mode mapping
"------------------------------------------------------
" add column
vnoremap A1 y:'<,'>w !sumcol 1<CR>
vnoremap A2 y:'<,'>w !sumcol 2<CR>
vnoremap A3 y:'<,'>w !sumcol 3<CR>

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
nnoremap <C-A> I[A]Jr(A)I- 

" open an URL in the markdeep format by chrome
"nnoremap <C-O> 0f(lyt):silent !chrome.sh "<C-R>""<CR>

" open an URL under the cursor
nnoremap <C-O> :!chrome.sh <cfile><CR>

" open an URL in the markdeep format by w3m.vim
"nnoremap <C-?> 0f(lyt):silent W3m <C-R>"<CR>

"------------------------------------------------------
" map: function key
"------------------------------------------------------
nnoremap <F2> :MyNERDTreeToggle<CR>
nnoremap <F3> :MyGstatusToggle<CR>
" grep cword in git tracked files
nnoremap <F4> :Ggrep -I <cword> -- ':!*.dat'<CR>

" tab
"nnoremap <F5> :tabclose<CR>
"nnoremap <F6> :tabnext<CR>

" build
"nnoremap <F5> :make<CR>:cw<CR>


" copy to the clipboard
vnoremap <F11> "*y

" paste from the clipboard
nnoremap <F12> "*p
inoremap <F12> <ESC>"*p

" save session
"nnoremap <F?> :mksession! $MY_VIM/session.vim<CR>

" load session
"nnoremap <F?> :source $MY_VIM/session.vim<CR>

"nnoremap <F?> :Agit<CR>
"nnoremap <F?> :GV --all<CR>

"------------------------------------------------------
" map: plugin's key map
"------------------------------------------------------
" gitgutter
nnoremap ++    :GitGutterToggle<CR>

" nerd commenter
vmap C <Leader>c<Space>

" ultisnips
let g:UltiSnipsSnippetsDir=expand('$MY_VIM/UltiSnips')
let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsListSnippets="<F6>"
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"
"inoremap <C-X><C-K> <C-X><C-K>
"inoremap <C-N> <C-X><C-N>
"inoremap <C-P> <C-X><C-P>

" quickhl
nmap <C-U> <Plug>(quickhl-manual-this)
xmap <C-U> <Plug>(quickhl-manual-this)
nmap <C-Y> <Plug>(quickhl-manual-reset)
xmap <C-Y> <Plug>(quickhl-manual-reset)

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap <C-P> <Plug>(easymotion-overwin-line)

" comfortable-motion
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 0.8
if 1
  nnoremap <silent> <Space> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
  nnoremap <silent> <BS> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
else
  nnoremap <silent> <Space> :call comfortable_motion#flick(200)<CR>
  nnoremap <silent> <BS> :call comfortable_motion#flick(-200)<CR>
endif
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

