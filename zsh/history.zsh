#setting history
HISTFILE=$HOME/.zsh_history
HISTSIZE=120000
SAVEHIST=100000
setopt share_history        # share command history data
setopt hist_ignore_space

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
