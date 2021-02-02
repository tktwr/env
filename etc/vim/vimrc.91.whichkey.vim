"======================================================
" which_key
"======================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

nmap     <leader>E            <Plug>(easymotion-overwin-line)
nnoremap <leader>n            :MyNERDTreeToggle<CR>
nnoremap <leader>s            :MyGstatusToggle<CR>
nnoremap <leader>u            :OpenURL <cfile><CR>
nnoremap <leader>m            :Memo<CR>
nnoremap <leader>d            :Dia<CR>
vnoremap <leader>y            "*y
nnoremap <leader>p            "*p
inoremap <leader>p            <ESC>"*p
nnoremap <leader>k            :make<CR>
nnoremap <leader>t            :bot term<CR>
nnoremap <leader>T            :Trans<CR>
nnoremap <leader>Q            :confirm qall<CR>

nnoremap <leader>op           :Tips<CR>
nnoremap <leader>oC           :ClangFormat<CR>
nnoremap <leader>oM           :Ref man 
nnoremap <leader>oP           :Ref pydoc 
nnoremap <leader>oDj          :DictJaHere<CR><C-L>
nnoremap <leader>oDe          :DictEnHere<CR><C-L>
nnoremap <leader>oDz          :DictZhHere<CR><C-L>
vnoremap <leader>oTj          y:TransJaVisual<CR><C-L>
vnoremap <leader>oTe          y:TransEnVisual<CR><C-L>
vnoremap <leader>oTz          y:TransZhVisual<CR><C-L>

nnoremap <leader>vd           :MyCdHere<CR>
nnoremap <leader>vD           :MyLcdHere<CR>
nnoremap <leader>ve           :MyCheckEnv<CR>
nnoremap <leader>v2           :MySetTab 2<CR>
nnoremap <leader>v4           :MySetTab 4<CR>
nnoremap <leader>vl           :MyLineNumberToggle<CR>
nnoremap <leader>vg           :GitGutterToggle<CR>
nnoremap <leader>vf           zi
nnoremap <leader>vt           :TagbarToggle<CR>
nnoremap <leader>vi           :MyIDE<CR>

nnoremap <leader>ep           :TogglePathFormat<CR>
nnoremap <leader>eu           :MyUpdateDateHere<CR>
nnoremap <leader>ed           :MyAddDate<CR>
nnoremap <leader>et           :MyAddTime<CR>
nnoremap <leader>ev           :VimGrepHere<CR>
nnoremap <leader>el           :MyMakeLink<CR>
nnoremap <leader>ei           :MyMakeImageLink<CR>

nnoremap <leader>re           :RunExplorer<CR>
nnoremap <leader>rg           :RunGvim<CR>
nnoremap <leader>rv           :RunVscode<CR>
nnoremap <leader>rc           :RunChrome<CR>
nnoremap <leader>rf           :RunFirefox<CR>

nnoremap <leader>gv           :GV --all<CR>
nnoremap <leader>gg           :GgrepHere<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
let g:which_key_map = {
      \ 'name' : '+top',
      \ 'E' : 'easymotion',
      \ 'n' : 'NERDTree',
      \ 'u' : 'OpenURL',
      \ 'y' : 'yank',
      \ 'p' : 'paste',
      \ 'Q' : 'Quit',
      \ }
let g:which_key_map.c = { 'name': 'which_key_ignore' }
let g:which_key_map.h = { 'name': 'which_key_ignore' }
let g:which_key_map.o = { 'name' : '+open' }
let g:which_key_map.o.D = { 'name' : '+Dict' }
let g:which_key_map.o.T = { 'name' : '+Trans' }
let g:which_key_map.v = { 'name' : '+vim' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.r = { 'name' : '+run' }
let g:which_key_map.g = { 'name' : '+git' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode

