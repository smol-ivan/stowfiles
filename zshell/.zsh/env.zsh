export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.docker/bin:$PATH

eval "$(fnm env --use-on-cd --shell zsh)"
