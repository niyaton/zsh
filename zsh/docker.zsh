# from http://qiita.com/ariarijp/items/2af853d5ba0f98d98bc6
function dkgrep() {
    local FILTER
    if [[ $1 == "" ]]; then
        FILTER="fzf -m"
    else
        FILTER="fzf --query $1"
    fi
    docker ps -a | ${=FILTER} | awk '{ print $1 }'
}

function dkkill() {
    local QUERY
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# -gt 0 ]] && shift
    fi
    dkgrep $QUERY | xargs docker kill $*
}

function dkrm() {
    local QUERY
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# -gt 0 ]] && shift
    fi
    dkgrep $QUERY | xargs docker rm $*
}
