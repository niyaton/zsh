#setting alias

case "${OSTYPE}" in
darwin*)
	if (( $+commands[gls] )); then
		alias ls='gls -hF --color=auto'
	else
		alias ls='ls -hF'
	fi
	;;
linux*)
	alias ls='ls -hF --color=auto'
	;;
esac

alias usejp="export LANG=ja_JP.UTF-8"
alias useen="export LANG=en_US.UTF-8"
alias unusejp="export LANG="
if (( $+commands[nvim] )); then
  alias vim='nvim'
fi
