"------------------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_command_prefix = 'Fzf'
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
