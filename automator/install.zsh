#! /usr/bin/env zsh
set -e

DOTFILES_DIR="${0:A:h:h}"
AUTOMATOR="${0:A:h}"

source "$AUTOMATOR/utils.zsh"

install_nerd_fonts() {
    local -a fonts=(
        ttf-iosevka-nerd
        ttf-cascadia-code-nerd
        ttf-jetbrains-mono-nerd
    )
    sudo pacman -S --needed --noconfirm "${fonts[@]}"
}

install_maple_font() {
    print "Instalando Maple Font..."
    local url fonts_dir="$HOME/.local/share/fonts/MapleFont"
    
    url=$(curl -fsSL "https://api.github.com/repos/subframe7536/Maple-font/releases/latest" | \
          grep -oP '"browser_download_url":\s*"\K[^"]*MapleMono-NF[^"]*\.zip' | head -1) || {
        print "No se pudo resolver Maple Font"
        return 1
    }
    
    mkdir -p "$fonts_dir"
    curl -fL "$url" | unzip -qo - -d "$fonts_dir"
}

install_setup() {
    install_nerd_fonts
    install_maple_font
    command -v fc-cache >/dev/null && fc-cache -f "$HOME/.local/share/fonts"
    
    if command -v tmux >/dev/null; then
        [[ ! -d ~/.tmux/plugins/tpm ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        tmux new -d && ~/.tmux/plugins/tpm/bin/install_plugins && tmux kill-server || true
    fi
}

main() {
    local mode="${1:-sync}"
    local manifest="${2:-$AUTOMATOR/MANIFEST_modules.txt}"
    
    case "$mode" in
        -h|--help) show_usage; exit 0;;
        bootstrap)
            install_packages "$AUTOMATOR/packages/base.txt"
            apply_stow "$manifest"
            install_setup
            ;;
        setup) install_setup;;
        *)
            [[ "$mode" != "sync" ]] && manifest="$mode"
            apply_stow "$manifest"
            ;;
    esac
}

show_usage() {
    local script="${0##*/}"
    print "Uso:"
    print "  $script                      # sync del manifiesto por defecto"
    print "  $script bootstrap            # instalar paquetes + dotfiles + setup"
    print "  $script sync [manifest]      # sincronizar dotfiles"
    print "  $script setup                # instalar fuentes + tmux"
    print "  $script <manifest>           # atajo para sync"
}

main "$@"
