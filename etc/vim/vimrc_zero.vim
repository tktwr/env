"======================================================
" minimal vimrc without any dependencies
"======================================================
if !exists('$MY_VIM')
  let $MY_VIM = expand('~/.vim')
endif

if has('win32') || has('win64')
  if exists('$MY_VIM_WIN')
    let $MY_VIM = expand('$MY_VIM_WIN')
  endif
endif

let $MY_VIM_PLUGGED_DIR = expand('~/.mycache/vim_plugged')

set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set runtimepath^=$MY_VIM
set runtimepath+=$MY_VIM/after
"------------------------------------------------------
" basic
"------------------------------------------------------
set nocompatible
set timeoutlen=300
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936
"------------------------------------------------------
" buffer
"------------------------------------------------------
set hidden
set autowrite
set noswapfile
set nobackup
set nowritebackup
set noundofile
set viminfo=
"------------------------------------------------------
" indent
"------------------------------------------------------
set tabstop=2
set shiftwidth=2
set expandtab
"------------------------------------------------------
" term
"------------------------------------------------------
if &term =~ "xterm"
  set mouse=a
  set ttymouse=xterm2
endif
"------------------------------------------------------
" color
"------------------------------------------------------
set termguicolors
set t_Co=256
set background=dark
set hlsearch
syntax on
"======================================================
" map
"======================================================
nnoremap Q       :confirm qall<CR>
nnoremap '       `
"------------------------------------------------------
" nmap
"------------------------------------------------------
nnoremap <C-D>   <C-B>
nnoremap <C-E>   :close<CR>
nnoremap <C-G>   <C-L>
nnoremap <C-;>   <C-W>:
nnoremap <C-.>   :exec "lcd" expand("%:p:h")<CR>
"------------------------------------------------------
" tmap
"------------------------------------------------------
tnoremap <C-G>   <C-L>
tnoremap <C-O>   <C-W>N
tnoremap <C-;>   <C-W>:
tnoremap <ScrollWheelUp>  <C-W>N<ScrollWheelUp>
"------------------------------------------------------
" map: window
"------------------------------------------------------
nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>w
tnoremap <C-K>   <C-W>W
tnoremap <C-L>   <C-W>l
"------------------------------------------------------
" map: tab
"------------------------------------------------------
nnoremap <silent> <Insert>   <C-W>:tabedit<CR>
nnoremap <silent> <Del>      <C-W>:tabclose<CR>
nnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
nnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>

tnoremap <silent> <Insert>   <C-W>:tabedit<CR>
tnoremap <silent> <Del>      <C-W>:tabclose<CR>
tnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
tnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>
"------------------------------------------------------
" map: clipboard
"------------------------------------------------------
nnoremap ,p      "*p
vnoremap Y       "*y
"======================================================
" nvim
"======================================================
if has('nvim')
tnoremap <C-H>   <C-\><C-N><C-W>h
tnoremap <C-J>   <C-\><C-N><C-W>w
tnoremap <C-K>   <C-\><C-N><C-W>W
tnoremap <C-L>   <C-\><C-N><C-W>l

tnoremap <C-O>   <C-\><C-N>
endif
"======================================================
" gui
"======================================================
if has("gui_running")
  set guifont=HackGen_Console_NF:h14
  set guioptions-=T
endif
"------------------------------------------------------
" color
"------------------------------------------------------
"hi Normal ctermfg=223 ctermbg=236 guifg=#ebdbb2 guibg=#32302f
colorscheme darkblue
syntax on
"======================================================
" netrw
"======================================================
func s:netrw_view_in_next_win(fname)
  let fname = printf("%s/%s", expand('%'), expand(a:fname))

  call feedkeys("\<Plug>NetrwRefresh")
  if (isdirectory(fname))
    call feedkeys("\<Plug>NetrwLocalBrowseCheck")
  elseif (filereadable(fname))
    wincmd w
    exec "edit" fname
    wincmd p
  endif
endfunc

func s:netrw_settings()
  "mapclear <buffer>
  nmap     <buffer> h         <Plug>NetrwBrowseUpDir
  nnoremap <buffer> l         :call <SID>netrw_view_in_next_win('<cfile>')<CR>
endfunc

func s:netrw_ide()
  30vsp +e .
  wincmd w
  below term
  wincmd 1
endfunc

augroup ag_netrw
  autocmd!
  autocmd FileType netrw      call s:netrw_settings()
augroup END
"------------------------------------------------------
filetype plugin on
let g:netrw_banner=0
command NetrwIDE call s:netrw_ide()
