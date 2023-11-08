;======================================================
; remap
;======================================================

~Esc::IME_SET(0)         ; IME off
~^[::IME_SET(0)          ; IME off

RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku

;LCtrl & Space::Send,{Esc}
;Space & LCtrl::Send,{Esc}

;======================================================
LCtrl::LCtrl
LCtrl & Esc::Return

;======================================================
Space::Space
Space & Esc::Return

#IfWinActive ahk_exe WindowsTerminal.exe
Space & c::Send,^+c             ; copy
Space & v::Send,^+v             ; paste
;------------------------------------------------------
Space & h::Send,{Blind}{PgUp}
Space & j::Send,^n
Space & k::Send,^p
Space & l::Send,{Blind}{PgDn}

Space & /::Send,!/
#IfWinActive

Space & q::AltTab               ; win_next
Space & w::ShiftAltTab          ; win_prev
Space & e::Send,^+{Tab}         ; app_prev
Space & r::Send,^{Tab}          ; app_next

Space & a::Send,{Blind}{Home}
Space & s::Send,{Blind}{BS}
Space & d::Send,{Blind}{Left}
Space & f::Send,{Blind}{Right}
Space & g::Send,{Blind}{End}

Space & z::Send,{Blind}{Ins}
Space & x::Send,{Blind}{Del}
;------------------------------------------------------
Space & y::Send,^{Left}
Space & u::Send,^{Right}
Space & i::Send,^{Up}
Space & o::Send,^{Down}
Space & p::Send,{Blind}{Esc}

Space & h::Send,{Blind}{PgUp}
Space & j::Send,{Down 5}
Space & k::Send,{Up 5}
Space & l::Send,{Blind}{PgDn}

Space & n::Send,{Blind}{Down}
Space & m::Send,{Blind}{Up}
Space & ,::ReloadScript()       ; reload ahk
Space & .::Suspend              ; suspend ahk
;======================================================
