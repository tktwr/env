if 0

let s:use_asyncomplete=1
let s:use_lsp=1
let s:use_lsp_pyls=1
let s:use_lsp_clangd=1
let s:use_lsp_ultisnips=1
let s:use_ultisnips=1
let s:lsp_debug=1
let s:auto_popup=1

"------------------------------------------------------
" vim-plug: vim-lsp
"------------------------------------------------------
if s:use_lsp
  Plug 'prabirshrestha/vim-lsp'
  "Plug 'mattn/vim-lsp-settings'
endif

if s:use_asyncomplete
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

let g:lsp_signs_enabled=1
let g:lsp_diagnostics_enabled=1
let g:lsp_diagnostics_echo_cursor=1
setlocal omnifunc=lsp#complete
setlocal signcolumn=yes

if s:lsp_debug
  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('$MY_VIM/build/vim-lsp.log')
  let g:asyncomplete_log_file = expand('$MY_VIM/build/asyncomplete.log')
endif

if 1
  if s:use_lsp_pyls && executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->['pyls']},
      \ 'allowlist': ['python'],
      \ })
  endif

  if s:use_lsp_clangd && executable('clangd')
    au User lsp_setup call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': {server_info->['clangd']},
      \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
  endif
endif

"------------------------------------------------------
" vim-plug: ultisnips
"------------------------------------------------------
if s:use_ultisnips
  if has('python3')
    Plug 'SirVer/ultisnips'
    "Plug 'honza/vim-snippets'
  endif

  if s:use_lsp_ultisnips && has('python3')
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor')
      \ }))
  endif
endif

"------------------------------------------------------

endif

