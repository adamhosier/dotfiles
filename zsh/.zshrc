# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Env
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERM="xterm-256color"
export LANG="C.UTF-8"
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.go/bin"

# Git aliases
alias gca='git add -A && git commit --amend --no-edit'
alias gpf='git push --set-upstream origin "$(git-branch-current 2> /dev/null)" --force'
alias gs='git status --short'
alias gl='git log'
alias gcn='git add -A && git commit -am'
alias gc='git checkout'
alias gb='git branch'
alias grc='git add -A && git rebase --continue'
alias grom='git fetch -a && git rebase origin/master'

# Kubectl aliases
function kns { export KUBECTL_NAMESPACE="$1" }
alias k='kubectl "--context=${KUBECTL_CONTEXT:-$(kubectl config current-context)}" ${KUBECTL_NAMESPACE/[[:alnum:]-]*/--namespace=${KUBECTL_NAMESPACE}}'
alias kg='k get'
alias kd='k describe'
alias kgp='k get pod'
alias kdp='k describe pod'
alias kgd='k get deployment'
alias kdd='k describe deployment'
alias kgs='k get service'
alias kds='k describe service'
alias kgn='k get node'
alias kdn='k describe node'
alias kabb='k apply -f https://k8s.io/examples/admin/dns/busybox.yaml'
alias kebb='k exec -it busybox --'
alias kdbb='k delete po busybox'
alias kb='kustomize build --enable_alpha_plugins'
alias kastdin='k apply -f -'

# Terraform aliases
alias t='terraform'
alias ti='t init'
alias tp='t plan'
alias ta='t apply'
alias to='t output'
alias td='t destroy'

# Direnv hook
eval "$(direnv hook zsh)"

# FZF hook
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
