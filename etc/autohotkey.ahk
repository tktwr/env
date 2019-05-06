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

; right half window
;#x::
Del::
send,{F8}
send,#{Right}
return

; maximize window
;#z::
Ins::
send,#{Left}
send,#{Up}
send,{F8}
return
#IfWinActive

