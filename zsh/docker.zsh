# from http://qiita.com/ariarijp/items/2af853d5ba0f98d98bc6
function dkgrep() {
    local PERCOL
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    docker ps -a | ${=PERCOL} | awk '{ print $1 }'
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
