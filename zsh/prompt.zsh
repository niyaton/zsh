setopt prompt_subst

autoload -Uz vcs_info

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

function precmd(){
  vcs_info
}


# %(x.true-text.false-text)
# ! root or normal user
# root => normal(0), red(31)
# user => bold(1), green(32)
_user_color=$'%{\e[%(!.0;31.1;32)m%}'
_reset_color='%b%f'

function _check_git_untracked_file(){
  [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

  [[ -n $(command git ls-files --others --exclude-standard 2>/dev/null) ]]
}

function _get_vcs_prompt(){
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

function _get_python_venv_prompt(){
  if [[ -v VIRTUAL_ENV ]]; then
    local venv_name
    venv_name=`basename ${VIRTUAL_ENV}`
    echo -n "${_rprompt_color}|${venv_name:#venv}${_reset_color}"
  fi
}

function _get_anaconda_prompt(){
  if [[ -v CONDA_DEFAULT_ENV ]]; then
    echo -n "${_rprompt_color}|🐍${CONDA_DEFAULT_ENV:#base}${_reset_color}"
  fi
}

#setting prompt
_rprompt_color='%B%F{yellow}'
PROMPT="${_user_color}%n %{${_reset_color}%}\$(_get_vcs_prompt)%(!.#.$) "
PROMPT2="${_user_color}%n %{${_reset_color}%}\$(_get_vcs_prompt)%F{green}▶%f "
RPROMPT="${_rprompt_color}[%~]%{${_reset_color}%}"
RPROMPT+="\$(_get_anaconda_prompt)"
RPROMPT+="\$(_get_python_venv_prompt)"
RPROMPT+="${_rprompt_color}|%*%{${_reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%F{magenta}${HOST%%.*}%f ${PROMPT}"

# Hide the right prompt after pressing Enter to keep command history clean.
setopt transient_rprompt
