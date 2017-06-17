# setting PATH
if [ -d ~/.pyenv ]; then
	PATH=~/.pyenv/bin:$PATH
	eval "$(pyenv init -)"
fi

[ -d ~/anaconda3 ] && export PATH=~/anaconda3/bin:$PATH
