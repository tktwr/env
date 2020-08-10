call plug#end()

function! s:MyNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  else
    "NERDTreeFind
    NERDTreeToggle
  endif
endfunction
command MyNERDTreeToggle call s:MyNERDTreeToggle()

function! s:MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    resize 12
  endif
endfunction
command MyGstatusToggle call s:MyGstatusToggle()

colorscheme gruvbox
set background=dark

