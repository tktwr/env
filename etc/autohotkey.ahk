; autohotkey.ahk

; set the right alt key as the left windows key
RAlt::LWin

; set the right Shift key as the Hankaku/Zenkaku key
RShift::
send,{vkF3sc029}
return

#IfWinActive ahk_class mintty
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

