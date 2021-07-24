"======================================================
" vim-plug
"======================================================
set complete=.,w,b,u,i

if empty(glob('$MY_VIM/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$MY_VIM/plugged')

"======================================================
source $MY_VIM/vim-plug/vim-dirdiff.vim
source $MY_VIM/vim-plug/vim-fugitive.vim
source $MY_VIM/vim-plug/vim-gitgutter.vim
source $MY_VIM/vim-plug/tabular.vim
source $MY_VIM/vim-plug/tagbar.vim
source $MY_VIM/vim-plug/gv.vim
source $MY_VIM/vim-plug/fern.vim
source $MY_VIM/vim-plug/coc.vim
"source $MY_VIM/vim-plug/ultisnips.vim
"source $MY_VIM/vim-plug/eskk.vim
"source $MY_VIM/vim-plug/nerdtree.vim
"source $MY_VIM/vim-plug/nerdtree-git.vim

"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

Plug 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

Plug 'octol/vim-cpp-enhanced-highlight'
Plug 't9md/vim-quickhl'

"------------------------------------------------------
" vim-plug: IDE
"------------------------------------------------------
Plug 'thinca/vim-ref'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"Plug 'ctrlpvim/ctrlp.vim'

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
Plug 'cohama/agit.vim'

"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDMenuMode=0
let g:NERDCreateDefaultMappings=0

"======================================================
call plug#end()

"------------------------------------------------------
" colorscheme
"------------------------------------------------------
colorscheme gruvbox

