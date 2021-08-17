let $MY_CONFIG=expand("$HOME/MyConfig")
let $MY_VIM=expand("$MY_CONFIG/tktwr.github/env/etc/vim")

source $MY_VIM/vimrc.00.init.vim
source $MY_VIM/vimrc.10.skel.vim
source $MY_VIM/vimrc.30.vim-plug.vim
source $MY_VIM/vimrc.40.highlight.vim
source $MY_VIM/vimrc.41.statusline.vim
source $MY_VIM/vimrc.42.tabline.vim
source $MY_VIM/vimrc.50.func.vim
source $MY_VIM/vimrc.60.command.vim
source $MY_VIM/vimrc.61.enc.vim
source $MY_VIM/vimrc.63.dev.vim
source $MY_VIM/vimrc.64.edit.vim
source $MY_VIM/vimrc.65.window.vim
source $MY_VIM/vimrc.66.external.vim
source $MY_VIM/vimrc.67.terminal.vim
source $MY_VIM/vimrc.68.ide.vim
source $MY_VIM/vimrc.70.map.vim
source $MY_VIM/vimrc.72.menu.vim
source $MY_VIM/vimrc.80.term.vim
source $MY_VIM/vimrc.81.gui.vim

SourceFile $MY_CONFIG/common/vimrc.local.vim

