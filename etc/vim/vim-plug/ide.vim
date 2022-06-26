"------------------------------------------------------
" helper functions
"------------------------------------------------------
func MyVimgrepAll(word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word '$MY_BMK/*' '$MY_BIN/**/*' '$MY_BASH/*' '$MY_VIM/*' '$MY_VIM/*/*' '$MY_VIM/plugged/vim-ide-style/**/*' '$MY_VIM/plugged/vim-bmk-menu/**/*' '$MY_VIM/plugged/vim-winbuf-menu/**/*' '$MY_VIM/plugged/vim-memo/**/*'
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

"------------------------------------------------------
" memo
"------------------------------------------------------
let g:memo_tags_files = [
  \ "$MY_MEMO/tags.memo",
  \ "$MY_SAMPLES/tags.memo",
  \ "$MY_LOCAL_CONFIG/memo/tags.memo",
  \ "$MY_DIARY/tags.memo",
  \ ]

Plug 'tktwr/vim-memo'

