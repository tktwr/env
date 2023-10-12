#Include common_func.ahk
#Include common_map.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

;------------------------------------------------------
; combination
;------------------------------------------------------

RCtrl & 7::Send,#{Left}         ; maximize window in left
RCtrl & 8::Send,#{Up}           ; maximize window
RCtrl & 9::Send,#{Right}        ; maximize window in right
RCtrl & 0::ToggleHalfMaximize() ; toggle maximize / half maximize window
RCtrl & s::Send,#+s             ; screenshot
RCtrl & d::Send,#d              ; display desktop
RCtrl & g::Send,#g              ; Xbox Game Bar
RCtrl & c::Send,^+c             ; copy
RCtrl & v::Send,^+v             ; paste
RCtrl & r::ReloadScript()       ; reload ahk

