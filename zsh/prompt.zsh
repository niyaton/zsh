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

#setting prompt
#SPROMPT=$'%B%{\e[1;34m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
#PROMPT=$'%{\e[%(!.0;31.1;32)m%}%n %(!.#.$)%{\e[m%} '
#PROMPT2=$'%{\e[%(!.0;31.1;32)m%}%n %(!.#.$)%{\e[m%} '
#sPROMPT=$'%{\e[0;33m%}[%~]%{\e[m%}'

#RPROMPT='[`rprompt-git-current-branch`%~]'

#GIT_PROMPT=`prompt-git-current-branch`
#[ -n "${GIT_PROMPT}" ] && PROMPT="${PROMPT} ${GIT_PROMPT}"
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT=$'%{\e[35m%}'"${HOST%%.*} ${PROMPT}"

function check_git_untracked_file(){
  if [[ -n $(git ls-files --others --exclude-standard 2> /dev/null) ]] {
    echo -n "%{${fg[red]}%}●%{${reset_color}%}"
  }
}

function get_vcs_prompt(){
  if [[ -n "${vcs_info_msg_0_}" ]]; then
    #echo -n "${vcs_info_msg_0_}"
    if [[ -z "${vcs_info_msg_4_}" && -z "${vcs_info_msg_3_}" ]]; then
      color=${fg[green]}
    elif [[ -n "${vcs_info_msg_4_}" ]]; then
      color=${fg[red]}
    elif [[ -z "${vcs_info_msg_4_}" && -n "${vcs_info_msg_3_}" ]]; then
      color=${fg[yellow]}
    else
      color=${fg[red]}
    fi
    #echo  "${vcs_info_msg_1_}"

    #echo  "${vcs_info_msg_2_}"
    #echo  "${vcs_info_msg_3_}"
    #echo  "${vcs_info_msg_4_}"
    #echo  "${vcs_info_msg_5_}"

    echo -n "(%{$color%}${vcs_info_msg_1_}%{$reset_color%}$(check_git_untracked_file))"

    #if [[ "${vcs_info_msg_0_}" == "git" && -z "${vcs_info_msg_2_}" ]]; then
    #  echo -n "${vcs_info_msg_1_}"
      #head_name=$(git name-rev --name-only HEAD)
      #if [[ -n "${head_name}" ]]; then
      #  echo -n "${head_name}"
      #rev=$(git rev-parse --short HEAD)
      #namerev=$(git name-rev --name-only --no-undefined $rev)
      #if [[ -n "$namerev" ]]; then
      #  echo -n "$rev($namerev)"
      #else
      #  echo -n "${vcs_info_msg_1_}"
      #fi
    #else
    #  echo "hoge"
    #  echo -n "${vcs_info_msg_1_}"
    #fi
    #if [[ -n "${vcs_info_msg_3_}" || -n "${vcs_info_msg_4_}" ]]; then
    #  echo -n ":${vcs_info_msg_3_}${vcs_info_msg_4_}"
    #fi
    #if [[ -n "${vcs_info_msg_5_}" ]]; then
    #  echo -n ":${vcs_info_msg_5_}"
    #fi
    #echo -n "]"
  fi
}

#setting prompt
user_color=$'%{\e[%(!.0;31.1;32)m%}'
rprompt_color=$'%{\e[0;33m%}'
#user_color="\e[1;32)m"
#user_color="%{\e[1;32m%}"
#user_color="%F{green}"
SPROMPT=$'%B%{\e[1;34m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
#PROMPT=$'%{\e[%(!.0;31.1;32)m%}%n %{\e[m%}\$(get_vcs_prompt) %(!.#.$)%{\e[m%} '
#PROMPT="${user_color}%n %{\e[m%}\$(get_vcs_prompt) %(!.#.$)%{\e[m%} "
PROMPT="${user_color}%n %{${reset_color}%}\$(get_vcs_prompt) %(!.#.$)%{${reset_color}%} "
#PROMPT2=$'%{\e[%(!.0;31.1;32)m%}%n %(!.#.$)%{\e[m%} '
PROMPT2="${user_color}%n %(!.#.$)%{${reset_color}%} "
RPROMPT="${rprompt_color}[%~]%{${reset_color}%}"

#PROMPT+="\$(get_vcs_prompt)%E"

#PROMPT+="\$(
#if [[ -n \"\${vcs_info_msg_0_}\" ]]; then
#  echo -n \" [\${vcs_info_msg_0_}:\"
#  if [[ \"\${vcs_info_msg_0_}\" == \"git\" && -z \"\${vcs_info_msg_2_}\" ]]; then
#    rev=\$(git rev-parse --short HEAD)
#    namerev=\$(git name-rev --name-only --no-undefined \$rev)
#    if [[ -n \"\$namerev\" ]]; then
#      echo -n \"\$rev(\$namerev)\"
#    else
#      echo -n \"\${vcs_info_msg_1_}\"
#    fi
#  else
#    echo -n \"\${vcs_info_msg_1_}\"
#  fi
#  if [[ -n \"\${vcs_info_msg_3_}\" || -n \"\${vcs_info_msg_4_}\" ]]; then
#    echo -n \":\${vcs_info_msg_3_}\${vcs_info_msg_4_}\"
#  fi
#  if [[ -n \"\${vcs_info_msg_5_}\" ]]; then
#    echo -n \":\${vcs_info_msg_5_}\"
#  fi
#  echo -n \"]\"
#fi
#)%E"
