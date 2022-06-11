"------------------------------------------------------
" helper functions
"------------------------------------------------------
func MyVimgrepAll(word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word '$MY_BMK/*.txt' '$MY_BIN/*.sh' '$MY_BASH/*.sh' '$MY_VIM/*.vim' '$MY_VIM/plugin/*.vim' '$MY_VIM/plugged/vim-ide-style/**/*.vim' '$MY_VIM/plugged/vim-bmk-menu/**/*.vim' '$MY_VIM/plugged/vim-winbuf-menu/**/*.vim'
endfunc

"------------------------------------------------------
" plugin
"------------------------------------------------------
" popup menu support for nvim
if has('nvim')
  Plug 'kamykn/popup-menu.nvim'
endif

Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'
Plug 'tktwr/vim-memo'
Plug 'thinca/vim-ref'

"------------------------------------------------------
" global variables
"------------------------------------------------------
let g:vis_unexpand_env_list = [
  \ '$MY_PAPERS',
  \ '$MY_GIT',
  \ '$MY_GITHUB',
  \ '$MY_WORK',
  \ '$MY_PROJ',
  \ '$MY_DOC',
  \ '$MY_OFFICE',
  \ '$MY_DIARY',
  \ '$MY_MEMO',
  \ '$MY_ETC',
  \ '$MY_ENV',
  \ '$MY_REMOTE_CONFIG',
  \ '$MY_LOCAL_CONFIG',
  \ '$MY_PRIVATE_CONFIG',
  \ '$MY_PRIVATE',
  \ '$MY_PROTECTED',
  \ '$MY_PUBLIC',
  \ '$MY_DESKTOP',
  \ '$MY_DOWNLOADS',
  \ ]

let g:memo_tags_files = [
  \ "$MY_REMOTE_CONFIG/memo/tags.memo",
  \ "$MY_REMOTE_CONFIG/samples/tags.memo",
  \ "$MY_LOCAL_CONFIG/memo/tags.memo",
  \ "$MY_DIARY/tags.memo",
  \ ]

