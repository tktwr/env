#!/bin/bash

#------------------------------------------------------
# info funcs
#------------------------------------------------------
_f_info_func_normal() { declare -F | grep '\-f ' | awk '{print $3}' | grep '\<f_'; }
_f_info_func_sort()  { sort | column; }

f_info_func() {
  n_func_normal=$(_f_info_func_normal | wc -l)

  echo "normal: $n_func_normal"
  _f_info_func_normal | _f_info_func_sort
}

#------------------------------------------------------
# info alias
#------------------------------------------------------
_f_info_alias_normal() { bash -ic 'alias' | grep -Ev 'alias ([,._]|cd\.|pd\.)'; }
_f_info_alias_comma()  { bash -ic 'alias' | grep 'alias ,'; }
_f_info_alias_dot()    { bash -ic 'alias' | grep 'alias \.'; }
_f_info_alias_cd()     { bash -ic 'alias' | grep 'alias cd\.'; }
_f_info_alias_pd()     { bash -ic 'alias' | grep 'alias pd\.'; }
_f_info_alias_all()    { bash -ic 'alias'; }
_f_info_alias_sort()   { sed -E "s/^alias ([^=]+)=.*/\1/" | sort | column; }

f_info_alias() {
  n_alias_normal=$(_f_info_alias_normal | wc -l)
  n_alias_comma=$(_f_info_alias_comma | wc -l)
  n_alias_dot=$(_f_info_alias_dot | wc -l)
  n_alias_cd=$(_f_info_alias_cd | wc -l)
  n_alias_pd=$(_f_info_alias_pd | wc -l)
  n_alias_all=$(_f_info_alias_all | wc -l)

  echo "all:$n_alias_all cd:$n_alias_cd pd:$n_alias_pd"
  echo

  echo "comma: $n_alias_comma"
  _f_info_alias_comma | _f_info_alias_sort
  echo

  echo "dot: $n_alias_dot"
  _f_info_alias_dot | _f_info_alias_sort
  echo

  echo "normal: $n_alias_normal"
  _f_info_alias_normal | _f_info_alias_sort
}

#------------------------------------------------------
# info
#------------------------------------------------------
f_info_env()     { info-env.sh     | fzf; }
f_info_path()    { info-path.sh    | fzf; }
f_info_version() { info-version.sh | fzf; }

