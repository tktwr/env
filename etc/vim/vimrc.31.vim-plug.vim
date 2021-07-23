"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

Plug 'tomasr/molokai'
let g:molokai_original = 1
"let g:rehash256 = 1

Plug 'octol/vim-cpp-enhanced-highlight'

"------------------------------------------------------
" vim-plug: fern
"------------------------------------------------------
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <CR>  <Plug>(fern-my-open-expand-collapse)

  nmap <buffer> N     <Plug>(fern-action-new-path)
  nmap <buffer> D     <Plug>(fern-action-remove)
  nmap <buffer> M     <Plug>(fern-action-move)
  nmap <buffer> R     <Plug>(fern-action-rename)

  nmap <buffer> <C-G> <Plug>(fern-action-reload)
  nmap <buffer> ?     <Plug>(fern-action-help)
  nmap <buffer> !     <Plug>(fern-action-hidden)
  nmap <buffer> m     <Plug>(fern-action-mark)
  nmap <buffer> s     <Plug>(fern-action-open:split)
  nmap <buffer> v     <Plug>(fern-action-open:vsplit)

  nmap <buffer> h     <Plug>(fern-action-collapse)
  nmap <buffer> l     <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> j     +
  nmap <buffer> k     -

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

"------------------------------------------------------
" vim-plug: IDE
"------------------------------------------------------
Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize = g:my_left_winwidth
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 0
let g:NERDTreeIgnore = ['NTUSER\.', 'ntuser\.', '\.lnk$', '\.url', 'desktop\.ini']

Plug 'majutsushi/tagbar'
let g:tagbar_width = g:my_right_winwidth
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_sort = 0

Plug 'thinca/vim-ref'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"Plug 'ctrlpvim/ctrlp.vim'

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'
let g:fugitive_git_executable=$MY_GIT_EXE
autocmd QuickFixCmdPost *grep* below cwindow

if s:use_gitgutter
  if &term =~ "xterm"
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_map_keys = 0
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

Plug 'cohama/agit.vim'

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

"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
" easymotion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDMenuMode=0
let g:NERDCreateDefaultMappings=0

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
