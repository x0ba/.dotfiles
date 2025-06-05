# Load more completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist
