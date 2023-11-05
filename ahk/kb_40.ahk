;======================================================
q::q
q & Esc::Return

;======================================================
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
;======================================================
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
;======================================================
p::p
p & Esc::Return

p & r::ReloadScript()       ; reload ahk

p & s::Send,#+s             ; screenshot
p & d::Send,#d              ; display desktop
p & g::Send,#g              ; Xbox Game Bar

p & y::ToggleHalfMaximize() ; toggle maximize / half maximize window
p & u::Send,#{Left}         ; maximize window in left
p & i::Send,#{Up}           ; maximize window
p & o::Send,#{Right}        ; maximize window in right
;===================================================
`;::`;
`; & Esc::Return

`; & q::Send,{Blind}{Esc}
`; & w::Send,{Blind}{Tab}

`; & a::Send,{Blind}{Home}
`; & s::Send,{Blind}{BS}
`; & d::Send,{Blind}{Left}
`; & f::Send,{Blind}{Right}
`; & g::Send,{Blind}{End}

`; & z::Send,{Blind}{Ins}
`; & x::Send,{Blind}{Del}
`; & c::Send,{vkF3sc029} ; Hankaku/Zenkaku
;------------------------------------------------------
`; & y::Send,{Blind}{Home}
`; & u::Send,{Blind}{End}
`; & i::Send,{Blind}{PgUp}
`; & o::Send,{Blind}{PgDn}

`; & h::Send,{Blind}{Left}
`; & j::Send,{Blind}{Down}
`; & k::Send,{Blind}{Up}
`; & l::Send,{Blind}{Right}
;======================================================
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
;======================================================
