"------------------------------------------------------
" vim-plug: coc
"------------------------------------------------------
let $NVIM_COC_LOG_LEVEL='debug'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

if filereadable(expand('~/.vim/coc-settings.json'))
  let g:coc_config_home = expand('~/.vim')
elseif has("win32unix") || has("win32") || has("win64")
  let g:coc_config_home = expand('$MY_VIM_WIN/coc/win')
else
  let g:coc_config_home = expand('$MY_VIM/coc/linux')
endif

if has("win32unix") || has("win32") || has("win64")
  let g:coc_data_home = expand('$MY_VIM_WIN/coc_data/win')
endif

let g:coc_disable_startup_warning = 1
"let g:coc_uri_prefix_replace_patterns = {'/home': 'C:/msys64/home'}

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

