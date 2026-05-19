if [[ -f "/opt/homebrew/bin/brew" ]] then
    # If you're using macOS, you'll want this enabled
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

bindkey -v
export KEYTIMEOUT=1

# Habilitar Ctrl+R en modo VI para búsqueda histórica
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward

zinit ice from"gh-r" as"command"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab
zinit load junegunn/fzf

# Configurar history-substring-search en VI mode
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^N' history-substring-search-down
bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

bindkey -s ^f "tmux_sessionizer\n"

alias ls='eza  --group-directories-first'

# Lista detallada (equivalente a ll)
alias ll='eza -lh  --group-directories-first'

# Lista detallada incluyendo archivos ocultos (equivalente a la)
alias la='eza -a -lh  --group-directories-first'

# Vista en árbol (muy útil en eza)
alias tree='eza --tree '
