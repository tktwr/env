" Vim syntax file
" Language: txt
" Maintainer: Takehiro Tawara

" Remove any old syntax stuff hanging around
syn clear
" syntax is case sensitive
syn case match

" see "help pattern"
syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    mySun              "½ËÆü"

syn match    myItem             "^\s*[-+] .*"
syn match    myItem0            "^[-+] .*"
syn match    myItem1            "^  [-+] .*"
syn match    myItem2            "^    [-+] .*"
syn match    myIdea             "^\s*-> .*"

syn match    mySeparator        "^\s*--\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^\s*\~\~\+$"

syn match    myHtml             "<[^>]*>"

syn match    myComment          "#.*$"
syn match    myComment          "/\*"
syn match    myComment          "\*/"
"syn region   myComment          start="/\*" end="\*/"
"syn region   myComment          start=+(+ end=+)+
syn match    myComment          "<!--.*-->"

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"
"syn region   myString           start=+"+ end=+"+ skip=+\\"+

syn match    myCitation         "^\s*>.*$"

"syn region   myType             start=+\[+ end=+\]+
syn match    myType             "^\[[^]]*\]"
syn match    myType             "\w\+:"
syn match    myType             "@\w\+"
syn match    myNumber           "[-+]\=\d*\.\=\d\+"
syn match    myDate             "\d\+/\d\+/\d\+"
syn match    myTime             "\d\+:\d\+"

if has("ebcdic")
  syn match myHyperTextJump     "|[^"*|]\+|"
  syn match myHyperTextEntry    "\*[^"*|]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[^"*|]\+\*$"
else
  syn match myHyperTextJump     "|[#-)!+-~]\+|"
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*$"
endif

" Highlighting
" ============
if !exists("did_my_general_syntax_inits")
 " The default methods for highlighting. Can be overridden later
  let did_my_general_syntax_inits = 1

  hi link myTitle            Title
  hi link myComment          Comment
  hi link myString           String
  hi link myType             Type
  hi link myNumber           Number
  hi link myHyperTextJump    Identifier
  hi link myHyperTextEntry   String

  hi mySection1  guifg=#707fd9 ctermfg=4 cterm=bold
  hi mySection2  guifg=#707fd9 ctermfg=4 cterm=bold
  hi mySection3  guifg=#707fd9 ctermfg=4 cterm=bold
  hi mySeparator guifg=#707fd9 ctermfg=4 cterm=bold
  hi myCitation  guifg=#9f5aa0 ctermfg=5
  hi myItem      guifg=#9dd970 ctermfg=2
  hi myItem0     guifg=#9dd970 ctermfg=2
  hi myItem1     guifg=#87bb61 ctermfg=4
  hi myItem2     guifg=#719c51 ctermfg=1
  hi myIdea      guifg=#4d9ba0 ctermfg=6
  hi myDate      guifg=#fabd2f ctermfg=3 cterm=bold
  hi myTime      guifg=#fabd2f ctermfg=3 cterm=bold
  hi mySat       guifg=#707fd9 ctermfg=4 cterm=bold
  hi mySun       guifg=#d97070 ctermfg=1 cterm=bold
  hi myHtml      guifg=#fabd2f ctermfg=3
endif

set textwidth=0

