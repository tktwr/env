#!/bin/bash

f_alias_normal() { bash -ic 'alias' | grep -Ev 'alias ([,._]|cd\.|pd\.)'; }
f_alias_comma()  { bash -ic 'alias' | grep 'alias ,'; }
f_alias_dot()    { bash -ic 'alias' | grep 'alias \.'; }
f_alias_cd()     { bash -ic 'alias' | grep 'alias cd\.'; }
f_alias_pd()     { bash -ic 'alias' | grep 'alias pd\.'; }
f_alias_all()    { bash -ic 'alias'; }
f_sort_alias()   { sed -E "s/^alias ([^=]+)=.*/\1/" | sort | column; }

n_alias_normal=$(f_alias_normal | wc -l)
n_alias_comma=$(f_alias_comma | wc -l)
n_alias_dot=$(f_alias_dot | wc -l)
n_alias_cd=$(f_alias_cd | wc -l)
n_alias_pd=$(f_alias_pd | wc -l)
n_alias_all=$(f_alias_all | wc -l)

echo "all:$n_alias_all cd:$n_alias_cd pd:$n_alias_pd"
echo

echo "comma: $n_alias_comma"
f_alias_comma | f_sort_alias
echo

echo "dot: $n_alias_dot"
f_alias_dot | f_sort_alias
echo

echo "normal: $n_alias_normal"
f_alias_normal | f_sort_alias
