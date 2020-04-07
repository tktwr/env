; autohotkey.ahk

; left meta
SC07B::F1

; left alt
;LAlt::LAlt

; right alt
RAlt::LWin

; right meta to Hankaku/Zenkaku
SC079::
send,{vkF3sc029}
return

#IfWinActive ahk_class mintty
; right Shift
RShift::
send,{vkF3sc029}
send,{Esc}
return

; maximize the tmux pane, minimize the window
F5::
send,{F8}
send,#{Down}
return

; maximize the window, restore tmux panes
F6::
send,#{Up}
send,{F8}
return
#IfWinActive

