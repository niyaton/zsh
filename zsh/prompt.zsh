setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%s' '%b' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s' '%b' '%c' '%u' '%a'
zstyle ':vcs_info:*' nvcsformats ""
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 5

function precmd(){
  vcs_info
}


# %(x.true-text.false-text)
# ! root or normal user
# root => normal(0), red(31)
# user => bold(1), green(32)
local user_color=$'%{\e[%(!.0;31.1;32)m%}'
local reset_color=$'%{\e[0m%}'

function check_git_untracked_file(){
  if [[ ! $PWD =~ ".git" ]] {
    if [[ -n $(command git status --short | grep -e '??') ]] {
      echo -n "%{\e[1;31m%}●%{${reset_color}%}"
    }
  }
}

function _get_vcs_prompt(){
  [[ -z $vcs_info_msg_0_ ]] && return

  local color
  if [[ -n $vcs_info_msg_3_ ]]; then
    # unstaged changes
    color=$'%{\e[1;31m%}'
  elif [[ -n $vcs_info_msg_2_ ]]; then
    # staged changes
    color=$'%{\e[1;33m%}'
  else
    # clean
    color=$user_color
  fi

  echo -n "%{$color%}${vcs_info_msg_1_}%{$reset_color%}$(check_git_untracked_file) "
}

function _get_python_venv_prompt(){
  if [[ -v VIRTUAL_ENV ]]; then
    local venv_name
    venv_name=`basename ${VIRTUAL_ENV}`
    echo -n "${rprompt_color}|${venv_name:#venv}${reset_color}"
  fi
}

function _get_anaconda_prompt(){
  if [[ -v CONDA_DEFAULT_ENV ]]; then
    echo -n "${rprompt_color}|🐍${CONDA_DEFAULT_ENV:#base}${reset_color}"
  fi
}

#setting prompt
local rprompt_color=$'%{\e[1;33m%}'
SPROMPT=$'%B%{\e[1;34m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
PROMPT="${user_color}%n %{${reset_color}%}\$(_get_vcs_prompt)%(!.#.$) "
PROMPT2="${user_color}%n %{${reset_color}%}\$(_get_vcs_prompt)%F{green}▶%f "
RPROMPT="${rprompt_color}[%~]%{${reset_color}%}"
RPROMPT+="\$(_get_anaconda_prompt)"
RPROMPT+="\$(_get_python_venv_prompt)"
RPROMPT+="${rprompt_color}|%*%{${reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT=$'%{\e[35m%}'"${HOST%%.*} ${PROMPT}"

# Hide the right prompt after pressing Enter to keep command history clean.
setopt transient_rprompt
