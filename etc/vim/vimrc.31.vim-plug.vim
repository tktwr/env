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

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'
let g:fugitive_git_executable=$MY_GIT_EXE
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
" quickhl
Plug 't9md/vim-quickhl'
nmap <C-U> <Plug>(quickhl-manual-this)
xmap <C-U> <Plug>(quickhl-manual-this)
nmap <C-Y> <Plug>(quickhl-manual-reset)
xmap <C-Y> <Plug>(quickhl-manual-reset)

"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
" easymotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap <C-P> <Plug>(easymotion-overwin-line)

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
" vim-plug: vim-which-key
"------------------------------------------------------
Plug 'liuchengxu/vim-which-key'

"------------------------------------------------------