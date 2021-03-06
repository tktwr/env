; autohotkey.ahk

;------------------------------------------------------
; keymap
;------------------------------------------------------
; left meta
SC07B::PgUp

; left alt
;LAlt::LAlt

; right alt
RAlt::LWin

; right meta
SC079::PgDn

; right shift to Hankaku/Zenkaku
RShift::
  send,{vkF3sc029}
  return

;------------------------------------------------------
; Function Keys
;------------------------------------------------------
; virtual desktop left
F2::
  send,#^{Left}
  return

; virtual desktop right
F3::
  send,#^{Right}
  return

; screenshot
F4::
  send,#+s
  return

F7::
  w = %A_ScreenWidth%
  w_half = %A_ScreenWidth%
  w_half /= 2
  MsgBox, w = %w% w_half = %w_half%
  return

; toggle maximize / half maximize window
F8::
  WinGetPos, X, Y, W, H, A		; "A" to get the active window's pos.
  ;MsgBox, x y w h = %X% %Y% %W% %H%
  screen_w_75 = %A_ScreenWidth%
  screen_w_75 *= 0.75
  If (W < screen_w_75) {
    WinMaximize,A
  } Else {
    IfWinActive ahk_exe mintty.exe
      send,#{Right}
    Else
      send,#{Left}
  }
  return

