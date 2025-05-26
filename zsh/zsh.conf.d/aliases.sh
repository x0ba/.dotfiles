alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# ls aliases
if [ -x "$(command -v eza)" ]; then
  alias ls='eza'
  alias l='eza'
  alias ll='eza -l'
  alias la='eza -la'
  alias lt='eza -l --total-size' alias lat='eza -lA --total-size'
  alias tree='eza --tree'
else
  alias l='ls'
  alias ll='ls -l'
  alias la='ls -lA'
fi


if [ -x "$(command -v bat)" ]; then
  alias cat='bat'
fi

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
