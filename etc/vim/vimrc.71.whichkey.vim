"======================================================
" which_key
"======================================================
tnoremap <silent> <C-Space>     <C-W>:<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

vmap     <leader>C            <plug>NERDCommenterToggle

nnoremap <leader>0            <C-W>:MyTerm<CR>
nnoremap <leader>1            :silent MyGgrepHere<CR><C-L>
nnoremap <leader>6            :RunExplorer<CR><C-L>
nnoremap <leader>7            :RunGvim<CR><C-L>
nnoremap <leader>8            :RunVscode<CR><C-L>
nnoremap <leader>9            :RunChrome<CR><C-L>
vnoremap <leader>y            "*y
nnoremap <leader>p            "*p
nmap     <leader>M            <plug>(easymotion-overwin-line)
nnoremap <leader>O            :call MyOpen("")<CR>
nnoremap <leader>K            :make<CR>:cw<CR>
nnoremap <leader>R            :make run<CR>
nnoremap <leader>S            <C-W>:source ~/.vimrc<CR>
nnoremap <leader>Q            <C-W>:confirm qall<CR>

nnoremap <leader>T0           <C-W>:MyTerm 0<CR>
nnoremap <leader>T1           <C-W>:MyTerm 1<CR>
nnoremap <leader>T2           <C-W>:MyTerm 2<CR>

nnoremap <leader>w=           <C-W>=
nnoremap <leader>wx           <C-W>x
nnoremap <leader>wr           <C-W>r
nnoremap <leader>wR           <C-W>R
nnoremap <leader>wK           <C-W>K
nnoremap <leader>wJ           <C-W>J
nnoremap <leader>wT           <C-W>T

nnoremap <leader>te           <C-W>:tabedit<CR>
nnoremap <leader>tc           <C-W>:tabclose<CR>
nnoremap <leader>to           <C-W>:tabonly<CR>
nnoremap <leader>tn           <C-W>:tabnext<CR>
nnoremap <leader>tp           <C-W>:tabprev<CR>

nnoremap <leader>vE           :MyCheckEnv<CR>
nnoremap <leader>vD           :MyCdHere<CR>
nnoremap <leader>vd           :MyLcdHere<CR>
nnoremap <leader>v2           :MySetTab 2<CR>
nnoremap <leader>v4           :MySetTab 4<CR>
nnoremap <leader>vL           :MyLineNumberToggle<CR>
nnoremap <leader>vI           :IndentGuidesToggle<CR>
nnoremap <leader>vf           zi

nnoremap <leader>ep           :MyTogglePathFormat<CR>
nnoremap <leader>eu           :MyUpdateDateHere<CR>
nnoremap <leader>el           :MyMakeLink<CR>
nnoremap <leader>ei           :MyMakeImageLink<CR>
nnoremap <leader>etb          :MyTabBar<CR>
nnoremap <leader>etd          :MyTabDots<CR>
nnoremap <leader>etc          :MyTabComma<CR>
nnoremap <leader>eD           :MyAddDate<CR>
nnoremap <leader>eT           :MyAddTime<CR>
vnoremap <leader>es1          y:'<,'>w !sumcol 1<CR>
vnoremap <leader>es2          y:'<,'>w !sumcol 2<CR>
vnoremap <leader>es3          y:'<,'>w !sumcol 3<CR>

nnoremap <leader>ds           :vert diffsplit 
nnoremap <leader>du           :diffupdate<CR>

nnoremap <leader>qd           :MyCdo<CR>
nnoremap <leader>qf           :MyCfdo<CR>

nnoremap <leader>oI           :MyIDE<CR>
nnoremap <leader>oT           :MyTagbarToggle<CR>
nnoremap <leader>oc           :MyClangFormat<CR>
nnoremap <leader>odj          :DictJaHere<CR><C-L>
nnoremap <leader>ode          :DictEnHere<CR><C-L>
nnoremap <leader>odz          :DictZhHere<CR><C-L>
vnoremap <leader>otj          y:TransJaVisual<CR><C-L>
vnoremap <leader>ote          y:TransEnVisual<CR><C-L>
vnoremap <leader>otz          y:TransZhVisual<CR><C-L>
nnoremap <leader>oE           :RunExplorer<CR><C-L>
nnoremap <leader>oG           :RunGvim<CR><C-L>
nnoremap <leader>oV           :RunVscode<CR><C-L>
nnoremap <leader>oC           :RunChrome<CR><C-L>
nnoremap <leader>oF           :RunFirefox<CR><C-L>

nnoremap <leader>gS           :MyGstatusToggle<CR>
nnoremap <leader>gV           :MyGV<CR>

nmap     <leader>cI           :MyCocInstall<CR>
nmap     <leader>cu           :CocUpdate<CR>
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
nmap     <leader>cv           :CocList vimcommands<CR>
nmap     <leader>cb           :CocList buffers<CR>
nmap     <leader>cw           :CocList words<CR>
nmap     <leader>co           :CocList outline<CR>
nmap     <leader>c.           :CocListResume<CR>

nmap     <leader>PI           :PlugInstall<CR>
nmap     <leader>Pu           :PlugUpdate<CR>
nmap     <leader>PU           :PlugUpgrade<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
"let g:which_key_use_floating_win = 1
let g:which_key_sep = '>'
let g:which_key_hspace = 1
let g:which_key_exit = ["\<Space>", "\<Esc>"]
let g:which_key_map = { 'name' : '+top',
      \ '0' : 'MyTerm',
      \ '1' : 'MyGgrepHere',
      \ '6' : 'RunExplorer',
      \ '7' : 'RunGvim',
      \ '8' : 'RunVscode',
      \ '9' : 'RunChrome',
      \ 'y' : 'yank',
      \ 'p' : 'paste',
      \ 'S' : 'SourceVimrc',
      \ 'M' : 'Easymotion',
      \ 'O' : 'MyOpen (C-CR)',
      \ 'K' : 'Make',
      \ 'R' : 'Make Run',
      \ 'Q' : 'Quit (Q)',
      \ }
"let g:which_key_map.c = { 'name': 'which_key_ignore' }
"let g:which_key_map.h = { 'name': 'which_key_ignore' }

let g:which_key_map.T   = { 'name' : '+Term' }
let g:which_key_map.w   = { 'name' : '+window' }
let g:which_key_map.t   = { 'name' : '+tab' }
let g:which_key_map.v   = { 'name' : '+vim' }
let g:which_key_map.e   = { 'name' : '+edit' }
let g:which_key_map.e.t = { 'name' : '+tabularize' }
let g:which_key_map.e.s = { 'name' : '+sum' }
let g:which_key_map.d   = { 'name' : '+diff' }
let g:which_key_map.q   = { 'name' : '+q-command' }
let g:which_key_map.o   = { 'name' : '+open' }
let g:which_key_map.o.d = { 'name' : '+dict' }
let g:which_key_map.o.t = { 'name' : '+trans' }
let g:which_key_map.g   = { 'name' : '+git' }
let g:which_key_map.c   = { 'name' : '+coc' }
let g:which_key_map.P   = { 'name' : '+Plug' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

