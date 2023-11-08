;======================================================
Tab::Tab
Tab & Esc::Return

Tab & q::AltTab               ; win_next
Tab & w::ShiftAltTab          ; win_prev
Tab & e::Send,^+{Tab}         ; app_prev
Tab & r::Send,^{Tab}          ; app_next

Tab & s::Send,#+s             ; screenshot
Tab & d::Send,#d              ; display desktop
Tab & g::Send,#g              ; Xbox Game Bar

Tab & i::Send,{(}
Tab & o::Send,{)}
Tab & k::Send,{{}
Tab & l::Send,{}}
Tab & ,::Send,{[}
Tab & .::Send,{]}

Tab &  p::Send,#{Left}        ; maximize window in left
Tab & `;::Send,#{Up}          ; maximize window
Tab &  /::Send,#{Right}       ; maximize window in right
;===================================================
BS::BS
BS & Esc::Return

BS & x::Send,{F1}
BS & c::Send,{F2}
BS & v::Send,{F3}
BS & s::Send,{F4}
BS & d::Send,{F5}
BS & f::Send,{F6}
BS & w::Send,{F7}
BS & e::Send,{F8}
BS & r::Send,{F9}
BS & b::Send,{F10}
BS & g::Send,{F11}
BS & t::Send,{F12}
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
