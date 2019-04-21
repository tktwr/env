"------------------------------------------------------
" vim-plug
"------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"------------------------------------------------------
" vim-plug: color
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

"------------------------------------------------------
" vim-plug: file
"------------------------------------------------------
Plug 'scrooloose/nerdtree'
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

"------------------------------------------------------
" vim-plug: git
"------------------------------------------------------
Plug 'tpope/vim-fugitive'
autocmd QuickFixCmdPost *grep* cwindow

if &term == "xterm"
  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_override_sign_column_highlight = 0
  highlight SignColumn ctermbg=0
endif

Plug 'cohama/agit.vim'
let g:agit_enable_auto_show_commit = 0
autocmd FileType agit_stat call s:my_agit_stat_settings()
function! s:my_agit_stat_settings()
  nmap <buffer> <silent> D <Plug>(agit-diff)
  nmap <buffer> <silent> <2-LeftMouse> <Plug>(agit-diff)
endfunction

Plug 'Xuyuanp/nerdtree-git-plugin'
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

"------------------------------------------------------
" vim-plug: diff
"------------------------------------------------------
Plug 'will133/vim-dirdiff'
"let g:DirDiffForceLang = "en"
let g:DirDiffExcludes = ".git,.svn,*.swp,*.o,*.exe,*.class,Release,Debug,*.png,*.jpg,*.bmp"
let g:DirDiffAddArgs = "-bwBEZ" 

"------------------------------------------------------
" vim-plug: edit
"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'

"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
nmap S <Plug>(easymotion-overwin-f2)

"------------------------------------------------------
" vim-plug: unused
"------------------------------------------------------
if 0
  Plug 'tyru/eskk.vim'
  let g:eskk#directory = "~/.eskk"
  let g:eskk#dictionary = { 'path': "~/.eskk/skk-jisyo.user", 'sorted': 0, 'encoding': 'utf-8', }
  let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L.utf-8", 'sorted': 0, 'encoding': 'utf-8', }

  Plug 'christoomey/vim-tmux-navigator'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  let g:UltiSnipsEditSplit="vertical"

  Plug 'godlygeek/tabular'
  Plug 'majutsushi/tagbar'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tomasr/molokai'
  let g:molokai_original = 1
  "let g:rehash256 = 1

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
