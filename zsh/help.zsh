alias run-hlep > /dev/null 2>&1 && unalias run-help
autoload -U run-help
bindkey -M vicmd '^[h' run-help
bindkey -M viins '^[h' run-help
HELPDIR=/usr/local/share/zsh/help
