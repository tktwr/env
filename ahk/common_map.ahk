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
Space & r::Send,^+{Tab}         ; app_prev
Space & t::Send,^{Tab}          ; app_next

Space & g::Send,{F5}
;------------------------------------------------------
Space & y::Send,^{Home}
Space & u::Send,^{End}
Space & i::Send,^{PgUp}
Space & o::Send,^{PgDn}
Space & p::Send,{Blind}{PgUp}

Space & h::Send,{PgUp}
Space & j::Send,{Down}
Space & k::Send,{Up}
Space & l::Send,{PgDn}
Space & `;::Send,{Blind}{PgDn}

Space & n::Send,{Down}
Space & m::Send,{Up}
;======================================================
