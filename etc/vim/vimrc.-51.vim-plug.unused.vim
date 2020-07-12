Plug 'cohama/agit.vim'
let g:agit_enable_auto_show_commit = 0
autocmd FileType agit_stat call s:my_agit_stat_settings()
function! s:my_agit_stat_settings()
  nmap <buffer> <silent> D <Plug>(agit-diff)
  nmap <buffer> <silent> <2-LeftMouse> <Plug>(agit-diff)
endfunction

"------------------------------------------------------
" vim-plug: translate-shell
"------------------------------------------------------
"Plug 'soimort/translate-shell'

"------------------------------------------------------
" vim-plug: supertab
"------------------------------------------------------
"Plug 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = "context"

"------------------------------------------------------
" vim-plug: deoplete
"------------------------------------------------------
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"let g:deoplete#enable_at_startup = 1

"------------------------------------------------------
" vim-plug: unused
"------------------------------------------------------
if 0
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'godlygeek/tabular'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  if !has('gui_running')
    Plug 'yuratomo/w3m.vim'
  endif
endif

