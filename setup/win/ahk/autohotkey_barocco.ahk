#Include autohotkey_common.ahk

;------------------------------------------------------
; remap
;------------------------------------------------------

F13::LCtrl               ; CapsLock to LCtrl
RShift::Send,{vkF3sc029} ; RShift to Hankaku/Zenkaku
RAlt::`

;------------------------------------------------------
; combination
;------------------------------------------------------

RCtrl & 1::Send,^!1             ; wt tab1
RCtrl & 2::Send,^!2             ; wt tab2
RCtrl & 3::Send,^!3             ; wt tab3
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

