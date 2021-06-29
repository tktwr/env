"======================================================
" which_key
"======================================================
tnoremap <silent> <C-Space>     <C-W>:<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

vmap     <leader>C             <plug>NERDCommenterToggle

nnoremap <leader>0             <C-W>:MyTerm<CR>
nnoremap <leader>=             <C-W>=
nnoremap <leader>B             :MyTabBar<CR>
nmap     <leader>E             <plug>(easymotion-overwin-line)
nnoremap <leader>G             :MyTagbarToggle<CR>
nnoremap <leader>g             :silent MyGgrepHere<CR><C-L>
nnoremap <leader>I             <C-W>:MyWinInitSize<CR>
nnoremap <leader>K             :make<CR>:cw<CR>
nnoremap <leader>o             :call BmkOpenThis()<CR>
nnoremap <leader>P             :MyTogglePathFormat<CR>
nnoremap <leader>p             "*p
nnoremap <leader>Q             <C-W>:confirm qall<CR>
nnoremap <leader>R             :make run<CR>
nnoremap <leader>S             <C-W>:source ~/.vimrc<CR>
nnoremap <leader>T             :MyNERDTreeToggle<CR>
nnoremap <leader>x             <C-W>x
vnoremap <leader>y             "*y

nnoremap <leader>X6            :RunExplorer<CR><C-L>
nnoremap <leader>X7            :RunGvim<CR><C-L>
nnoremap <leader>X8            :RunVscode<CR><C-L>
nnoremap <leader>X9            :RunChrome<CR><C-L>
nnoremap <leader>Xh            <C-W>:MyHelp<CR>
nnoremap <leader>Xm            <C-W>:MyMemo<CR>
nnoremap <leader>XM            <C-W>:MyMan
nnoremap <leader>XP            <C-W>:MyPydoc
nnoremap <leader>XT            <C-W>:MyTrans<CR>
nnoremap <leader>XD            <C-W>:MyDict<CR>

nnoremap <leader>ZT0           <C-W>:MyTerm 0<CR>
nnoremap <leader>ZT1           <C-W>:MyTerm 1<CR>
nnoremap <leader>ZT2           <C-W>:MyTerm 2<CR>

nnoremap <leader>Zw=           <C-W>=
nnoremap <leader>Zwx           <C-W>x
nnoremap <leader>Zwr           <C-W>r
nnoremap <leader>ZwR           <C-W>R
nnoremap <leader>ZwK           <C-W>K
nnoremap <leader>ZwJ           <C-W>J
nnoremap <leader>ZwT           <C-W>T

nnoremap <leader>Zte           <C-W>:tabedit<CR>
nnoremap <leader>Ztc           <C-W>:tabclose<CR>
nnoremap <leader>Zto           <C-W>:tabonly<CR>
nnoremap <leader>Ztn           <C-W>:tabnext<CR>
nnoremap <leader>Ztp           <C-W>:tabprev<CR>

nnoremap <leader>ZvE           :MyCheckEnv<CR>
nnoremap <leader>ZvD           :MyCdHere<CR>
nnoremap <leader>Zvd           :MyLcdHere<CR>
nnoremap <leader>Zv2           :MySetTab 2<CR>
nnoremap <leader>Zv4           :MySetTab 4<CR>
nnoremap <leader>ZvL           :MyLineNumberToggle<CR>
nnoremap <leader>ZvI           :IndentGuidesToggle<CR>
nnoremap <leader>Zvf           zi

nnoremap <leader>Zep           :MyTogglePathFormat<CR>
nnoremap <leader>Zeu           :MyUpdateDateHere<CR>
nnoremap <leader>Zel           :MyMakeLink<CR>
nnoremap <leader>Zei           :MyMakeImageLink<CR>
nnoremap <leader>Zetb          :MyTabBar<CR>
nnoremap <leader>Zetd          :MyTabDots<CR>
nnoremap <leader>Zetc          :MyTabComma<CR>
nnoremap <leader>ZeD           :MyAddDate<CR>
nnoremap <leader>ZeT           :MyAddTime<CR>
vnoremap <leader>Zes1          y:'<,'>w !sumcol 1<CR>
vnoremap <leader>Zes2          y:'<,'>w !sumcol 2<CR>
vnoremap <leader>Zes3          y:'<,'>w !sumcol 3<CR>

nnoremap <leader>Zds           :vert diffsplit 
nnoremap <leader>Zdu           :diffupdate<CR>

nnoremap <leader>Zqd           :MyCdo<CR>
nnoremap <leader>Zqf           :MyCfdo<CR>

