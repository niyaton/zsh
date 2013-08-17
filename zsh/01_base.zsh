zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

autoload zed

#setopt prompt_subst
#setopt extended_glob
#

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd 

#coloring ls
case "${OSTYPE}" in
darwin*)
	export LSCOLORS=ExFxCxdxBxegedabagacad
	export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	export ZLS_COLORS=$LS_COLORS
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    ;;  
linux*)
	eval `dircolors`
	zstyle ':completion:*:default' list-colors ${LS_COLORS}
   ;;  
esac

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
  case "${OSTYPE}" in 
	  darwin*)
		  if [ ! -h ${fpath[1]}/_brew ]; then
     			  echo "link homebrew completion to ${fpath[1]}"
			  ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh ${fpath[1]}/_brew
		  fi
		  echo "update pyenv init cache"
		  update_pyenv_init
		  echo "update rbenv init cache"
		  update_rbenv_init
		  echo "update JAVAHOME path"
		  echo $(/usr/libexec/java_home) > $ZSHHOME/java_home
	;;
  esac
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

#for z
#. `brew --prefix`/etc/profile.d/z.sh
