fpath=(~/.zsh/functions/ ${fpath})
autoload -U compinit
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
     zcompile $i
  done
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

#for z
#. `brew --prefix`/etc/profile.d/z.sh



