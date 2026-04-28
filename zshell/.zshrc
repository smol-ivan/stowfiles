eval "$(starship init zsh)"

[[ -n "$SSH_CONNECTION" ]] && export ZSH_REMOTE=1

source ~/.zsh/base.zsh
source ~/.zsh/env.zsh

if [[ -n "$ZSH_REMOTE" ]]; then
    source ~/.zsh/remote.zsh
else
    source ~/.zsh/local.zsh
fi

