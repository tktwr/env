;------------------------------------------------------
; remap
;------------------------------------------------------

~Esc::IME_SET(0)         ; IME off
~^[::IME_SET(0)          ; IME off
RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku
LCtrl::Enter
Space::Space

;------------------------------------------------------
; combination
;------------------------------------------------------

#IfWinActive ahk_exe WindowsTerminal.exe
LCtrl & Space::Send,{Esc}
Space & LCtrl::Send,{Esc}
Space & i::Send,{Ins}
Space & o::Send,{Del}
Space & n::Send,!n
Space & p::Send,!p
Space & j::Send,!j
Space & k::Send,!k
Space & c::Send,^+c             ; copy
Space & v::Send,^+v             ; paste
#IfWinActive

Space & Esc::AltTab             ; app next
Space & 1::ShiftAltTab          ; app prev
Space & 4::Send,^+{Tab}         ; app tab prev
Space & 5::Send,^{Tab}          ; app tab next

