if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source ~/.config/zsh/zsh.conf.d/*

autoload -U compinit; compinit

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# source plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

