setopt prompt_subst

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

add-zsh-hook precmd vcs_info

# formats:
#   %s -> vcs_info_msg_0_ (VCS)
#   %b -> vcs_info_msg_1_ (branch)
#   %c -> vcs_info_msg_2_ (staged)
#   %u -> vcs_info_msg_3_ (unstaged)
#
# actionformats additionally exports:
#   %a -> vcs_info_msg_4_ (action)
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%s' '%b' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s' '%b' '%c' '%u' '%a'
zstyle ':vcs_info:*' nvcsformats ""
# max-exports must be >= the number of exported fields.
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:*' check-for-changes true

if (( EUID == 0 )); then
  # root user
  _user_color='%F{red}'
  _prompt_symbol='#'
else
  _user_color='%B%F{green}'
  _prompt_symbol='$'
fi
_reset_color='%b%f'

_check_git_untracked_file() {
  [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

  [[ -n $(command git ls-files --others --exclude-standard 2>/dev/null) ]]
}

_get_vcs_prompt() {
  [[ -z $vcs_info_msg_0_ ]] && return

  local color
  if [[ -n $vcs_info_msg_3_ ]]; then
    # unstaged changes
    color='%B%F{red}'
  elif [[ -n $vcs_info_msg_2_ ]]; then
    # staged changes
    color='%B%F{yellow}'
  else
    # clean
    color=$_user_color
  fi

  local untracked=""
  if _check_git_untracked_file; then
    untracked="%B%F{red}●%{${_reset_color}%}"
  fi

  echo -n "%{$color%}${vcs_info_msg_1_}%{$_reset_color%}${untracked} "
}

_get_python_venv_prompt() {
  if [[ -v VIRTUAL_ENV ]]; then
    local venv_name
    venv_name=`basename ${VIRTUAL_ENV}`
    echo -n "${_rprompt_color}|${venv_name:#venv}${_reset_color}"
  fi
}

_get_anaconda_prompt() {
  if [[ -v CONDA_DEFAULT_ENV ]]; then
    echo -n "${_rprompt_color}|🐍${CONDA_DEFAULT_ENV:#base}${_reset_color}"
  fi
}

# setting left prompt
PROMPT="${_user_color}%n %{${_reset_color}%}\$(_get_vcs_prompt)${_prompt_symbol} "
# setting continuation prompt
PROMPT2="${_user_color}%n %{${_reset_color}%}\$(_get_vcs_prompt)%F{green}▶%f "

# setting right prompt
_rprompt_color='%B%F{yellow}'
RPROMPT="${_rprompt_color}[%~]%{${_reset_color}%}"
RPROMPT+="\$(_get_anaconda_prompt)"
RPROMPT+="\$(_get_python_venv_prompt)"
RPROMPT+="${_rprompt_color}|%*%{${_reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%F{magenta}${HOST%%.*}%f ${PROMPT}"

# Hide the right prompt after pressing Enter to keep command history clean.
setopt transient_rprompt
