"------------------------------------------------------
" plugin
"------------------------------------------------------
Plug 'thinca/vim-ref'

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0  " Disable default mappings
let g:EasyMotion_smartcase  = 1  " Turn on case-insensitive feature
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
  \ '$MY_DESKTOP',
  \ '$MY_DOWNLOADS',
  \ '$USER_LOCAL',
  \ '$USER_ROAMING',
  \ '$SYS_ROAMING_HOME',
  \ '$SYS_CONFIG_HOME',
  \ '$SYS_WORK_HOME',
  \ '$SYS_PROJ_HOME',
  \ '$SYS_DATA_HOME',
  \ '$SYS_WIN_HOME',
  \ '$SYS_PROG64_DIR',
  \ '$SYS_PROG32_DIR',
  \ '$BLENDER_ADDONS_DIR',
  \ ]
let g:my_rg_dirs = [
  \ '$MY_ENV',
  \ '$MY_COMMON_SETTING',
  \ '$MY_VIM_PLUGGED_DIR/vim-ide-style',
  \ '$MY_VIM_PLUGGED_DIR/vim-memo',
  \ ]
let g:wbl_max = 10
let g:bmk_winwidth = g:my_left_winwidth
let g:bmk_edit_dir_func = "VisFern"
let g:bmk_open_url_prog = "open_web.sh"
let g:bmk_open_dir_prog = "open_dir.sh"
let g:bmk_open_file_prog = "open_file.sh"

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
