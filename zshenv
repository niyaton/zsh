#for homebrew
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

#for my scripts
export PATH=~/local/bin:$PATH

#for MacTeX
export PATH=$PATH:/usr/texbin

#for Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Initialize rbenv.
# "eval rbenv init -" is much heavy. use cached script.
if [ -n "$(printenv TMUX)" ]; then
	source $HOME/.zsh/rbenv.init-no-rehash
else
	source $HOME/.zsh/rbenv.init
fi

# Initialize pyenv.
# "eval pyenv init -" is much heavy. use cached script.
if [ -n "$(printenv TMUX)" ]; then
	source $HOME/.zsh/pyenv.init-no-rehash
else
	source $HOME/.zsh/pyenv.init
fi

typeset -U path
