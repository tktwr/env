set -a  # start exporting functions
#======================================================
_f_title() {
  echo "--- [$*] ----------"
}

_f_expand() {
  echo $(eval "echo $*")  # expand env variables
}

_f_expand_win() {
  url=$(eval "echo $*")  # expand env variables
  if [[ "$url" =~ 'http' ]]; then
    echo "$url"
  else
    echo $(pathconv.sh win "$url")
  fi
}

_in_win_dir() {
  rp=$(realpath "$PWD")
  case $rp in
    /mnt/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}
#======================================================
# venv
#======================================================
f_venv_activate() {
  local dir=${1:-$HOME/.venv}
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
  case $MY_OS_NAME in
    msys|gitbash)
      PATH=$MY_OLD_PATH
      ;;
    *)
      deactivate
      ;;
  esac
}
#======================================================
# fzf
#======================================================
f_fzf_pw_opt() {
  local cols=${COLUMNS:-80}
  local lins=${LINES:-10}
  local fzf_opt=""
  if [ $cols -ge 80 -a $lins -ge 10 ]; then
    fzf_opt="$fzf_opt --preview-window 'right,50%,+{2}/3'"
    fzf_opt="$fzf_opt --bind 'alt-/:change-preview-window(down,50%,+{2}/3|hidden|)'"
  elif [ $cols -ge 80 -a $lins -lt 10 ]; then
    fzf_opt="$fzf_opt --preview-window 'right,50%,+{2}/3'"
    fzf_opt="$fzf_opt --bind 'alt-/:change-preview-window(hidden|)'"
  elif [ $cols -lt 80 -a $lins -ge 10 ]; then
    fzf_opt="$fzf_opt --preview-window 'down,50%,+{2}/3'"
    fzf_opt="$fzf_opt --bind 'alt-/:change-preview-window(hidden|)'"
  else
    fzf_opt="$fzf_opt --preview-window 'hidden'"
    fzf_opt="$fzf_opt --bind 'alt-/:change-preview-window(down,50%,+{2}/3|)'"
  fi
  echo $fzf_opt
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
#======================================================
set +a  # stop exporting functions
