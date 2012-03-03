autoload -U compinit
compinit

autoload zed

setopt prompt_subst
setopt extended_glob

#setting prompt
SPROMPT=$'%B%{\e[1;34m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
PROMPT=$'%{\e[%(!.0;31.1;32)m%}%n %(!.#.$)%{\e[m%} '
PROMPT2=$'%{\e[%(!.0;31.1;32)m%}%n %(!.#.$)%{\e[m%} '
RPROMPT=$'%{\e[0;33m%}[%~]%{\e[m%}'

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT=$'%{\e[35m%}'"${HOST%%.*} ${PROMPT}"

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

#for use macvim on CUI
case "${OSTYPE}" in
darwin*)
	MacVim=/Applications/MacVim.app/Contents/MacOS/Vim
	alias mvim='env $MacVim -u $HOME/.vimrc "$@"'
esac

ZSHHOME="${HOME}/.zsh"

update_zshrc(){
  zcompile ~/.zshrc
  for i in $ZSHHOME/*.zsh; do
     zcompile $i
  done
}

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
