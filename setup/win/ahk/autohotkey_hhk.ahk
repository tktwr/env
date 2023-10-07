#Include autohotkey_common.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku
RAlt::LWin               ; RAlt
SC07B::PgUp              ; LMeta
SC079::PgDn              ; RMeta

;------------------------------------------------------
; combination
;------------------------------------------------------

SC07B & h::Send,^{Left}
SC07B & j::Send,^{Down}
SC07B & k::Send,^{Up}
SC07B & l::Send,^{Right}
SC07B & p::Send,^{PgUp}
SC07B & n::Send,^{PgDn}

SC079 & 1::Send,^!1             ; wt tab1
SC079 & 2::Send,^!2             ; wt tab2
SC079 & 3::Send,^!3             ; wt tab3
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

