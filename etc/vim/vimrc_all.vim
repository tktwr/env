let $MY_CONFIG=expand("$HOME/MyConfig")
let $MY_VIM=expand("$MY_CONFIG/tktwr.github/env/etc/vim")

source $MY_VIM/vimrc_start.vim

SourceFile $MY_VIM/vimrc.00.init.vim
SourceFile $MY_VIM/vimrc.01.my.vim
SourceFile $MY_VIM/vimrc.10.skel.vim
SourceFile $MY_VIM/vimrc.30.vim-plug.vim
SourceFile $MY_VIM/vimrc.40.highlight.vim
SourceFile $MY_VIM/vimrc.41.statusline.vim
SourceFile $MY_VIM/vimrc.42.tabline.vim
SourceFile $MY_VIM/vimrc.50.func.vim
SourceFile $MY_VIM/vimrc.60.command.vim
SourceFile $MY_VIM/vimrc.61.enc.vim
SourceFile $MY_VIM/vimrc.63.dev.vim
SourceFile $MY_VIM/vimrc.64.edit.vim
SourceFile $MY_VIM/vimrc.65.window.vim
SourceFile $MY_VIM/vimrc.66.external.vim
SourceFile $MY_VIM/vimrc.67.terminal.vim
SourceFile $MY_VIM/vimrc.68.ide.vim
SourceFile $MY_VIM/vimrc.70.map.vim
SourceFile $MY_VIM/vimrc.72.menu.vim
SourceFile $MY_VIM/vimrc.80.term.vim
SourceFile $MY_VIM/vimrc.81.gui.vim

SourceFile $MY_COMMON_SETTING/vimrc.local.vim

