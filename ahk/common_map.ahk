;------------------------------------------------------
; remap
;------------------------------------------------------

~Esc::IME_SET(0)         ; IME off
~^[::IME_SET(0)          ; IME off

RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku

LCtrl::LCtrl
Space::Space

;LCtrl & Space::Send,{Esc}
;Space & LCtrl::Send,{Esc}

;------------------------------------------------------
; combination
;------------------------------------------------------

#IfWinActive ahk_exe WindowsTerminal.exe
Space & /::Send,!/
Space & c::Send,^+c             ; copy
Space & v::Send,^+v             ; paste
#IfWinActive

;------------------------------------------------------
Space & q::AltTab               ; win_next
Space & w::ShiftAltTab          ; win_prev
Space & e::Send,{Blind}{End}
Space & r::Send,^+{Tab}         ; app_prev
Space & t::Send,^{Tab}          ; app_next

Space & a::Send,{Blind}{Home}
Space & s::Send,{BS}
Space & d::Send,{Del}
Space & f::Send,{Right}
Space & g::Send,{F5}

Space & b::Send,{Left}
;------------------------------------------------------
Space & y::Send,^{Home}
Space & u::Send,^{End}
Space & i::Send,^{PgUp}
Space & o::Send,^{PgDn}
Space & p::Send,{PgUp}

Space & h::Send,{Blind}{Left}
Space & j::Send,{Blind}{Down}
Space & k::Send,{Blind}{Up}
Space & l::Send,{Blind}{Right}
Space & `;::Send,{PgDn}

Space & n::Send,{PgDn}
;------------------------------------------------------
