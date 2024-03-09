_f_title() {
  echo "--- [$*] ----------"
}

#------------------------------------------------------
# venv
#------------------------------------------------------
f_venv_activate() {
  local dir=$HOME/.venv
  if [ -d "$dir" ]; then
    case $MY_OS_NAME in
      msys|gitbash)
        MY_OLD_PATH=$PATH
        PATH="$dir:$PATH"
        PATH="$dir/Scripts:$PATH"
        ;;
      *)
        source $dir/bin/activate
        ;;
    esac
  fi
}

f_venv_deactivate() {
  local dir=$HOME/.venv
  if [ -d "$dir" ]; then
    case $MY_OS_NAME in
      msys|gitbash)
        PATH=$MY_OLD_PATH
        ;;
      *)
        deactivate
        ;;
    esac
  fi
}
#------------------------------------------------------
# fzf
#------------------------------------------------------
f_fzf_pw_opt() {
  pw_opt='hidden,right,60%,border-left,+{2}/3'
  if [ $COLUMNS -lt 80 ]; then
    pw_opt='hidden,down,60%,border-top,+{2}/3'
  fi
  echo $pw_opt
}
f_fzf_pw_opt_cmd() {
  pw_opt='right,30%,border-left,+{2}/3'
  if [ $COLUMNS -lt 80 ]; then
    pw_opt='down,30%,border-top,+{2}/3'
  fi
  echo $pw_opt
}
#------------------------------------------------------
f_fzf_help() {
  declare -F | grep '\-f ' | awk '{print $3}' | grep '\<f_'
}

f_fzf_default() {
  f_fzf_help
}

f_fzf_main() {
  func_name=${1:-"f_fzf_default"}
  shift
  eval "$func_name $@"
}
#------------------------------------------------------
# export functions
#------------------------------------------------------
export -f _f_title
export -f f_venv_activate
export -f f_venv_deactivate
export -f f_fzf_pw_opt
export -f f_fzf_pw_opt_cmd
export -f f_fzf_help
export -f f_fzf_default
export -f f_fzf_main
