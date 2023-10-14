#Include common_func.ahk
#Include common_map.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

;------------------------------------------------------
; combination
;------------------------------------------------------

RCtrl & 1::Send,#{Left}         ; maximize window in left
RCtrl & 2::Send,#{Up}           ; maximize window
RCtrl & 3::Send,#{Right}        ; maximize window in right
RCtrl & 4::ToggleHalfMaximize() ; toggle maximize / half maximize window
RCtrl & s::Send,#+s             ; screenshot
RCtrl & d::Send,#d              ; display desktop
RCtrl & g::Send,#g              ; Xbox Game Bar
RCtrl & c::Send,^+c             ; copy
RCtrl & v::Send,^+v             ; paste
RCtrl & r::ReloadScript()       ; reload ahk

