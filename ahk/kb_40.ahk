;           | vkBBsc027 `;
;           | vkBAsc028 `:
;           | vkBCsc033 `,
; backslash | vkE2sc073

;------------------------------------------------------
a::a
a & Esc::Return

a & r::Send,{!}
a & t::Send,{@}
a & y::Send,{^}
a & u::Send,{$}
a & v::Send,{#}
a & b::Send,{`%}
a & n::Send,{&}
a & m::Send,{_}
a & f::Send,{``}
a & h::Send,{'}
a & j::Send,{"}

a & i::Send,{(}
a & o::Send,{)}
a & k::Send,{{}
a & l::Send,{}}
a & ,::Send,{[}
a & .::Send,{]}

a &  p::Send,{~}
a & `;::Send,{|}
a &  /::Send,{\}
;------------------------------------------------------
z::z
z & Esc::Return

z & x::Send,1
z & c::Send,2
z & v::Send,3
z & s::Send,4
z & d::Send,5
z & f::Send,6
z & w::Send,7
z & e::Send,8
z & r::Send,9
z & b::Send,0

z & h::Send,{-}
z & y::Send,{+}
z & j::Send,{*}
z & u::Send,{/}
z & n::Send,{=}

z & i::Send,{(}
z & o::Send,{)}
z & k::Send,{{}
z & l::Send,{}}

z &  p::Send,{BS}
z & `;::Send,{f}
z &  /::Send,{l}
;------------------------------------------------------
`;::`;
`; & Esc::Return

`; & q::Send,#{Left}         ; maximize window in left
`; & w::Send,#{Up}           ; maximize window
`; & e::Send,#{Right}        ; maximize window in right
`; & r::ReloadScript()       ; reload ahk
`; & t::ToggleHalfMaximize() ; toggle maximize / half maximize window

`; & s::Send,#+s             ; screenshot
`; & d::Send,#d              ; display desktop
`; & g::Send,#g              ; Xbox Game Bar

`; & h::Send,^h
`; & j::Send,^j
`; & k::Send,^k
`; & l::Send,^l
;------------------------------------------------------
/::/
/ & Esc::Return

/ & x::Send,{F1}
/ & c::Send,{F2}
/ & v::Send,{F3}
/ & s::Send,{F4}
/ & d::Send,{F5}
/ & f::Send,{F6}
/ & w::Send,{F7}
/ & e::Send,{F8}
/ & r::Send,{F9}
/ & b::Send,{F10}
/ & g::Send,{F11}
/ & t::Send,{F12}
;------------------------------------------------------
