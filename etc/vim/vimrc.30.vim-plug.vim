"======================================================
" vim-plug
"======================================================
func s:InstallVimPlug()
  let plug_file = expand('$MY_VIM/autoload/plug.vim')
  let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  if empty(glob(plug_file))
    let cmd = printf("!curl --create-dirs -fL -o %s %s", plug_file, plug_url)
    silent exec cmd
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunc

"------------------------------------------------------
call s:InstallVimPlug()
call plug#begin('$MY_VIM/plugged')

"------------------------------------------------------
" vim-plug:
"------------------------------------------------------
source $MY_VIM/vim-plug/vim-dirdiff.vim
source $MY_VIM/vim-plug/vim-quickhl.vim
source $MY_VIM/vim-plug/vim-easymotion.vim

source $MY_VIM/vim-plug/coc.vim
"source $MY_VIM/vim-plug/vim-vsnip.vim
"source $MY_VIM/vim-plug/ultisnips.vim

"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
source $MY_VIM/vim-plug/color.vim

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
"source $MY_VIM/vim-plug/eskk.vim
source $MY_VIM/vim-plug/edit.vim
source $MY_VIM/vim-plug/fzy.vim

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
source $MY_VIM/vim-plug/git.vim
source $MY_VIM/vim-plug/git-log.vim

"------------------------------------------------------
" vim-plug: IDE
"------------------------------------------------------
"source $MY_VIM/vim-plug/nerdtree.vim
source $MY_VIM/vim-plug/fern.vim
source $MY_VIM/vim-plug/tagbar.vim
source $MY_VIM/vim-plug/ide.vim

"------------------------------------------------------

call plug#end()

"======================================================
" color
"======================================================
colorscheme gruvbox

