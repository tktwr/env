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

call s:InstallVimPlug()

"------------------------------------------------------
func PlugFern()
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  let g:fern#disable_default_mappings = 1
  let g:fern#renderer = 'nerdfont'
endfunc

func PlugIDE()
  if has('nvim')
    Plug 'Ajnasz/vim-popup-menu'
  endif

  Plug 'tktwr/vim-winbuf-menu'
  Plug 'tktwr/vim-bmk-menu'
  Plug 'tktwr/vim-ide-style'
endfunc

func PlugColor()
  Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark = "soft"
endfunc

"======================================================
" main
"======================================================
call plug#begin($MY_VIM_PLUGGED_DIR)

call PlugFern()
call PlugIDE()
call PlugColor()

call plug#end()

"------------------------------------------------------
" color
"------------------------------------------------------
colorscheme gruvbox

"------------------------------------------------------
" map
"------------------------------------------------------
nnoremap <silent> <End>      <C-W>:call wbl#open()<CR>
tnoremap <silent> <End>      <C-W>:call wbl#open()<CR>

nnoremap <silent> <Space>    <C-W>:CpmOpen<CR>
tnoremap <silent> <C-Space>  <C-W>:CpmOpen<CR>
