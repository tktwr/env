"======================================================
" which_key
"======================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

nnoremap <leader>m            :Memo<CR>
nnoremap <leader>d            :Dia<CR>
nnoremap <leader>t            :Todo<CR>
nnoremap <leader>i            :Tips<CR>
nnoremap <leader>n            :MyNERDTreeToggle<CR>
nnoremap <leader>o            :OpenURL <cfile><CR>
vnoremap <leader>y            "*y
nnoremap <leader>p            "*p
inoremap <leader>p            <ESC>"*p
nnoremap <leader>T            :Trans<CR>
nnoremap <leader>C            :ClangFormat<CR>
nnoremap <leader>K            :make<CR>
nnoremap <leader>M            :Ref man 
nnoremap <leader>P            :Ref pydoc 
nnoremap <leader>Q            :confirm qall<CR>

nnoremap <leader>Dj           :DictJaHere<CR><C-L>
nnoremap <leader>De           :DictEnHere<CR><C-L>
nnoremap <leader>Dz           :DictZhHere<CR><C-L>

vnoremap <leader>Tj           y:TransJaVisual<CR><C-L>
vnoremap <leader>Te           y:TransEnVisual<CR><C-L>
vnoremap <leader>Tz           y:TransZhVisual<CR><C-L>

nnoremap <leader>sd           :MyCdHere<CR>
nnoremap <leader>sD           :MyLcdHere<CR>
nnoremap <leader>se           :MyCheckEnv<CR>
nnoremap <leader>s2           :MySetTab 2<CR>
nnoremap <leader>s4           :MySetTab 4<CR>
nnoremap <leader>sl           :MyLineNumberToggle<CR>
nnoremap <leader>sg           :GitGutterToggle<CR>
nnoremap <leader>sf           zi
nnoremap <leader>st           :TagbarToggle<CR>
nnoremap <leader>si           :MyIDE<CR>

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

nnoremap <leader>gs           :MyGstatusToggle<CR>
nnoremap <leader>gv           :GV --all<CR>
nnoremap <leader>gg           :GgrepHere<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
let g:which_key_map = {
      \ 'name' : '+top',
      \ 'n' : 'NERDTree',
      \ 'o' : 'OpenURL',
      \ 'y' : 'yank',
      \ 'p' : 'paste',
      \ 'M' : 'Man',
      \ 'P' : 'Pydoc',
      \ 'Q' : 'Quit',
      \ }
let g:which_key_map.c = { 'name': 'which_key_ignore' }
let g:which_key_map.h = { 'name': 'which_key_ignore' }
let g:which_key_map.D = { 'name' : '+Dict' }
let g:which_key_map.T = { 'name' : '+Trans' }
let g:which_key_map.s = { 'name' : '+set' }
let g:which_key_map.e = { 'name' : '+edit' }
let g:which_key_map.r = { 'name' : '+run' }
let g:which_key_map.g = { 'name' : '+git' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode

