"------------------------------------------------------
" vim-plug: coc
"------------------------------------------------------
let $NVIM_COC_LOG_LEVEL='debug'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

if filereadable(expand('~/.vim/coc-settings.json'))
  let g:coc_config_home = expand('~/.vim')
elseif has("win32unix") || has("win32") || has("win64")
  let g:coc_config_home = expand('$MY_VIM/coc/win')
else
  let g:coc_config_home = expand('$MY_VIM/coc/linux')
endif

if has("win32unix") || has("win32") || has("win64")
  let g:coc_data_home = expand('$MY_VIM/coc_data/win')
endif

let g:coc_disable_startup_warning = 1
"let g:coc_uri_prefix_replace_patterns = {'/home': 'C:/msys64/home'}

nmap <silent> gh :call CocAction('doHover')<CR>
nmap <silent> gD :CocDiagnostics<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <silent> gR <Plug>(coc-rename)

" Formatting selected code.
xmap <silent> gF <Plug>(coc-format-selected)
nmap <silent> gF <Plug>(coc-format-selected)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"------------------------------------------------------
" coc-explorer
"------------------------------------------------------
nmap <space>e :CocCommand explorer<CR>

"------------------------------------------------------
" coc-snippets
"------------------------------------------------------
imap <C-l> <Plug>(coc-snippets-expand)

"------------------------------------------------------
