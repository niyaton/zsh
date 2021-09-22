export VIRTUAL_ENV_DISABLE_PROMPT=1
case "${OSTYPE}" in
  darwin*)
    export CONDA_CHANGEPS1=no
    if [ -e ~/anaconda3/etc/profile.d/conda.sh ]; then
      source ~/anaconda3/etc/profile.d/conda.sh
    fi
    ;;
  linux*)
    if which pyenv &> /dev/null; then eval "$(pyenv init -)"; fi
    # Initialize pyenv.
    # Only execute eval pyenv init on startup
    if [[ "$(whence -w pyenv 2>/dev/null )" != *(function|none) ]]; then
           eval "$(pyenv init -)"
    fi
    ;;
esac
