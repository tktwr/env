#Include autohotkey_common.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku
;RAlt::LWin               ; RAlt
SC07B::PgUp              ; LMeta
SC079::PgDn              ; RMeta

;------------------------------------------------------
; combination
;------------------------------------------------------

#IfWinActive ahk_exe WindowsTerminal.exe
LCtrl::Send,{Enter}
Space::Send,{Space}
LCtrl & Space::Send,{Esc}
Space & LCtrl::Send,{Esc}
Space & n::Send,!n
Space & p::Send,!p
Space & j::Send,!j
Space & k::Send,!k
#IfWinActive

SC07B & h::Send,{Left}
SC07B & j::Send,{Down}
SC07B & k::Send,{Up}
SC07B & l::Send,{Right}
SC07B & p::Send,{PgUp}
SC07B & n::Send,{PgDn}
SC07B & a::Send,{Home}
SC07B & e::Send,{End}

SC079 & 1::Send,!+{Tab}         ; app prev
SC079 & 2::Send,!{Tab}          ; app next
SC079 & 4::Send,^+{Tab}         ; app tab prev
SC079 & 5::Send,^{Tab}          ; app tab next
SC079 & 7::Send,#{Left}         ; maximize window in left
SC079 & 8::Send,#{Up}           ; maximize window
SC079 & 9::Send,#{Right}        ; maximize window in right
SC079 & 0::ToggleHalfMaximize() ; toggle maximize / half maximize window
SC079 & s::Send,#+s             ; screenshot
SC079 & d::Send,#d              ; display desktop
SC079 & g::Send,#g              ; Xbox Game Bar
SC079 & c::Send,^+c             ; copy
SC079 & v::Send,^+v             ; paste
SC079 & r::ReloadScript()       ; reload ahk