nnoremap <leader>ZoI           :MyIDE<CR>
nnoremap <leader>ZoT           :MyTagbarToggle<CR>
nnoremap <leader>Zoc           :MyClangFormat<CR>
nnoremap <leader>Zodj          :DictJaHere<CR><C-L>
nnoremap <leader>Zode          :DictEnHere<CR><C-L>
nnoremap <leader>Zodz          :DictZhHere<CR><C-L>
vnoremap <leader>Zotj          y:TransJaVisual<CR><C-L>
vnoremap <leader>Zote          y:TransEnVisual<CR><C-L>
vnoremap <leader>Zotz          y:TransZhVisual<CR><C-L>
nnoremap <leader>ZoE           :RunExplorer<CR><C-L>
nnoremap <leader>ZoG           :RunGvim<CR><C-L>
nnoremap <leader>ZoV           :RunVscode<CR><C-L>
nnoremap <leader>ZoC           :RunChrome<CR><C-L>
nnoremap <leader>ZoF           :RunFirefox<CR><C-L>

nnoremap <leader>ZgS           :MyGstatusToggle<CR>
nnoremap <leader>ZgV           :MyGV<CR>

nmap     <leader>ZcI           :MyCocInstall<CR>
nmap     <leader>Zcu           :CocUpdate<CR>
nmap     <leader>Zch           :call CocAction('doHover')<CR>
nmap     <leader>ZcD           :CocDiagnostics<CR>
nmap     <leader>Zc[           <Plug>(coc-diagnostic-prev)
nmap     <leader>Zc]           <Plug>(coc-diagnostic-next)
nmap     <leader>Zcd           <Plug>(coc-definition)
nmap     <leader>Zcy           <Plug>(coc-type-definition)
nmap     <leader>Zci           <Plug>(coc-implementation)
nmap     <leader>Zcr           <Plug>(coc-references)
nmap     <leader>ZcR           <Plug>(coc-rename)
xmap     <leader>ZcF           <Plug>(coc-format-selected)
nmap     <leader>ZcF           <Plug>(coc-format-selected)
nmap     <leader>Zcv           :CocList vimcommands<CR>
nmap     <leader>Zcb           :CocList buffers<CR>
nmap     <leader>Zcw           :CocList words<CR>
nmap     <leader>Zco           :CocList outline<CR>
nmap     <leader>Zc.           :CocListResume<CR>

nmap     <leader>ZPI           :PlugInstall<CR>
nmap     <leader>ZPu           :PlugUpdate<CR>
nmap     <leader>ZPU           :PlugUpgrade<CR>

call which_key#register('<Space>', "g:which_key_map")
"let g:which_key_vertical = 1
"let g:which_key_use_floating_win = 1
let g:which_key_sep = '>'
let g:which_key_hspace = 1
let g:which_key_exit = ["\<Space>", "\<Esc>"]
let g:which_key_map = { 'name' : '+top',
      \ '0' : 'MyTerm',
      \ '=' : 'Equal window',
      \ 'E' : 'Easymotion',
      \ 'G' : 'MyTagbarToggle (BS)',
      \ 'g' : 'MyGgrepHere',
      \ 'I' : 'MyWinInitSize (t:C-I)',
      \ 'K' : 'Make',
      \ 'o' : 'BmkOpenThis (C-CR)',
      \ 'p' : 'Paste',
      \ 'Q' : 'Quit (Q)',
      \ 'R' : 'Make Run',
      \ 'S' : 'Source vimrc',
      \ 'T' : 'MyNERDTreeToggle (TAB)',
      \ 'x' : 'Exchange window',
      \ 'y' : 'Yank',
      \ }
"let g:which_key_map.c = { 'name': 'which_key_ignore' }
"let g:which_key_map.h = { 'name': 'which_key_ignore' }

let g:which_key_map.X = { 'name' : '+Open',
      \ '6' : 'RunExplorer',
      \ '7' : 'RunGvim',
      \ '8' : 'RunVscode',
      \ '9' : 'RunChrome',
      \ 'h' : 'help',
      \ 'm' : 'memo',
      \ 'M' : 'man',
      \ 'P' : 'pydoc',
      \ 'T' : 'trans',
      \ 'D' : 'dict',
      \ }
let g:which_key_map.Z     = { 'name' : '+Others' }
let g:which_key_map.Z.T   = { 'name' : '+Term' }
let g:which_key_map.Z.w   = { 'name' : '+window' }
let g:which_key_map.Z.t   = { 'name' : '+tab' }
let g:which_key_map.Z.v   = { 'name' : '+vim' }
let g:which_key_map.Z.e   = { 'name' : '+edit' }
let g:which_key_map.Z.e.t = { 'name' : '+tabularize' }
let g:which_key_map.Z.e.s = { 'name' : '+sum' }
let g:which_key_map.Z.d   = { 'name' : '+diff' }
let g:which_key_map.Z.q   = { 'name' : '+q-command' }
let g:which_key_map.Z.o   = { 'name' : '+open' }
let g:which_key_map.Z.o.d = { 'name' : '+dict' }
let g:which_key_map.Z.o.t = { 'name' : '+trans' }
let g:which_key_map.Z.g   = { 'name' : '+git' }
let g:which_key_map.Z.c   = { 'name' : '+coc' }
let g:which_key_map.Z.P   = { 'name' : '+Plug' }

"autocmd! FileType which_key
"autocmd  FileType which_key set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

