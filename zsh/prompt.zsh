# Powerline/Nerd Fontを必要としないASCIIだけのプロンプト。
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

zstyle ':vcs_info:git:*' formats ' [git:%b]'
zstyle ':vcs_info:git:*' actionformats ' [git:%b|%a]'
add-zsh-hook precmd vcs_info

if (( EUID == 0 )); then
  PROMPT='%F{red}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_}# '
else
  PROMPT='%F{green}%n@%m%f:%F{blue}%~%f${vcs_info_msg_0_}$ '
fi

PROMPT2='> '
