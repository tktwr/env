" Vim syntax file
" Language: txt
" see "help pattern"

"------------------------------------------------------
" syntax
"
" later rules override earlier rules
"------------------------------------------------------
syn clear
" syntax is case sensitive
syn case match

syn region   myDetails          start=+<details>+ end=+</details>+

"syn match    myColon            "\f\+:"
syn match    myColon            ".\+: "
syn match    myItem             "^\s*[-+*] "
syn match    myCitation         "^\s*>.*$"

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"
syn match    myHtml             "<[^>]*>"
syn match    myUrl              "http://.*"
syn match    myUrl              "https://.*"
syn match    myDir              "[/\.\-0-9A-Za-z_]\+/"
syn match    myVar              "\$\w\+"

syn match    mySeparator        "<!--.*-->"
syn match    mySeparator        "^\s*\~\~\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^#==\+$"

syn match    mySeparator2       "^\s*--\+$"
syn match    mySeparator2       "^#--\+$"

syn match    myDate             "\d\{1,2}/\d\{1,2}"
syn match    myDate             "\d\{4}/\d\{2}/\d\{2}"
syn match    myTime             "\d\{1,2}:\d\{1,2}"
syn match    myTime             "\d\{1,2}:\d\{1,2}:\d\{1,2}"
syn keyword  mySat              Sat
syn keyword  mySun              Sun
syn keyword  myHoliday          祝日
syn keyword  myHoliday          Holiday

syn match    myTag              "\[[^]]*\]" contains=myDate,myWORK,myINFO,myTODO,myOK,myFAIL
syn match    myTagR             '([^)]*)' contains=mySat,mySun
syn match    myTagC             '{[^}]*}'
syn match    myIcon             '[-﵆]'

syn keyword  myWORK             WORK contained
syn keyword  myINFO             INFO contained
syn keyword  myTODO             TODO
syn keyword  myOK               OK DONE FIXED SOLVED contained
syn keyword  myFAIL             FAIL CANCEL OBSOLETE contained

syn keyword  mykRed             LCtrl PgUp up prev wsl vim
syn keyword  mykGreen           RCtrl PgDn down next gitbash app
syn keyword  mykYellow          Space Home linux bash left
syn keyword  mykBlue            End win right
syn keyword  mykPurple          py readline fzf
syn keyword  mykAqua            term
syn keyword  mykOrange          tab

syn match    myRed              "\[ *Red *\]"
syn match    myGreen            "\[ *Green *\]"
syn match    myYellow           "\[ *Yellow *\]"
syn match    myBlue             "\[ *Blue *\]"
syn match    myPurple           "\[ *Purple *\]"
syn match    myAqua             "\[ *Aqua *\]"
syn match    myOrange           "\[ *Orange *\]"

syn match    myLowProgress      "\[ *.%\]"
syn match    myLowProgress      "\[ *[1-2].%\]"
syn match    myMidProgress      "\[ *[3-7].%\]"
syn match    myHighProgress     "\[ *[8-9].%\]"
syn match    myHighProgress     "\[100%\]"

if has("ebcdic")
  syn match myHyperTextJump     "|[^"*|]\+|"
  syn match myHyperTextEntry    "\*[^"*|]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[^"*|]\+\*$"
else
  syn match myHyperTextJump     "|[#-)!+-~]\+|"
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*$"
endif

syn match    myComment          "#.*$"
syn region   myComment          start="/\*" end="\*/"

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

"------------------------------------------------------
" highlight
"------------------------------------------------------
hi link myComment          MyGray
hi link myDetails          MyGray
hi link mySeparator        MyGray
hi link mySeparator2       MyDarkGray

hi link mySection1         MyOrange
hi link mySection2         MyOrange
hi link mySection3         MyOrange

hi link myItem             MyOrange
hi link myCitation         MyPurple
hi link myColon            MyYellow

hi link myString           MyAqua
hi link myHtml             MyPurple
hi link myUrl              MyPurple
hi link myDir              MyAqua
hi link myVar              MyGreen

hi link myDate             MyYellow
hi link myTime             MyYellow
hi link mySat              MyBlue
hi link mySun              MyRed
hi link myHoliday          MyRed

hi link myTag              MyPurple
hi link myTagR             MyAqua
hi link myTagC             MyYellow
hi link myIcon             MyGreen

hi link myWORK             MyBlue
hi link myINFO             MyYellow
hi link myTODO             MyOrange
hi link myOK               MyGreen
hi link myFAIL             MyRed

hi link mykRed             MyRed
hi link mykGreen           MyGreen
hi link mykYellow          MyYellow
hi link mykBlue            MyBlue
hi link mykPurple          MyPurple
hi link mykAqua            MyAqua
hi link mykOrange          MyOrange

hi link myRed              MyRed  
hi link myGreen            MyGreen 
hi link myYellow           MyYellow
hi link myBlue             MyBlue  
hi link myPurple           MyPurple
hi link myAqua             MyAqua  
hi link myOrange           MyOrange

hi link myLowProgress      MyRed
hi link myMidProgress      MyOrange
hi link myHighProgress     MyGreen

hi link myHyperTextJump    MyYellow
hi link myHyperTextEntry   MyAqua

set textwidth=0

