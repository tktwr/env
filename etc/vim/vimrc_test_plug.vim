set nocompatible
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set runtimepath^=$MY_VIM
set runtimepath+=$MY_VIM/after

call plug#begin('$MY_VIM/plugged')

"--- [coc] --------------------------------------------
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_config_home = expand('$MY_VIM/coc/linux')
"let g:coc_data_home = expand('$MY_VIM/coc_data/linux')

"--- [fzf] --------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"--- [ide] --------------------------------------------
if has('nvim')
  Plug 'Ajnasz/vim-popup-menu'
endif

let g:cpm_key = "\<Space>"
let g:cpm_term_key = "\<C-Space>"
let g:cpm_files = split(glob("$MY_BMK/*.txt"))
let g:cpm_titles = { 'default' : ['vcmd.menu & vcmd.external & vcmd.ide', 'vcmd.sub'] }

Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'
"------------------------------------------------------

call plug#end()
