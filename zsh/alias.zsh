if command -v gls >/dev/null; then
  alias ls='gls -hF --color=auto'
elif [[ $OSTYPE == linux* ]]; then
  alias ls='ls -hF --color=auto'
elif [[ $OSTYPE == darwin* ]]; then
  alias ls='ls -hF'
fi

alias usejp="export LANG=ja_JP.UTF-8"
alias useen="export LANG=en_US.UTF-8"
alias unusejp="export LANG="
