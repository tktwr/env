"======================================================
" which_key
"======================================================
tnoremap <silent> <C-Space>     <C-W>:<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

vmap     <leader>C            <plug>NERDCommenterToggle

nnoremap <leader>0            <C-W>:MyTerm 0<CR>
nnoremap <leader>1            <C-W>:Dia<CR>
nnoremap <leader>2            <C-W>:Memo<CR>
nnoremap <leader>3            <C-W>:Tips<CR>
nnoremap <leader>4            <C-W>:Links<CR>
nnoremap <leader>5            :silent GgrepHere<CR><C-L>
nnoremap <leader>6            :VimGrepHere<CR>
nnoremap <leader>9            <C-W>:Trans<CR>
nmap     <leader>E            <plug>(easymotion-overwin-line)
nnoremap <leader>N            :MyNERDTreeToggle<CR>
nnoremap <leader>S            :MyGstatusToggle<CR>
nnoremap <leader>U            :OpenURL <cfile><CR><C-L>
nnoremap <leader>K            :make<CR>:cw<CR>
nnoremap <leader>Q            :confirm qall<CR>
vnoremap <leader>y            "*y
nnoremap <leader>p            "*p

nnoremap <leader>w0           <C-W>=
nnoremap <leader>w1           <C-W>:resize<CR>
nnoremap <leader>w2           <C-W>:resize 10<CR>

nnoremap <leader>T0           <C-W>:MyTerm 0<CR>
nnoremap <leader>T1           <C-W>:MyTerm 1<CR>
nnoremap <leader>T2           <C-W>:MyTerm 2<CR>

nnoremap <leader>te           <C-W>:tabedit<CR>
nnoremap <leader>tc           :tabclose<CR>
nnoremap <leader>to           :tabonly<CR>
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
nnoremap <leader>vG           :VimGrepHere<CR>
nnoremap <leader>vg           :VimGrep 

nnoremap <leader>ep           :TogglePathFormat<CR>
nnoremap <leader>eu           :MyUpdateDateHere<CR>
nnoremap <leader>el           :MyMakeLink<CR>
nnoremap <leader>ei           :MyMakeImageLink<CR>
nnoremap <leader>etb          :TabBar<CR>
nnoremap <leader>etd          :TabDots<CR>
nnoremap <leader>etc          :TabComma<CR>
nnoremap <leader>eD           :MyAddDate<CR>
nnoremap <leader>eT           :MyAddTime<CR>

nnoremap <leader>ds           :vert diffsplit 
nnoremap <leader>du           :diffupdate<CR>

nnoremap <leader>qd           :Cdo<CR>
nnoremap <leader>qf           :Cfdo<CR>

nnoremap <leader>oI           :MyIDE<CR>
nnoremap <leader>oT           :TagbarToggle<CR>
nnoremap <leader>oc           :ClangFormat<CR>
nnoremap <leader>oM           :Ref man 
nnoremap <leader>oP           :Ref pydoc 
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

nnoremap <leader>gG           :silent GgrepHere<CR><C-L>
nnoremap <leader>gg           :Ggrep 
nnoremap <leader>gu           :GitGutterToggle<CR>
nnoremap <leader>gv           :GV --all<CR>

nmap     <leader>PI           :PlugInstall<CR>
nmap     <leader>Pu           :PlugUpdate<CR>
nmap     <leader>PU           :PlugUpgrade<CR>

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

vnoremap <leader>A1           y:'<,'>w !sumcol 1<CR>
vnoremap <leader>A2           y:'<,'>w !sumcol 2<CR>
vnoremap <leader>A3           y:'<,'>w !sumcol 3<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
"let g:which_key_use_floating_win = 1
let g:which_key_hspace = 2
let g:which_key_exit = ["\<Space>", "\<Esc>"]
let g:which_key_map = { 'name' : '+top',
      \ '0' : 'Term',
      \ '1' : 'Dia',
      \ '2' : 'Memo',
      \ '3' : 'Tips',
      \ '4' : 'Links',
      \ '5' : 'GgrepHere',
      \ '6' : 'VimGrepHere',
      \ '9' : 'Trans',
      \ 'C' : 'Comment',
      \ 'E' : 'Easymotion (BS)',
      \ 'N' : 'NERDTree (TAB)',
      \ 'S' : 'GStatus',
      \ 'U' : 'OpenURL',
      \ 'K' : 'Make',
      \ 'y' : 'yank',
      \ 'p' : 'paste',
      \ 'Q' : 'Quit (Q)',
      \ }
"let g:which_key_map.c = { 'name': 'which_key_ignore' }
"let g:which_key_map.h = { 'name': 'which_key_ignore' }

let g:which_key_map.w   = { 'name' : '+window' }
let g:which_key_map.T   = { 'name' : '+Term' }
let g:which_key_map.t   = { 'name' : '+tab' }
let g:which_key_map.v   = { 'name' : '+vim' }
let g:which_key_map.e   = { 'name' : '+edit' }
let g:which_key_map.e.t = { 'name' : '+tabularize' }
let g:which_key_map.d   = { 'name' : '+diff' }
let g:which_key_map.q   = { 'name' : '+q-command' }
let g:which_key_map.o   = { 'name' : '+open' }
let g:which_key_map.o.d = { 'name' : '+Dict' }
let g:which_key_map.o.t = { 'name' : '+Trans' }
let g:which_key_map.g   = { 'name' : '+git' }
let g:which_key_map.P   = { 'name' : '+Plug' }
let g:which_key_map.c   = { 'name' : '+coc' }
let g:which_key_map.A   = { 'name' : '+Add' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

