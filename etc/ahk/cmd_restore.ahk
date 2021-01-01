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
