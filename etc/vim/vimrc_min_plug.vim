"======================================================
" vim-plug
"======================================================
func s:InstallVimPlug()
  let plug_file = expand('$MY_VIM/autoload/plug.vim')
  let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  if empty(glob(plug_file))
    let cmd = printf("!curl --create-dirs -fL -o %s %s", plug_file, plug_url)
    silent exec cmd
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunc

"------------------------------------------------------
call s:InstallVimPlug()
call plug#begin('$MY_VIM/plugged')

" fern
if v:true
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  let g:fern#disable_default_mappings = 1
  let g:fern#renderer = 'nerdfont'
endif

" popup menu support for nvim
if has('nvim')
  Plug 'kamykn/popup-menu.nvim'
endif

" ide
Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'

Plug 'tktwr/vim-memo'
let g:memo_tags_files = [
  \ "$MY_MEMO/tags.memo",
  \ "$MY_SAMPLES/tags.memo",
  \ "$MY_LOCAL_CONFIG/memo/tags.memo",
  \ "$MY_DIARY/tags.memo",
  \ ]

" color
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

call plug#end()

"======================================================
" color
"======================================================
colorscheme gruvbox

"======================================================
" map
"======================================================
nnoremap <silent> <End>      <C-W>:call wbl#WblPrint()<CR>
tnoremap <silent> <End>      <C-W>:call wbl#WblPrint()<CR>

nnoremap <silent> <Space>    <C-W>:CpmOpen<CR>
tnoremap <silent> <C-Space>  <C-W>:CpmOpen<CR>

