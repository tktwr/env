" Vim syntax file
" Language: nerdtree
" Maintainer: Takehiro Tawara

syn match ntType      "Makefile"

if !exists("did_nt_syntax_inits")
  let did_nt_syntax_inits = 1
  hi ntType      guifg=#9dd970 ctermfg=2
endif

