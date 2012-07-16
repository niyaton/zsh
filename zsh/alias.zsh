#setting alias

case "${OSTYPE}" in
darwin*)
	alias ls="ls -hF -G"
	alias xargs="gxargs"
	#for use macvim on CUI
	MacVim=~/Applications/MacVim.app/Contents/MacOS
	alias vim='env $MacVim/Vim -u $HOME/.vimrc "$@"'
	alias gvim='$MacVim/mvim --remote-tab-silent "$@"'
	alias gitx=/Applications/GitX.app/Contents/MacOS/gitx
	;;
linux*)
	alias ls="ls -hF --color=auto"
	;;
esac

alias ll="ls -l"
alias la="ls -a"
alias usejp="export LANG=ja_JP.UTF-8"
alias unusejp="export LANG="
alias tmux="tmux -2u"


