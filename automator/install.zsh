#! /usr/bin/env zsh
set -e

DOTFILES_DIR="${0:A:h:h}"
AUTOMATOR="${0:A:h}"
SCRIPT_NAME="${0:t}"
DEFAULT_MANIFEST="$AUTOMATOR/MANIFEST_modules.txt"

source "$AUTOMATOR/utils.zsh"

show_usage() {
    print "Uso:"
    print "  $SCRIPT_NAME                             # sync del manifiesto por defecto"
    print "  $SCRIPT_NAME bootstrap [manifest]"
    print "  $SCRIPT_NAME sync [manifest]"
    print "  $SCRIPT_NAME refresh [manifest]"
    print "  $SCRIPT_NAME <manifest>                 # atajo para sync"
    print "  Formato manifiesto: modulo  |  target  (target opcional)"
}

resolve_manifest() {
    local selector=$1

    if [[ -f "$selector" ]]; then
        print -- "$selector"
        return 0
    fi

    if [[ -f "$AUTOMATOR/$selector" ]]; then
        print -- "$AUTOMATOR/$selector"
        return 0
    fi

    print -- "$selector"
}

install_tmux_plugins() {
    if ! command -v tmux >/dev/null 2>&1; then
        print "tmux no esta instalado; se omite instalacion de plugins."
        return 0
    fi

    if [[ ! -d ~/.tmux/plugins/tpm ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    tmux new -d && ~/.tmux/plugins/tpm/bin/install_plugins && tmux kill-server
}

MODE=${1:-sync}
SELECTOR=${2:-$DEFAULT_MANIFEST}
MANIFEST=""

if [[ "$MODE" == "help" || "$MODE" == "--help" || "$MODE" == "-h" ]]; then
    show_usage
    exit 0
fi

if [[ "$MODE" != "bootstrap" && "$MODE" != "sync" && "$MODE" != "refresh" ]]; then
    if (( $# > 1 )); then
        print "Argumentos invalidos."
        show_usage
        exit 1
    fi
    SELECTOR="$MODE"
    MODE="sync"
fi

MANIFEST=$(resolve_manifest "$SELECTOR")

if [[ "$MODE" == "bootstrap" ]]; then
    install_packages "$AUTOMATOR/packages/base.txt"
    apply_stow "$MANIFEST"
    install_tmux_plugins
else
    apply_stow "$MANIFEST"
fi
