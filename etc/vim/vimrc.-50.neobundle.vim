"======================================================
" neobundle
"======================================================
if has('vim_starting')
  let plugin_dir = "~/.vim_neobundle"
  let neobundle_dir = plugin_dir . "/neobundle.vim"
  if !isdirectory(expand(neobundle_dir))
    echo "install neobundle..."
    call system("git clone https://github.com/Shougo/neobundle.vim.git " . neobundle_dir)
  endif
  exec "set runtimepath+=".expand(neobundle_dir)
endif

call neobundle#begin(expand(plugin_dir))
let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'
if neobundle#is_installed('vim-fugitive')
  autocmd QuickFixCmdPost *grep* cwindow
endif

if &term == "xterm"
  NeoBundle 'airblade/vim-gitgutter'
  if neobundle#is_installed('vim-gitgutter')
    let g:gitgutter_override_sign_column_highlight = 0
    highlight SignColumn ctermbg=0
  endif
endif

NeoBundle 'cohama/agit.vim'
if neobundle#is_installed('agit.vim')
  let g:agit_enable_auto_show_commit = 0
  autocmd FileType agit_stat call s:my_agit_stat_settings()
  function! s:my_agit_stat_settings()
    nmap <buffer> <silent> D <Plug>(agit-diff)
    nmap <buffer> <silent> <2-LeftMouse> <Plug>(agit-diff)
    "nmap <buffer> <silent> D di
    "nmap <buffer> <silent> <2-LeftMouse> di
  endfunction
endif

NeoBundle 'scrooloose/nerdtree'
if neobundle#is_installed('nerdtree')
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'
endif

NeoBundle 'Xuyuanp/nerdtree-git-plugin'
if neobundle#is_installed('nerdtree-git-plugin')
  "let g:NERDTreeShowIgnoredStatus = 1
  let g:NERDTreeIndicatorMapCustom = {
      \ 'Modified'  : 'M',
      \ 'Staged'    : 'S',
      \ 'Untracked' : 'U',
      \ 'Renamed'   : 'R',
      \ 'Unmerged'  : 'm',
      \ 'Deleted'   : 'D',
      \ 'Dirty'     : 'X',
      \ 'Clean'     : 'C',
      \ 'Ignored'   : 'I',
      \ 'Unknown'   : 'u'
      \ }
endif

NeoBundle 'will133/vim-dirdiff'
if neobundle#is_installed('vim-dirdiff')
  "let g:DirDiffForceLang = "en"
  let g:DirDiffExcludes = ".git,.svn,*.swp,*.o,*.exe,*.class,Release,Debug,*.png,*.jpg,*.bmp"
  let g:DirDiffAddArgs = "-bwBEZ" 
endif

NeoBundle 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'godlygeek/tabular'

NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'

NeoBundle 'easymotion/vim-easymotion'
if neobundle#is_installed('vim-easymotion')
  let g:EasyMotion_do_mapping = 0
  " Jump to first match with enter & space
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  nmap S <Plug>(easymotion-overwin-f2)
  "map f <Plug>(easymotion-fl)
  "map t <Plug>(easymotion-tl)
  "map F <Plug>(easymotion-Fl)
  "map T <Plug>(easymotion-Tl)
endif

if 0
  NeoBundle 'tyru/eskk.vim'
  if neobundle#is_installed('eskk.vim')
    let g:eskk#directory = "~/.eskk"
    let g:eskk#dictionary = { 'path': "~/.eskk/skk-jisyo.user", 'sorted': 0, 'encoding': 'utf-8', }
    let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L.utf-8", 'sorted': 0, 'encoding': 'utf-8', }
  endif

  NeoBundle 'christoomey/vim-tmux-navigator'

  NeoBundle 'SirVer/ultisnips'
  NeoBundle 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  let g:UltiSnipsEditSplit="vertical"

  NeoBundle 'majutsushi/tagbar'

  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'vim-airline/vim-airline-themes'

  NeoBundle 'tomasr/molokai'
  let g:molokai_original = 1
  "let g:rehash256 = 1

  if !has('gui_running')
    NeoBundle 'yuratomo/w3m.vim'
  endif
endif

call neobundle#end()

filetype plugin indent on
syntax enable

NeoBundleCheck

function! s:GstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    resize 12
  endif
endfunction
command GstatusToggle call s:GstatusToggle()

"hi Normal guibg=#464646
"hi Normal guibg=#303030

colorscheme gruvbox
set background=dark
