function preexec_logger(){
        arg="$3"
        check=`command git rev-parse --is-inside-work-tree 2> /dev/null`
        root_path=`command git rev-parse --show-toplevel 2> /dev/null`

        if [[ $arg =~ ^git\  ]] && [ "$check" = "true" ]; then
                timestamp=`date +"%Y%m%d-%H%M%S"`
                before_sha=`command git rev-parse --verify HEAD`
                echo LOG,"$timestamp,$root_path,${PWD},$arg,$before_sha" >> $HOME/.git_history
        fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_logger
