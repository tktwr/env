#Include common_func.ahk
#Include common_map.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

RAlt::LWin               ; RAlt
SC07B::PgUp              ; LMeta 無変換キー
SC079::PgDn              ; RMeta 変換キー

;------------------------------------------------------
; combination
;------------------------------------------------------

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

