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

call plug#begin($MY_VIM_PLUGGED_DIR)

source $MY_VIM/vim-plug/color.vim
source $MY_VIM/vim-plug/edit.vim
source $MY_VIM/vim-plug/diff.vim
source $MY_VIM/vim-plug/git.vim
source $MY_VIM/vim-plug/ide.vim
source $MY_VIM/vim-plug/fern.vim
source $MY_VIM/vim-plug/tagbar.vim
source $MY_VIM/vim-plug/fzf.vim
"source $MY_VIM/vim-plug/eskk.vim

if executable('node')
  source $MY_VIM/vim-plug/coc.vim
endif

call plug#end()

"------------------------------------------------------
colorscheme gruvbox

