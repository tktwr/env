" Snippets syntax file
" Language: snippets
" Maintainer: Takehiro Tawara

syn clear

syn keyword  snipType     snippet endsnippet
syn match    snipComment  "#.*$"
syn match    snipString   '"[^"]*"'
syn match    snipString   "'[^']*'"
syn match    snipVar      "${[^}]*}"
syn match    snipVar      "$\d\+"

" Highlighting
if !exists("did_my_snippets_syntax_inits")
  let did_my_snippets_syntax_inits = 1

  hi link snipType    Type
  hi link snipComment Comment
  hi link snipString  String
  hi link snipVar     Number
endif
