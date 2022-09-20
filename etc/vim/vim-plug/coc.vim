"------------------------------------------------------
" coc
"------------------------------------------------------
let $NVIM_COC_LOG_LEVEL='debug'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'commit': 'cf651a31736fc36c441bf307d2babff78280dd59'}  " work with node v12.22.9

if filereadable(expand('~/.vim/coc-settings.json'))
  let g:coc_config_home = expand('~/.vim')
elseif has("win32unix") || has("win32") || has("win64")
  let g:coc_config_home = expand('$MY_VIM_WIN/coc/win')
else
  let g:coc_config_home = expand('$MY_VIM/coc/linux')
endif

if isdirectory(expand('~/.vim/coc_data'))
  let g:coc_data_home = expand('~/.vim/coc_data')
elseif has("win32unix") || has("win32") || has("win64")
  let g:coc_data_home = expand('$MY_VIM_WIN/coc_data/win')
else
  let g:coc_data_home = expand('$MY_VIM/coc_data/linux')
endif

let g:coc_disable_startup_warning = 1
"let g:coc_uri_prefix_replace_patterns = {'/home': 'C:/msys64/home'}

"------------------------------------------------------
" imap: coc
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

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> <CR> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"------------------------------------------------------
" my
"------------------------------------------------------
func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-pyright coc-clangd coc-vimlsp coc-snippets coc-lists
endfunc

command MyCocInstall     call s:MyCocInstall()

imap <C-L>    <Plug>(coc-snippets-expand)
