"------------------------------------------------------
" coc
"------------------------------------------------------
let $NVIM_COC_LOG_LEVEL='debug'

if $MY_OS_NAME == 'termux'
  Plug 'neoclide/coc.nvim', {'commit': 'cf651a31736fc36c441bf307d2babff78280dd59'}  " work with node v12.22.9
else
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc.nvim', {'commit': '408e2506'}
endif

if filereadable(expand('~/.vim/coc-settings.json'))
  let g:coc_config_home = expand('~/.vim')
elseif has("win32unix") || has("win32") || has("win64")
  let g:coc_config_home = expand('$MY_VIM_WIN/coc/win')
else
  let g:coc_config_home = expand('$MY_VIM/coc/linux')
endif

let g:coc_data_home = $MY_COC_DATA_DIR

let g:coc_disable_startup_warning = 1
"let g:coc_uri_prefix_replace_patterns = {'/home': 'C:/msys64/home'}

let g:coc_status_error_sign = ' '
let g:coc_status_warning_sign = ' '

"------------------------------------------------------
" coc.func
"------------------------------------------------------
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

"------------------------------------------------------
" coc.map
"------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K  :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"------------------------------------------------------
" my
"------------------------------------------------------
"let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-pyright', 'coc-clangd', 'coc-vimlsp', 'coc-snippets', 'coc-lists']

func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-pyright coc-clangd coc-vimlsp coc-snippets coc-lists
endfunc

command           MyCocInstall     call s:MyCocInstall()
command! -nargs=0 MyCocFormat      call CocActionAsync('format')

imap <C-L>    <Plug>(coc-snippets-expand)
