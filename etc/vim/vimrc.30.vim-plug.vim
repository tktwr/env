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

"------------------------------------------------------
" include
"------------------------------------------------------
source $MY_VIM/vim-plug/vim-dirdiff.vim
source $MY_VIM/vim-plug/vim-fugitive.vim
source $MY_VIM/vim-plug/vim-indent-guides.vim
source $MY_VIM/vim-plug/vim-quickhl.vim
source $MY_VIM/vim-plug/vim-easymotion.vim
source $MY_VIM/vim-plug/tabular.vim
source $MY_VIM/vim-plug/tagbar.vim
source $MY_VIM/vim-plug/gv.vim
source $MY_VIM/vim-plug/nerdcommenter.vim

source $MY_VIM/vim-plug/fern.vim
"source $MY_VIM/vim-plug/nerdtree.vim

source $MY_VIM/vim-plug/coc.vim
"source $MY_VIM/vim-plug/vim-vsnip.vim
"source $MY_VIM/vim-plug/ultisnips.vim

"source $MY_VIM/vim-plug/eskk.vim
"source $MY_VIM/vim-plug/nerdtree-git-plugin.vim
"source $MY_VIM/vim-plug/fzf.vim

if $MY_PROMPT_TYPE >= 1
  source $MY_VIM/vim-plug/vim-gitgutter.vim
endif

"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

Plug 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

Plug 'octol/vim-cpp-enhanced-highlight'

"------------------------------------------------------
" vim-plug: IDE
"------------------------------------------------------
Plug 'thinca/vim-ref'

"Plug 'ctrlpvim/ctrlp.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
Plug 'cohama/agit.vim'

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

"------------------------------------------------------
" vim-plug: my
"------------------------------------------------------
Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'

"------------------------------------------------------

call plug#end()

"------------------------------------------------------
" colorscheme
"------------------------------------------------------
colorscheme gruvbox

