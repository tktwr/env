;======================================================
; Tab
;======================================================
Tab::Tab
Tab & Esc::Return

Tab & q::AltTab               ; win_next
Tab & w::ShiftAltTab          ; win_prev
Tab & e::Send,^+{Tab}         ; app_prev
Tab & r::Send,^{Tab}          ; app_next
Tab & t::Send,^+{t}           ; app_tab

Tab & a::Send,#{``}           ; quake mode
Tab & s::Send,#+s             ; screenshot
Tab & d::Send,#d              ; display desktop
Tab & g::Send,#g              ; Xbox Game Bar

Tab & z::Send,#{Left}         ; maximize window in left
Tab & x::Send,#{Up}           ; maximize window
Tab & c::Send,#{Right}        ; maximize window in right
;------------------------------------------------------
Tab &  f::Send,^+!f
Tab &  v::Send,^+!v
Tab &  b::Send,^+!b
Tab &  y::Send,^+!y
Tab &  h::Send,^+!h
Tab &  n::Send,^+!n

Tab &  m::Send,{F1}
Tab &  ,::Send,{F2}
Tab &  .::Send,{F3}
Tab &  j::Send,{F4}
Tab &  k::Send,{F5}
Tab &  l::Send,{F6}
Tab &  u::Send,{F7}
Tab &  i::Send,{F8}
Tab &  o::Send,{F9}
Tab &  /::Send,{F10}
Tab & `;::Send,{F11}
Tab &  p::Send,{F12}
;===================================================
; BS
;===================================================
BS::BS
BS & Esc::Return

BS & q::Send,{(}{)}
BS & a::Send,{{}{}}
BS & z::Send,{[}{]}

BS & w::Send,{(}
BS & e::Send,{)}
BS & s::Send,{{}
BS & d::Send,{}}
BS & x::Send,{[}
BS & c::Send,{]}
;======================================================
; Enter
;======================================================
Enter::Enter
Enter & Esc::Return

Enter & q::Send,{!}
Enter & w::Send,{@}
Enter & e::Send,{^}
Enter & r::Send,{$}
Enter & t::Send,{`%}

Enter & a::Send,{#}
Enter & s::Send,{~}
Enter & d::Send,{"}
Enter & f::Send,{'}
Enter & g::Send,{``}

Enter & z::Send,{_}
Enter & x::Send,{\}
Enter & c::Send,{|}
Enter & v::Send,{/}
Enter & b::Send,{&}
;------------------------------------------------------
Enter & u::Send,{(}{)}
Enter & j::Send,{{}{}}
Enter & m::Send,{[}{]}

Enter & i::Send,{(}
Enter & o::Send,{)}
Enter & k::Send,{{}
Enter & l::Send,{}}
Enter & ,::Send,{[}
Enter & .::Send,{]}

Enter & /::Send,{BS}
;======================================================
; RShift
;======================================================
;RShift::RShift
RShift & Esc::Return

RShift & z::Send,0
RShift & x::Send,1
RShift & c::Send,2
RShift & v::Send,3
RShift & s::Send,4
RShift & d::Send,5
RShift & f::Send,6
RShift & w::Send,7
RShift & e::Send,8
RShift & r::Send,9

RShift & a::Send,{-}
RShift & q::Send,{+}
RShift & g::Send,{*}
RShift & t::Send,{/}
RShift & b::Send,{=}
;------------------------------------------------------
RShift & ,::Send,{,}
RShift & .::Send,{.}
RShift & /::Send,{BS}
;======================================================
; #IfTimeout 500 ; Set the timeout to 10 ms.
;
; n::
; If (A_PriorHotKey == A_ThisHotKey and A_TimeSincePriorHotkey < 800) {
;   Send,{m}
;   Return
; } Else {
;   Send,{n}
; }
; Return
