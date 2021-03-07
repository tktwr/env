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
    exec "resize" g:my_gstatus_winheight
  endif
endfunction

func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-python coc-clangd coc-snippets coc-lists
endfunc

command MyNERDTreeToggle call s:MyNERDTreeToggle()
command MyGstatusToggle  call s:MyGstatusToggle()
command MyCocInstall     call s:MyCocInstall()

"------------------------------------------------------
" colorscheme
"------------------------------------------------------
colorscheme gruvbox

