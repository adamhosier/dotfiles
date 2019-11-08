# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Env
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=nvim
export VISUAL="$EDITOR"

# Direnv
eval "$(direnv hook zsh)"

# Git aliases
alias gca='git add -A && git commit --amend --no-edit'
alias gpf='git push --set-upstream origin "$(git-branch-current 2> /dev/null)" --force'
alias gs='git status --short'
alias gl='git log'
alias gcn='git add -A && git commit -am'
alias gc='git checkout'
alias grc='git add -A && git rebase --continue'
alias grom='git fetch -a && git rebase origin/master'

# Direnv hook
eval "$(direnv hook zsh)"

# FZF hook
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
