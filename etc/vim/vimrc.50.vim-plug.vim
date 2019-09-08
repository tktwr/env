"======================================================
" vim-plug
"======================================================
set complete=.,w,b,u,i

let s:use_eskk=1
let s:use_gitgutter=1
let s:use_nerdtree_git_plugin=1
let s:use_asyncomplete=1
let s:use_lsp=1
let s:use_lsp_pyls=1
let s:use_lsp_ccls=0
let s:use_lsp_clangd=0
let s:use_lsp_ultisnips=1
let s:use_ultisnips=1
let s:lsp_debug=1
let s:auto_popup=1

let g:fugitive_git_executable=$MY_GIT_EXE
let g:lsp_diagnostics_echo_cursor=1
let g:NERDTreeShowGitStatus=1
let g:NERDTreeShowIgnoredStatus=0
let g:NERDTreeGitStatusIgnoreSubmodules=1

if empty(glob('$MY_VIM/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$MY_VIM/plugged')

"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

Plug 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

"------------------------------------------------------
" vim-plug: file
"------------------------------------------------------
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

"Plug 'ctrlpvim/ctrlp.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow

if s:use_gitgutter
  if &term == "xterm"
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_override_sign_column_highlight = 0
    highlight SignColumn ctermbg=0
  endif
endif

if s:use_nerdtree_git_plugin
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeIndicatorMapCustom = {
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
  nmap D O
endfunction

Plug 'cohama/agit.vim'
let g:agit_enable_auto_show_commit = 0
autocmd FileType agit_stat call s:my_agit_stat_settings()
function! s:my_agit_stat_settings()
  nmap <buffer> <silent> D <Plug>(agit-diff)
  nmap <buffer> <silent> <2-LeftMouse> <Plug>(agit-diff)
endfunction

"------------------------------------------------------
" vim-plug: diff
"------------------------------------------------------
Plug 'will133/vim-dirdiff'
"let g:DirDiffForceLang = "en"
let g:DirDiffExcludes = ".git,.svn,*.swp,*.o,*.exe,*.class,build.ninja,build.make,build.vs2017,Release,Debug,*.png,*.jpg,*.bmp"
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
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor')
      \ }))
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
" vim-plug: supertab
"------------------------------------------------------
"Plug 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType = "context"

"------------------------------------------------------
" vim-plug: deoplete
"------------------------------------------------------
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"let g:deoplete#enable_at_startup = 1

"------------------------------------------------------
" vim-plug: unused
"------------------------------------------------------
if 0
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'godlygeek/tabular'
  Plug 'majutsushi/tagbar'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  if !has('gui_running')
    Plug 'yuratomo/w3m.vim'
  endif
endif

call plug#end()

function! s:GstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    resize 12
  endif
endfunction
command GstatusToggle call s:GstatusToggle()

colorscheme gruvbox
set background=dark

