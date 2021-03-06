setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git hg svn cvs
zstyle ':vcs_info:*' formats '%s' '%b' '%i' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s' '%b' '%i' '%c' '%u' '%a'
zstyle ':vcs_info:*' nvcsformats ""
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 6

function precmd(){
  LANG=en_US.UTF-8 vcs_info
}


# %(x.true-text.false-text)
# ! root or normal user
# root => normal(0), red(31)
# user => bold(1), green(32)
local user_color=$'%{\e[%(!.0;31.1;32)m%}'
local reset_color=$'%{\e[0m%}'
local color

function check_git_untracked_file(){
  if [[ ! $PWD =~ ".git" ]] {
    if [[ -n $(command git status --short | grep -e '??') ]] {
      echo -n "%{\e[1;31m%}●%{${reset_color}%}"
    }
  }
}

function _get_vcs_prompt(){
  if [[ -n "${vcs_info_msg_0_}" ]]; then
    #echo -n "${vcs_info_msg_0_}"
    if [[ -z "${vcs_info_msg_4_}" && -z "${vcs_info_msg_3_}" ]]; then
      color=${user_color}
    elif [[ -n "${vcs_info_msg_4_}" ]]; then
      color=$'%{\e[1;31m%}'
    elif [[ -z "${vcs_info_msg_4_}" && -n "${vcs_info_msg_3_}" ]]; then
      color=$'%{\e[1;33m%}'
    else
      color=$'%{\e[1;31m%}'
    fi

    echo -n "%{$color%}${vcs_info_msg_1_}%{$reset_color%}$(check_git_untracked_file) "
  fi
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
PROMPT2="${user_color}%n %(!.#.$)%{${reset_color}%} "
RPROMPT="${rprompt_color}[%~]%{${reset_color}%}"
RPROMPT+="\$(_get_anaconda_prompt)"
RPROMPT+="\$(_get_python_venv_prompt)"
RPROMPT+="${rprompt_color}|%*%{${reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT=$'%{\e[35m%}'"${HOST%%.*} ${PROMPT}"
