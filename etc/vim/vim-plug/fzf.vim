"------------------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   below copen 10
"   cc
" endfunction
"
" let g:fzf_action = {
"   \ 'ctrl-q': function('s:build_quickfix_list'),
"   \ }

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.9}}
let g:fzf_commits_log_options = "--graph --color=always --pretty=format:'%C(red)%h %C(green)%cd %C(blue)%an %C(yellow)%d %C(reset)%s' --date=format-local:'%Y/%m/%d %H:%M'"

Plug 'antoinemadec/coc-fzf'
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = ['--layout=reverse']

"------------------------------------------------------
"Plug 'ctrlpvim/ctrlp.vim'

"------------------------------------------------------
"Plug 'bfrg/vim-fzy'
"g:fzy = {
"  lines: 15,
"  prompt: '>>> ',
"  showinfo: true,
"  popupwin: true
"}
