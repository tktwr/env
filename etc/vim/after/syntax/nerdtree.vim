" Vim syntax file
" Language: nerdtree
" Maintainer: Takehiro Tawara

syn match ntMakefile      ".*Makefile"
syn match ntCMakeLists    ".*CMakeLists.txt"

if !exists("did_nt_syntax_inits")
  let did_nt_syntax_inits = 1
  hi ntMakefile      ctermfg=1
  hi ntCMakeLists    ctermfg=1
endif

