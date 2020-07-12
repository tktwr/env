"======================================================
" vim-plug
"======================================================
set complete=.,w,b,u,i

let s:use_eskk=1
let s:use_gitgutter=1
let s:use_nerdtree_git_plugin=0
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
  if &term =~ "xterm"
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

"------------------------------------------------------
" vim-plug: vim-lsp
"------------------------------------------------------
if 1
if s:use_lsp
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
endif

if s:use_asyncomplete
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

let g:lsp_diagnostics_enabled = 1     " disable diagnostics support
let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
setlocal omnifunc=lsp#complete
setlocal signcolumn=yes

if s:lsp_debug
  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('$MY_VIM/build/vim-lsp.log')
  let g:asyncomplete_log_file = expand('$MY_VIM/build/asyncomplete.log')
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
" vim-plug: vim-ref
"------------------------------------------------------
Plug 'thinca/vim-ref'

"------------------------------------------------------
" vim-plug: tagbar
"------------------------------------------------------
Plug 'majutsushi/tagbar'

"------------------------------------------------------

