; autohotkey.ahk

;------------------------------------------------------
; keymap
;------------------------------------------------------
; left meta
SC07B::F11

; left alt
;LAlt::LAlt

; right alt
RAlt::LWin

; right meta
;SC079::RCtrl
SC079::F10

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

; vim tabprev
F9::
  IfWinActive ahk_exe mintty.exe
    send,^{Left}
  return

; vim tabnext
F10::
  IfWinActive ahk_exe mintty.exe
    send,^{Right}
  return

; toggle maximize / half maximize window
F11::
  WinGetPos, X, Y, W, H, A		; "A" to get the active window's pos.
  ;MsgBox, x y w h = %X% %Y% %W% %H%
  half_screen_width := 1000
  If (W < half_screen_width) {
    WinMaximize,A
  } Else {
    IfWinActive ahk_exe mintty.exe
      send,#{Right}
    Else
      send,#{Left}
  }
  return

