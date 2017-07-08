# setting PATH
if [ -d ~/.pyenv ]; then
	PATH=~/.pyenv/bin:$PATH
	eval "$(pyenv init -)"
fi
