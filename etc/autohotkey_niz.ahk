; autohotkey.ahk

; AppsKey
;AppsKey::

; right shift to Hankaku/Zenkaku
RShift::
send,{vkF3sc029}
return

;#IfWinActive ahk_class mintty
;; maximize the tmux pane, minimize the window
;F5::
;send,{F8}
;send,#{Down}
;return

;; maximize the window, restore tmux panes
;F6::
;send,#{Up}
;send,{F8}
;return
;#IfWinActive

F5::
IfWinExist ahk_exe chrome.exe
{
  WinActivate
  send,#{Left}
}
IfWinExist ahk_exe mintty.exe
{
  WinActivate
  send,#{Right}
  send,{F8}
}
return

F6::
IfWinExist ahk_exe chrome.exe
{
  WinActivate
  WinMaximize,A
}
IfWinExist ahk_exe mintty.exe
{
  WinActivate
  WinMaximize,A
  send,{F8}
}
return

