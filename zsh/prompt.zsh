setopt prompt_subst
setopt extended_glob

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -U colors; colors

zstyle ':vcs_info:*' enable git hg svn cvs
zstyle ':vcs_info:*' formats '%s' '%b' '%i' '%c' '%u'
zstyle ':vcs_info:*' actionformats '%s' '%b' '%i' '%c' '%u' '%a'
zstyle ':vcs_info:*' nvcsformats ""
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 6

function _precmd_vcs_info(){
  LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _precmd_vcs_info


function check_git_untracked_file(){
  if [[ -n $(git status --short | grep -e '??') ]] {
    echo -n "%{${fg[red]}%}●%{${reset_color}%}"
  }
}

local user_color=$'%{\e[%(!.0;31.1;32)m%}'
local rprompt_color=$'%{\e[0;33m%}'
local fg_my_green=$user_color

function get_vcs_prompt(){
  if [[ -n "${vcs_info_msg_0_}" ]]; then
    #echo -n "${vcs_info_msg_0_}"
    if [[ -z "${vcs_info_msg_4_}" && -z "${vcs_info_msg_3_}" ]]; then
      color=${fg_my_green}
    elif [[ -n "${vcs_info_msg_4_}" ]]; then
      color=${fg[red]}
    elif [[ -z "${vcs_info_msg_4_}" && -n "${vcs_info_msg_3_}" ]]; then
      color=${fg[yellow]}
    else
      color=${fg[red]}
    fi

    echo -n "$user_color(%{${reset_color}%}%{$color%}${vcs_info_msg_1_}%{$reset_color%}$(check_git_untracked_file)${user_color})%{${reset_color}%} "
  fi
}

#setting prompt
SPROMPT=$'%B%{\e[1;34m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
PROMPT="${user_color}%n %{${reset_color}%}\$(get_vcs_prompt)%(!.#.$)%{${reset_color}%} "
PROMPT2="${user_color}%n %(!.#.$)%{${reset_color}%} "
RPROMPT="${rprompt_color}[%~]%{${reset_color}%}"

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT=$'%{\e[35m%}'"${HOST%%.*} ${PROMPT}"
