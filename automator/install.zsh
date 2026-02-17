#! /usr/bin/env zsh
set -e

DOTFILES_DIR="${0:A:h:h}"
AUTOMATOR="${0:A:h}"

source "$AUTOMATOR/utils.zsh"

print "Selecciona perfil"
select PROFILE in bare-minimum smol chattini; do
    [[ -n $PROFILE ]] && break
done

if [[ $PROFILE == bare-minimum || $PROFILE == smol || $PROFILE == chattini ]]; then
    if install_packages "$AUTOMATOR/packages/base.txt"; then
        apply_stow "$AUTOMATOR/MANIFEST_base.txt"
    fi

    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    tmux new -d && ~/.tmux/plugins/tpm/bin/install_plugins && tmux kill-server
fi

