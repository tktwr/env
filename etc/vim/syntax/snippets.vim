" Snippets syntax file
" Language: snippets

syn clear

syn keyword  snipType     snippet endsnippet
syn match    snipComment  "#.*$"
syn match    snipString   '"[^"]*"'
syn match    snipString   "'[^']*'"
syn match    snipVar      "${[^}]*}"
syn match    snipVar      "$\d\+"

hi link snipType    Type
hi link snipComment Comment
hi link snipString  String
hi link snipVar     Number
