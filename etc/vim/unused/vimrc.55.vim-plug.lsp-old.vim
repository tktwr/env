if 0

"------------------------------------------------------
" vim-plug: asyncomplete
"------------------------------------------------------
if s:use_asyncomplete
  Plug 'prabirshrestha/asyncomplete.vim'
  "set completeopt=menu,noinsert,noselect
  "let g:asyncomplete_auto_completeopt = 0

  "inoremap <expr> <Tab>   pumvisible() ? "\<C-N>" : "\<Tab>"
  "inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
  inoremap <expr> <CR>    pumvisible() ? "\<C-Y>" : "\<CR>"
  "imap <S-Tab> <Plug>(asyncomplete_force_refresh)

  "set completeopt+=preview
  "autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  if !s:auto_popup
    let g:asyncomplete_auto_popup = 0
    inoremap <expr> <S-Tab>
      \ pumvisible() ? "\<C-N>" :
      \ asyncomplete#force_refresh()
  endif

  if 0
    " disable auto popup
    let g:asyncomplete_auto_popup = 0
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ asyncomplete#force_refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  endif
endif

"------------------------------------------------------
" vim-plug: vim-lsp
"------------------------------------------------------
if s:use_lsp
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  if s:lsp_debug
    " debug
    let g:lsp_log_verbose = 1
    let g:lsp_log_file = expand('$MY_VIM/build/vim-lsp.log')
    let g:asyncomplete_log_file = expand('$MY_VIM/build/asyncomplete.log')
  endif

  " Key bindings for vim-lsp.
  nn <silent> <M-d> :LspDefinition<cr>
  nn <silent> <M-r> :LspReferences<cr>
  nn <silent> <M-n> :LspRename<cr>
  nn <silent> <M-w> :LspWorkspaceSymbol<cr>
  nn <silent> <M-s> :LspDocumentSymbol<cr>

  if s:use_lsp_pyls && executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->['pyls']},
      \ 'whitelist': ['python'],
      \ })
  endif

  " Register ccls C++ lanuage server.
  if s:use_lsp_ccls && executable('ccls')
     au User lsp_setup call lsp#register_server({
       \ 'name': 'ccls',
       \ 'cmd': {server_info->['ccls']},
       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
       \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
       \ })
  endif

  " Register clangd C++ lanuage server.
  if s:use_lsp_clangd && executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
  endif
endif

endif

