# Allow $(...) and ${...} in PROMPT and RPROMPT.
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

#colors
_user_color='%F{green}'
_staged_color='%B%F{yellow}'
_unstaged_color='%B%F{red}'
_untracked_color='%B%F{red}'
_reset_color='%b%f'

use_nerd() {
  _git_symbol=''
  _venv_symbol=''
  _conda_symbol='🐍'
}

unuse_nerd() {
  _git_symbol='git:'
  _venv_symbol='venv:'
  _conda_symbol='conda:'
}

# symbols
_prompt_symbol='$'
use_nerd

if (( EUID == 0 )); then
  # root user
  _user_color='%F{red}'
  _prompt_symbol='#'
fi

_check_git_untracked_file() {
  [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || return 1

  [[ -n $(command git ls-files --others --exclude-standard 2>/dev/null) ]]
}

_get_vcs_prompt() {
  [[ -z $vcs_info_msg_0_ ]] && return

  local color
  if [[ -n $vcs_info_msg_3_ ]]; then
    # unstaged changes
    color=${_unstaged_color}
  elif [[ -n $vcs_info_msg_2_ ]]; then
    # staged changes
    color=${_staged_color}
  else
    # clean
    color=${_user_color}
  fi

  local untracked=""
  if _check_git_untracked_file; then
    untracked="${_untracked_color}●${_reset_color}"
  fi

  echo -n "${color}${_git_symbol}${vcs_info_msg_1_}${_reset_color}${untracked} "
}

# setting left prompt
_host_prefix=""
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
  _host_prefix="%F{magenta}${HOST%%.*}%f "
fi
PROMPT="${_host_prefix}${_user_color}%n ${_reset_color}\$(_get_vcs_prompt)${_prompt_symbol} "
# setting continuation prompt
PROMPT2="${_user_color}%n ${_reset_color}\$(_get_vcs_prompt)${_user_color}▶${_reset_color} "

# setting right prompt
# Hide the right prompt after pressing Enter to keep command history clean.
setopt transient_rprompt

_get_python_venv_prompt() {
  [[ -v VIRTUAL_ENV ]] || return

  # VIRTUAL_ENV:t means the basename of the virtual environment path.
  echo -n "|${_venv_symbol}${VIRTUAL_ENV:t}"
}

_get_anaconda_prompt() {
  [[ -v CONDA_DEFAULT_ENV ]] || return

  # show the conda environment name, but hide "base" if it's the default environment.
  echo -n "|${_conda_symbol}${CONDA_DEFAULT_ENV:#base}"
}

_rprompt_color='%B%F{yellow}'
RPROMPT="${_rprompt_color}[%~]"
RPROMPT+="\$(_get_anaconda_prompt)"
RPROMPT+="\$(_get_python_venv_prompt)"
RPROMPT+="|%*${_reset_color}"
