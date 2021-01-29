"======================================================
" which_key
"======================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

nnoremap <leader>m            :Memo<CR>
nnoremap <leader>p            :Tips<CR>
nnoremap <leader>d            :Dia<CR>
nnoremap <leader>t            :Todo<CR>
nnoremap <leader>n            :MyNERDTreeToggle<CR>
nnoremap <leader>o            :OpenURL <cfile><CR>

nnoremap <leader>ep           :TogglePathFormat<CR>
nnoremap <leader>eu           :MyAddDateHere<CR>
nnoremap <leader>ed           :MyAddDate<CR>
nnoremap <leader>et           :MyAddTime<CR>
nnoremap <leader>ev           :VimGrepHere<CR>

nnoremap <leader>re           :RunExplorer<CR>
nnoremap <leader>rg           :RunGvim<CR>
nnoremap <leader>rv           :RunVscode<CR>
nnoremap <leader>rc           :RunChrome<CR>
nnoremap <leader>rf           :RunFirefox<CR>

nnoremap <leader>gs           :MyGstatusToggle<CR>
nnoremap <leader>gg           :GgrepHere<CR>
nnoremap <leader>gu           :GitGutterToggle<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
let g:which_key_map = {
      \ 'name' : '+top',
      \ 'm' : 'Memo',
      \ 'p' : 'Tips',
      \ 'd' : 'Dia',
      \ 't' : 'Todo',
      \ 'n' : 'NERDTree',
      \ 'o' : 'OpenURL',
      \ }
let g:which_key_map.c = { 'name': 'which_key_ignore' }
let g:which_key_map.h = { 'name': 'which_key_ignore' }
let g:which_key_map.e = {
      \ 'name' : '+edit',
      \ 'p' : 'TogglePathFormat',
      \ 'u' : 'MyAddDateHere',
      \ 'd' : 'MyAddDate',
      \ 't' : 'MyAddTime',
      \ 'v' : 'VimGrepHere',
      \ }
let g:which_key_map.r = {
      \ 'name' : '+run',
      \ 'e' : 'RunExplorer',
      \ 'g' : 'RunGvim',
      \ 'v' : 'RunVscode',
      \ 'c' : 'RunChrome',
      \ 'f' : 'RunFirefox',
      \ }
let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 's' : 'MyGstatusToggle',
      \ 'g' : 'GgrepHere',
      \ }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode

