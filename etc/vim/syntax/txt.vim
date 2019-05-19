" Vim syntax file
" Language: txt
" Maintainer: Takehiro Tawara

" Remove any old syntax stuff hanging around
syn clear
" syntax is case sensitive
syn case match

" see "help pattern"
syn match    myHtml             "<[^>]*>"
syn match    myHtml             "^http.*"

syn match    myComment          "<!--.*-->"
syn match    myComment          "#.*$"
syn match    myComment          "/\*"
syn match    myComment          "\*/"
"syn region   myComment          start="/\*" end="\*/"
"syn region   myComment          start=+(+ end=+)+

syn match    mySeparator        "^\s*--\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^\s*\~\~\+$"

syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    mySun              "½ËÆü"

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

syn match    myItem             "^\s*[-+] .*"
syn match    myItem0            "^[-+] .*"
syn match    myItem1            "^  [-+] .*"
syn match    myItem2            "^    [-+] .*"
syn match    myIdea             "^\s*-> .*"

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"
"syn region   myString           start=+"+ end=+"+ skip=+\\"+

syn match    myCitation         "^\s*>.*$"

"syn region   myType             start=+\[+ end=+\]+
syn match    myType             "^\[[^]]*\]"
"syn match    myType             "\w\+:"
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

  hi link myHtml             myPurple

  hi link myTitle            Title
  hi link myComment          Comment
  hi link myString           String
  "hi link myType             Type
  hi link myNumber           Number
  hi link myHyperTextJump    Identifier
  hi link myHyperTextEntry   String

  hi link mySeparator        myAqua
  hi link mySection1         myAqua
  hi link mySection2         myAqua
  hi link mySection3         myAqua
  hi link myItem             myGreen
  hi link myItem0            myGreen
  hi link myItem1            myGreen
  hi link myItem2            myGreen
  hi link myIdea             myPurple
  hi link myCitation         myPurple
  hi link myDate             myYellow
  hi link myTime             myYellow
  hi link mySat              myBlue
  hi link mySun              myRed

  hi myRed        ctermfg=167 guifg=#fb4934
  hi myRedBold    ctermfg=167 guifg=#fb4934 cterm=bold gui=bold
  hi myGreen      ctermfg=142 guifg=#b8bb26
  hi myGreenBold  ctermfg=142 guifg=#b8bb26 cterm=bold gui=bold
  hi myYellow     ctermfg=214 guifg=#fabd2f
  hi myYellowBold ctermfg=214 guifg=#fabd2f cterm=bold gui=bold
  hi myBlue       ctermfg=109 guifg=#707fd9
  hi myBlueBold   ctermfg=109 guifg=#707fd9 cterm=bold gui=bold
  hi myPurple     ctermfg=175 guifg=#d3869b
  hi myPurpleBold ctermfg=175 guifg=#d3869b cterm=bold gui=bold
  hi myAqua       ctermfg=108 guifg=#8ec07c
  hi myAquaBold   ctermfg=108 guifg=#8ec07c cterm=bold gui=bold
  hi myOrange     ctermfg=208 guifg=#fe8019
  hi myOrangeBold ctermfg=208 guifg=#fe8019 cterm=bold gui=bold
endif

set textwidth=0

