zstyle :compinstall filename "${HOME}/.zshrc"
autoload -Uz compinit
compinit

autoload zed

#setting keybind
bindkey -v

#setting cd history
setopt auto_pushd

#coloring ls
eval `dircolors ~/.dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     echo 'compiling zshrc.' $i
     zcompile $i
  done
}

function tar-pbzip2() {
    tar cf $1 --use-compress-program=pbzip2 $argv[2,-1]
}

#avoindg duplicated path
typeset -U path PATH
