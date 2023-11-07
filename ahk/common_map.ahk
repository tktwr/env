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
Space & h::Send,{PgUp}
Space & j::Send,^n
Space & k::Send,^p
Space & l::Send,{PgDn}

Space & /::Send,!/
#IfWinActive

Space & q::AltTab               ; win_next
Space & w::ShiftAltTab          ; win_prev
Space & e::Send,^+{Tab}         ; app_prev
Space & r::Send,^{Tab}          ; app_next
Space & t::Send,{F5}

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
Space & p::Send,{Esc}

Space & h::Send,{PgUp}
Space & j::Send,{Down 5}
Space & k::Send,{Up 5}
Space & l::Send,{PgDn}

Space & n::Send,{Down}
Space & m::Send,{Up}
Space & ,::ReloadScript()       ; reload ahk
Space & .::Suspend              ; suspend ahk
;======================================================
