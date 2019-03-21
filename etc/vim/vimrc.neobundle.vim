"------------------------------------------------------
" neobundle
"------------------------------------------------------
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
  set statusline+=%{fugitive#statusline()}

  "autocmd FileType gitcommit call s:my_gitcommit_settings()
  "function! s:my_gitcommit_settings()
  "endfunction
endif

NeoBundle 'airblade/vim-gitgutter'
if neobundle#is_installed('vim-gitgutter')
  let g:gitgutter_override_sign_column_highlight = 0
  highlight SignColumn ctermbg=0
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

"NeoBundle 'Xuyuanp/nerdtree-git-plugin'
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

NeoBundle 'tyru/eskk.vim'
if neobundle#is_installed('eskk.vim')
  let g:eskk#directory = "~/.eskk"
  let g:eskk#dictionary = { 'path': "~/.eskk/skk-jisyo.user", 'sorted': 0, 'encoding': 'utf-8', }
  let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L.utf-8", 'sorted': 0, 'encoding': 'utf-8', }
endif

NeoBundle 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'godlygeek/tabular'

NeoBundle 'christoomey/vim-tmux-navigator'

"NeoBundle 'majutsushi/tagbar'

"NeoBundle 'tomasr/molokai'
"let g:molokai_original = 1
""let g:rehash256 = 1

"if !has('gui_running')
"  NeoBundle 'yuratomo/w3m.vim'
"endif

call neobundle#end()

filetype plugin indent on
syntax enable
NeoBundleCheck

func! s:GstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    resize 12
  endif
endfunc
command GstatusToggle call s:GstatusToggle()

"hi Normal guibg=#464646
"hi Normal guibg=#303030

colorscheme gruvbox
