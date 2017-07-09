#setting alias

case "${OSTYPE}" in
darwin*)
	alias ls="gls -hF --color=auto"
	alias xargs="gxargs"
	alias vim="reattach-to-user-namespace vim"
	alias gvim="reattach-to-user-namespace gvim --remote-silent"
	#for use macvim on CUI
	#alias vim='env $MacVim/Vim -u $HOME/.vimrc "$@"'
	#alias gvim='$MacVim/mvim --remote-tab-silent "$@"'
	;;
linux*)
	alias ls="ls -hF --color=auto"
	;;
esac

alias ll="ls -l"
alias la="ls -a"
alias usejp="export LANG=ja_JP.UTF-8"
alias unusejp="export LANG=en_US.UTF-8"
alias tmux="tmux -2u"
