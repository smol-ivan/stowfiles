if [[ -z "$SSH_CONNECTION" ]] && [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -n "$SSH_CONNECTION" ]] && export ZSH_REMOTE=1

source ~/.zsh/base.zsh
source ~/.zsh/env.zsh

if [[ -n "$ZSH_REMOTE" ]]; then
    source ~/.zsh/remote.zsh
else
    source ~/.zsh/local.zsh
fi

