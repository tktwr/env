syn clear
syn case match

syn match    gitDate             "\d\+/\d\+/\d\+"
syn match    gitTime             "\d\+:\d\+"
syn match    gitTime             "\d\+:\d\+:\d\+"

hi link gitTime             MyYellow
hi link gitDate             MyYellow

