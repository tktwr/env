"======================================================
" which_key
"======================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

vmap     <leader>C            <plug>NERDCommenterToggle
nmap     <leader>E            <plug>(easymotion-overwin-line)
nnoremap <leader>M            :Memo<CR>
nnoremap <leader>D            :Dia<CR>
nnoremap <leader>N            :MyNERDTreeToggle<CR>
nnoremap <leader>S            :MyGstatusToggle<CR>
nnoremap <leader>U            :OpenURL <cfile><CR><C-L>
nnoremap <leader>K            :make<CR>:cw<CR>
nnoremap <leader>R            :Trans<CR>
nnoremap <leader>Q            :confirm qall<CR>
vnoremap <leader>y            "*y
nnoremap <leader>p            "*p
inoremap <leader>p            <ESC>"*p

nnoremap <leader>T0           :MyTerm 0<CR>
nnoremap <leader>T1           :MyTerm 1<CR>
nnoremap <leader>T2           :MyTerm 2<CR>

nnoremap <leader>te           :tabedit<CR>
nnoremap <leader>tc           :tabclose<CR>
nnoremap <leader>to           :tabonly<CR>
nnoremap <leader>tn           :tabnext<CR>
nnoremap <leader>tp           :tabprev<CR>

nnoremap <leader>vd           :MyCdHere<CR>
nnoremap <leader>vD           :MyLcdHere<CR>
nnoremap <leader>ve           :MyCheckEnv<CR>
nnoremap <leader>v2           :MySetTab 2<CR>
nnoremap <leader>v4           :MySetTab 4<CR>
nnoremap <leader>vl           :MyLineNumberToggle<CR>
nnoremap <leader>vf           zi
nnoremap <leader>vG           :VimGrepHere<CR>
nnoremap <leader>vg           :VimGrep 

nnoremap <leader>ep           :TogglePathFormat<CR>
nnoremap <leader>eu           :MyUpdateDateHere<CR>
nnoremap <leader>el           :MyMakeLink<CR>
nnoremap <leader>ei           :MyMakeImageLink<CR>
nnoremap <leader>etb          :TabBar<CR>
nnoremap <leader>etd          :TabDot<CR>

nnoremap <leader>id           :MyAddDate<CR>
nnoremap <leader>it           :MyAddTime<CR>

nnoremap <leader>ds           :vert diffsplit 
nnoremap <leader>du           :diffupdate<CR>

nnoremap <leader>qd           :Cdo<CR>
nnoremap <leader>qf           :Cfdo<CR>

nnoremap <leader>oI           :MyIDE<CR>
nnoremap <leader>oT           :TagbarToggle<CR>
nnoremap <leader>ot           :Tips<CR>
nnoremap <leader>oC           :ClangFormat<CR>
nnoremap <leader>oM           :Ref man 
nnoremap <leader>oP           :Ref pydoc 
nnoremap <leader>oDj          :DictJaHere<CR><C-L>
nnoremap <leader>oDe          :DictEnHere<CR><C-L>
nnoremap <leader>oDz          :DictZhHere<CR><C-L>
vnoremap <leader>oTj          y:TransJaVisual<CR><C-L>
vnoremap <leader>oTe          y:TransEnVisual<CR><C-L>
vnoremap <leader>oTz          y:TransZhVisual<CR><C-L>

nnoremap <leader>re           :RunExplorer<CR><C-L>
nnoremap <leader>rg           :RunGvim<CR><C-L>
nnoremap <leader>rv           :RunVscode<CR><C-L>
nnoremap <leader>rc           :RunChrome<CR><C-L>
nnoremap <leader>rf           :RunFirefox<CR><C-L>

nnoremap <leader>gG           :silent GgrepHere<CR><C-L>
nnoremap <leader>gg           :Ggrep 
nnoremap <leader>gu           :GitGutterToggle<CR>
nnoremap <leader>gv           :GV --all<CR>

nmap     <leader>ch           :call CocAction('doHover')<CR>
nmap     <leader>cD           :CocDiagnostics<CR>
nmap     <leader>c[           <Plug>(coc-diagnostic-prev)
nmap     <leader>c]           <Plug>(coc-diagnostic-next)
nmap     <leader>cd           <Plug>(coc-definition)
nmap     <leader>cy           <Plug>(coc-type-definition)
nmap     <leader>ci           <Plug>(coc-implementation)
nmap     <leader>cr           <Plug>(coc-references)
nmap     <leader>cR           <Plug>(coc-rename)
xmap     <leader>cF           <Plug>(coc-format-selected)
nmap     <leader>cF           <Plug>(coc-format-selected)

vnoremap <leader>A1           y:'<,'>w !sumcol 1<CR>
vnoremap <leader>A2           y:'<,'>w !sumcol 2<CR>
vnoremap <leader>A3           y:'<,'>w !sumcol 3<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
let g:which_key_exit = ["\<Space>", "\<Esc>"]
let g:which_key_map = { 'name' : '+top',
      \ 'C' : 'Comment',
      \ 'E' : 'Easymotion',
      \ 'N' : 'NERDTree',
      \ 'S' : 'GStatus',
      \ 'U' : 'OpenURL',
      \ 'K' : 'Make',
      \ 'y' : 'yank',
      \ 'p' : 'paste',
      \ 'Q' : 'Quit',
      \ }
"let g:which_key_map.c = { 'name': 'which_key_ignore' }
"let g:which_key_map.h = { 'name': 'which_key_ignore' }

let g:which_key_map.T   = { 'name' : '+Term' }
let g:which_key_map.t   = { 'name' : '+tab' }
let g:which_key_map.v   = { 'name' : '+vim' }
let g:which_key_map.e   = { 'name' : '+edit' }
let g:which_key_map.e.t = { 'name' : '+tabularize' }
let g:which_key_map.i   = { 'name' : '+insert' }
let g:which_key_map.d   = { 'name' : '+diff' }
let g:which_key_map.q   = { 'name' : '+q-command' }
let g:which_key_map.o   = { 'name' : '+open' }
let g:which_key_map.o.D = { 'name' : '+Dict' }
let g:which_key_map.o.T = { 'name' : '+Trans' }
let g:which_key_map.r   = { 'name' : '+run' }
let g:which_key_map.g   = { 'name' : '+git' }
let g:which_key_map.c   = { 'name' : '+coc' }
let g:which_key_map.A   = { 'name' : '+Add' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

