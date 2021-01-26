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

