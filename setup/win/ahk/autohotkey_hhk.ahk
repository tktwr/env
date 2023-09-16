; autohotkey.ahk

;------------------------------------------------------
; functions
;------------------------------------------------------
ReloadScript() {
  MsgBox, Reloaded
  Reload
  return
}

ScreenInfo() {
  w = %A_ScreenWidth%
  w_half = %A_ScreenWidth%
  w_half /= 2
  MsgBox, w = %w% w_half = %w_half%
  return
}

; toggle maximize / half maximize window
ToggleHalfMaximize() {
  WinGetPos, X, Y, W, H, A  ; "A" to get the active window's pos.
  ;MsgBox, x y w h = %X% %Y% %W% %H%
  screen_w_75 = %A_ScreenWidth%
  screen_w_75 *= 0.75
  If (W < screen_w_75) {
    WinMaximize,A
  } Else {
    IfWinActive ahk_exe WindowsTerminal.exe
      send,#{Right}
    Else
      send,#{Left}
  }
  return
}

;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;
; Reference
;   https://w.atwiki.jp/eamat/pages/17.html
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
  ControlGet,hwnd,HWND,,,%WinTitle%
  if (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI,  0, "UInt")   ; DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
      ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
  }
  return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
    , UInt, 0x0283  ;Message : WM_IME_CONTROL
    ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
    ,  Int, SetSts) ;lParam  : 0 or 1
}

; IME off
~Esc::IME_SET(0)
~^[::IME_SET(0)

;------------------------------------------------------
; remap
;------------------------------------------------------
; left meta
SC07B::PgUp

; left alt
;LAlt::LAlt

; right alt
RAlt::LWin
;RAlt::End

; right meta
SC079::PgDn

; right shift to Hankaku/Zenkaku
RShift::send,{vkF3sc029}

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
SC079 & 7::send,#{Left}         ; maximize window in left
SC079 & 8::send,#{Up}           ; maximize window
SC079 & 9::send,#{Right}        ; maximize window in right
SC079 & 0::ToggleHalfMaximize() ; toggle maximize / half maximize window
SC079 & s::Send,#+s             ; screenshot
SC079 & d::Send,#d              ; display desktop
SC079 & g::Send,#g              ; Xbox Game Bar
SC079 & c::Send,^+c             ; copy
SC079 & v::Send,^+v             ; paste
SC079 & r::ReloadScript()       ; reload ahk

;------------------------------------------------------
; Function Keys
;------------------------------------------------------
; virtual desktop left
;F2::send,#^{Left}

; virtual desktop right
;F3::send,#^{Right}

