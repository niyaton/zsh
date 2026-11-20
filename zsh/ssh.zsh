# Based on Zsh 5.9's _ssh_hosts; collect matches from both sources.
# Homebrew (Apple Silicon): /opt/homebrew/opt/zsh/share/zsh/functions/_ssh_hosts
# Source used here (macOS): /usr/share/zsh/5.9/functions/_ssh_hosts
# Lines 12-17: Generic host completion, including known_hosts.
# Lines 18-58: SSH config selection, parsing, and completion.
_ssh_hosts() {
  local -a config_hosts
  local config
  integer ind
  local -i result=1

  if [[ "$IPREFIX" == *@ ]]; then
    _combination -s '[:@]' my-accounts users-hosts "users=${IPREFIX/@}" hosts "$@" && result=0
  else
    _combination -s '[:@]' my-accounts users-hosts \
      ${opt_args[-l]:+"users=${opt_args[-l]:q}"} hosts "$@" && result=0
  fi
  if (( ind = ${words[(I)-F]} )); then
    config=${~words[ind+1]} 2>/dev/null
  else
    config="$HOME/.ssh/config"
  fi
  if [[ -r $config ]]; then
    local key line host
    local -a lines=("${(@f)$(<"$config")}") 2>/dev/null
    local -a match_args
    local idx=1
    while (( idx <= $#lines )); do
      IFS=$'=\t ' read -r key line <<<"${lines[idx]}"
      if [[ "$key" == ((#i)match) ]]; then
        match_args=(${(z)line})
        while [[ $#match_args -ge 2 ]]; do
  	if [[ "${match_args[1]}" == (#i)(canonical|final|(|original)host) ]]; then
  	  key="Host"
  	  line="${match_args[2]//,/ }"
  	  break
  	fi
  	shift 2 match_args
        done
      fi
      case "$key" in
      ((#i)include)
        lines[idx]=("${(@f)$(cd $HOME/.ssh; cat ${(z)~line})}") 2>/dev/null;;
      ((#i)host(|name))
        for host in ${(z)line}; do
  	case $host in
  	(*[*?]*) ;;
  	(*) config_hosts+=("$host") ;;
  	esac
        done ;&
      (*) (( ++idx ));;
      esac
    done
    if (( ${#config_hosts} )); then
      _wanted hosts expl 'remote host name' \
        compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' "$@" $config_hosts && result=0
    fi
  fi
  return $result
}

# Static config listing: does not execute Match exec (including reachability checks).
ssh-list() {
  if ! (( $+commands[python3] )); then
    print -u2 'ssh-list: python3 is required'
    return 1
  fi
  command python3 "${ZSHHOME:-$HOME/.zsh}/ssh-list.py" "$@"
}

ssh-pick() {
  if ! (( $+commands[fzf] )); then
    print -u2 'ssh-pick: fzf is required'
    return 1
  fi
  local listing selected host
  listing=$(ssh-list) || return $?
  selected=$(print -r -- "$listing" | command fzf \
    --header-lines=1 --delimiter=$'\t' --no-multi \
    --prompt='SSH > ' --height=80% --layout=reverse \
    --bind='enter:accept' --query="${1:-}") || return 0
  [[ -n $selected ]] || return 0
  host=${selected%%$'\t'*}
  host=${host// /}
  print -r -- "ssh $host"
  command ssh "$host"
}
