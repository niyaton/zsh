alias run-help > /dev/null 2>&1 && unalias run-help
autoload -U run-help
bindkey -M vicmd '^[h' run-help
bindkey -M viins '^[h' run-help

case "${OSTYPE}" in
	darwin*)
		HELPDIR=/usr/local/share/zsh/help
		;;
	linux*)
		HELPDIR=/usr/share/zsh/help
		;;
esac
