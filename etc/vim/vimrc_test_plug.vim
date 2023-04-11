"======================================================
" test plugins
"======================================================
func PlugCoc()
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_config_home = expand('$MY_VIM/coc/linux')
  let g:coc_data_home = $MY_COC_DATA_DIR
endfunc

func PlugFzf()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endfunc

func PlugFern()
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  let g:fern#disable_default_mappings = 1
  let g:fern#renderer = 'nerdfont'
endfunc

func PlugIDE()
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
endfunc

func PlugColor()
  Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark = "soft"
endfunc

"======================================================
" main
"======================================================
set nocompatible
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set runtimepath^=$MY_VIM
set runtimepath+=$MY_VIM/after

set termguicolors
set t_Co=256
set background=dark
set hlsearch
syntax on

call plug#begin($MY_VIM_PLUGGED_DIR)

call PlugCoc()
call PlugFzf()
call PlugFern()
call PlugIDE()
call PlugColor()

call plug#end()

"------------------------------------------------------
" color
"------------------------------------------------------
colorscheme gruvbox

"------------------------------------------------------
" map
"------------------------------------------------------
nnoremap <silent> <End>      <C-W>:call wbl#open()<CR>
tnoremap <silent> <End>      <C-W>:call wbl#open()<CR>

nnoremap <silent> <Space>    <C-W>:CpmOpen<CR>
tnoremap <silent> <C-Space>  <C-W>:CpmOpen<CR>
