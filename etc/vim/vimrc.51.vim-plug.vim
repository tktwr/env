"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

Plug 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

"------------------------------------------------------
" vim-plug: IDE
"------------------------------------------------------
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2
let g:NERDTreeAutoDeleteBuffer=1

autocmd FileType nerdtree call s:my_nerdtree_settings()
function! s:my_nerdtree_settings()
  nmap <buffer> <Tab> C
endfunction

Plug 'majutsushi/tagbar'

Plug 'thinca/vim-ref'

"Plug 'ctrlpvim/ctrlp.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow

if s:use_gitgutter
  if &term =~ "xterm"
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_override_sign_column_highlight = 0
    highlight SignColumn ctermbg=0
  endif
endif

if s:use_nerdtree_git_plugin
  Plug 'Xuyuanp/nerdtree-git-plugin'
  "let g:NERDTreeShowGitStatus=1
  "let g:NERDTreeShowIgnoredStatus=0
  "let g:NERDTreeGitStatusIgnoreSubmodules=1
  "let g:NERDTreeIndicatorMapCustom = {

  let g:NERDTreeGitStatusEnable=1
  let g:NERDTreeGitStatusShowIgnored=0
  let g:NERDTreeGitStatusIgnoreSubmodules=1
  let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  : 'M',
      \ 'Staged'    : 'S',
      \ 'Untracked' : 'U',
      \ 'Renamed'   : 'R',
      \ 'Unmerged'  : 'm',
      \ 'Deleted'   : 'D',
      \ 'Dirty'     : '!',
      \ 'Clean'     : 'C',
      \ 'Ignored'   : 'I',
      \ 'Unknown'   : 'u'
      \ }
endif

Plug 'junegunn/gv.vim'
autocmd FileType git call s:my_gv_settings()
function! s:my_gv_settings()
  nmap <buffer> D O
endfunction

"------------------------------------------------------
" vim-plug: diff
"------------------------------------------------------
Plug 'will133/vim-dirdiff'
"let g:DirDiffForceLang = "en"
let g:DirDiffExcludes = ".git,.svn,*.swp,*.o,*.exe,*.class,build.*,Release,Debug,*.png,*.jpg,*.bmp"
let g:DirDiffAddArgs = "-bwBEZ" 

"------------------------------------------------------
" vim-plug: highlight
"------------------------------------------------------
Plug 't9md/vim-quickhl'

"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
Plug 'easymotion/vim-easymotion'
Plug 'yuttie/comfortable-motion.vim'

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDMenuMode=0

Plug 'godlygeek/tabular'

"------------------------------------------------------
" vim-plug: coc
"------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gh :call CocAction('doHover')<CR>

imap <C-l> <Plug>(coc-snippets-expand)

set signcolumn=yes
let g:coc_disable_startup_warning = 1
"let g:coc_uri_prefix_replace_patterns = {'/Users': '/home'}

"------------------------------------------------------
" vim-plug: vim-lsp
"------------------------------------------------------
if 0

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

endif

"------------------------------------------------------
" vim-plug: eskk
"------------------------------------------------------
if s:use_eskk
  Plug 'tyru/eskk.vim'
  let g:eskk#directory = "~/.eskk"
  let g:eskk#dictionary = { 'path': "~/.eskk/skk-jisyo.user", 'sorted': 0, 'encoding': 'utf-8', }
  let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L.utf-8", 'sorted': 0, 'encoding': 'utf-8', }
endif

"------------------------------------------------------
" vim-plug: icons
"------------------------------------------------------
if has("gui_running")
  Plug 'ryanoasis/vim-devicons'
  "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif

"------------------------------------------------------
