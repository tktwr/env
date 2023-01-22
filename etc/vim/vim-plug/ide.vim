"------------------------------------------------------
" helper functions
"------------------------------------------------------
func MyVimgrepAll(word)
  let word = vis#util#prompt("Word? ", a:word)
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
  "Plug 'kamykn/popup-menu.nvim'

  Plug 'Ajnasz/vim-popup-menu'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
endif

Plug 'thinca/vim-ref'

"------------------------------------------------------
" vim-winbuf-menu
"------------------------------------------------------
let g:wbl_key = "\<End>"
let g:wbl_max = 10

Plug 'tktwr/vim-winbuf-menu'
"------------------------------------------------------
" vim-bmk-menu
"------------------------------------------------------
let g:bmk_winwidth = g:my_left_winwidth
let g:bmk_edit_dir_func = "VisFern"
let g:bmk_open_url_prog = "chrome.sh"
let g:bmk_open_dir_prog = "te.sh"
let g:bmk_open_file_prog = "vscode.sh"

let g:cpm_key = "\<Space>"
let g:cpm_term_key = "\<C-Space>"
let g:cpm_user_bmk_dir = '$MY_DOTMY/bmk/bmk_dir.txt'
let g:cpm_user_bmk_file = '$MY_DOTMY/bmk/bmk_file.txt'
let g:cpm_files = 
  \ split(glob("$MY_BMK/*.txt")) +
  \ split(glob("$MY_COMMON_SETTING/bmk/*.txt"))
let g:cpm_titles = {
  \ 'default'          : ['vcmd.menu & vcmd.external & vcmd.ide', 'vcmd.sub'],
  \ 'default.fern'     : ['fern.menu & fern.external & local.bmk.dir & bmk.dir', 'bmk.dir.sys'],
  \ 'default.terminal' : ['tcmd.menu & tcmd.main & local.bmk.dir', 'tcmd.sub'],
  \ 'default.diff'     : ['vcmd.diff'],
  \ 'default.dirdiff'  : ['vcmd.dirdiff'],
  \ 'default.git'      : ['vcmd.git'],
  \ 'default.fugitive' : ['vcmd.fugitive'],
  \ 'ref'              : ['ref.main', 'ref.keys', 'ref.keys2', 'papers', 'links', 'local.links'],
  \ 'ref.terminal'     : ['ref.main'],
  \ 'coc'              : ['coc'],
  \ 'fern'             : ['fern'],
  \ 'tcmd.git'         : ['tcmd.git'],
  \ 'tcmd.system'      : ['tcmd.system'],
  \ }

Plug 'tktwr/vim-bmk-menu'
"------------------------------------------------------
" vim-ide-style
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
  \ '$MY_BASH',
  \ '$MY_VIM',
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

Plug 'tktwr/vim-ide-style'
"------------------------------------------------------
" vim-memo
"------------------------------------------------------
let g:memo_tags_files = [
  \ "$MY_MEMO/tags.memo",
  \ "$MY_SAMPLES/tags.memo",
  \ "$MY_LOCAL_CONFIG/memo/tags.memo",
  \ "$MY_DIARY/tags.memo",
  \ ]

Plug 'tktwr/vim-memo'
