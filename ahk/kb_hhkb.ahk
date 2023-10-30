#Include common_func.ahk
#Include common_map.ahk
#Include kb_40.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

RAlt::LWin               ; RAlt
SC07B::PgUp              ; LMeta 無変換キー
SC079::PgDn              ; RMeta 変換キー

;------------------------------------------------------
; combination
;------------------------------------------------------

SC079 & 1::Send,#{Left}         ; maximize window in left
SC079 & 2::Send,#{Up}           ; maximize window
SC079 & 3::Send,#{Right}        ; maximize window in right
SC079 & 4::ToggleHalfMaximize() ; toggle maximize / half maximize window
SC079 & s::Send,#+s             ; screenshot
SC079 & d::Send,#d              ; display desktop
SC079 & g::Send,#g              ; Xbox Game Bar
SC079 & c::Send,^+c             ; copy
SC079 & v::Send,^+v             ; paste
SC079 & r::ReloadScript()       ; reload ahk

