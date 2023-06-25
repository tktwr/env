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
let g:cpm_term_key = "\<End>"
let g:cpm_user_bmk_dir = '$MY_DOTMY/bmk/bmk_dir.txt'
let g:cpm_user_bmk_file = '$MY_DOTMY/bmk/bmk_file.txt'
let g:cpm_files = 
  \ split(glob("$MY_BMK/*.txt")) +
  \ split(glob("$MY_COMMON_SETTING/bmk/*.txt"))
let g:cpm_titles = {
  \ 'default'          : ['vcmd.external & vcmd.fzf & vcmd.ide', 'vcmd.sub', 'coc'],
  \ 'default.fern'     : ['fern.external & fern.fzf & bmk.dir', 'fern'],
  \ 'default.terminal' : ['tcmd.fzf & tcmd.main'],
  \ 'default.diff'     : ['vcmd.diff'],
  \ 'default.dirdiff'  : ['vcmd.dirdiff'],
  \ 'default.git'      : ['vcmd.git'],
  \ 'default.fugitive' : ['vcmd.fugitive'],
  \ 'coc'              : ['coc'],
  \ 'fern'             : ['fern'],
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
  \ '$MY_ROAMING',
  \ '$MY_CONFIG',
  \ '$MY_SHARE',
  \ '$USER_LOCAL',
  \ '$USER_ROAMING',
  \ '$SYS_WIN_HOME',
  \ '$SYS_PROG64_DIR',
  \ '$SYS_PROG32_DIR',
  \ '$BLENDER_ADDONS_DIR',
  \ ]

let g:my_rg_dirs = [
  \ '$MY_ENV',
  \ '$MY_VIM_PLUGGED_DIR/vim-ide-style',
  \ '$MY_VIM_PLUGGED_DIR/vim-bmk-menu',
  \ '$MY_VIM_PLUGGED_DIR/vim-winbuf-menu',
  \ '$MY_VIM_PLUGGED_DIR/vim-memo',
  \ ]

Plug 'tktwr/vim-ide-style'
"------------------------------------------------------
" vim-memo
"------------------------------------------------------
let g:memo_tags_files = [
  \ "$MY_MEMO/tags",
  \ "$MY_SAMPLES/tags",
  \ "$MY_DIARY/tags",
  \ "$MY_LOCAL_CONFIG/memo/tags",
  \ ]

Plug 'tktwr/vim-memo'
