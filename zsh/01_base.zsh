zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

autoload zed

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd

#coloring ls
# TODO too slow
case "${OSTYPE}" in
	darwin*)
		eval `gdircolors ~/.dircolors`
		;;
	linux*)
		eval `dircolors ~/.dircolors`
		;;
esac
zstyle ':completion:*:default' list-colors ${LS_COLORS}

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
  #TODO need refactoring
  if [[ ${OSTYPE} == darwin* ]]; then
	  for i in $ZSHHOME/*.zsh.osx; do
	  	echo 'compiling zshrc.' $i
	  	zcompile $i
  done
  fi
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}
