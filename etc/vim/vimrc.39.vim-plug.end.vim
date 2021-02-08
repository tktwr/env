call plug#end()

function! s:MyNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    NERDTreeFind
  endif
endfunction

function! s:MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    resize 12
  endif
endfunction

command MyNERDTreeToggle call s:MyNERDTreeToggle()
command MyGstatusToggle  call s:MyGstatusToggle()

colorscheme gruvbox

"------------------------------------------------------
" custom map for plugins
"------------------------------------------------------

nnoremap <TAB> :MyNERDTreeToggle<CR>

nmap <BS> <Plug>(easymotion-overwin-line)

nmap <C-U> <Plug>(quickhl-manual-this)
xmap <C-U> <Plug>(quickhl-manual-this)
nmap <C-Y> <Plug>(quickhl-manual-reset)
xmap <C-Y> <Plug>(quickhl-manual-reset)

