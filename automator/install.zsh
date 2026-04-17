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
    print "  $SCRIPT_NAME setup                       # tareas de entorno (fuentes + tmux/tpm)"
    print "  $SCRIPT_NAME <manifest>                 # atajo para sync"
    print "  Formato manifiesto: modulo  |  target  (target opcional)"
    print "  Conflictos con archivos existentes: se resuelven con stow --adopt"
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

install_nerd_fonts() {
    local -a requested_fonts
    local -a available_fonts
    local -a missing_fonts
    local font

    requested_fonts=(
        ttf-iosevka-nerd
        ttf-cascadia-code-nerd
        ttf-jetbrains-mono-nerd
    )

    for font in $requested_fonts; do
        if pacman -Si "$font" >/dev/null 2>&1; then
            available_fonts+=("$font")
        else
            missing_fonts+=("$font")
        fi
    done

    if (( ${#available_fonts[@]} > 0 )); then
        sudo pacman -S --needed --noconfirm "${available_fonts[@]}"
    fi

    if (( ${#missing_fonts[@]} > 0 )); then
        print "Fuentes no disponibles en pacman: ${missing_fonts[*]}"
    fi
}

resolve_maple_download_url() {
    local api_url="https://api.github.com/repos/subframe7536/Maple-font/releases/latest"
    local release_data
    local -a urls
    local url
    local -a preferred_assets
    local asset

    release_data=$(curl -fsSL "$api_url") || return 1
    urls=("${(@f)$(print -- "$release_data" | awk -F'"' '/"browser_download_url":/ {print $4}')}")
    preferred_assets=(
        MapleMono-NF-CN.zip
        MapleMono-NF.zip
        MapleMono-CN.zip
    )

    for asset in $preferred_assets; do
        for url in $urls; do
            if [[ "$url" == *"/$asset" ]]; then
                print -- "$url"
                return 0
            fi
        done
    done

    return 1
}

install_maple_font() {
    local maple_url
    local tmp_dir
    local archive_file
    local fonts_dir="$HOME/.local/share/fonts/MapleFont"

    maple_url=$(resolve_maple_download_url) || {
        print "No se pudo resolver descarga de Maple Font."
        return 1
    }

    tmp_dir=$(mktemp -d) || return 1
    archive_file="$tmp_dir/maple.zip"

    if ! curl -fL "$maple_url" -o "$archive_file"; then
        rm -rf "$tmp_dir"
        print "No se pudo descargar Maple Font."
        return 1
    fi

    mkdir -p "$fonts_dir"

    if ! unzip -qo "$archive_file" -d "$fonts_dir"; then
        rm -rf "$tmp_dir"
        print "No se pudo extraer Maple Font."
        return 1
    fi

    rm -rf "$tmp_dir"
}

refresh_font_cache() {
    if command -v fc-cache >/dev/null 2>&1; then
        fc-cache -f "$HOME/.local/share/fonts"
        return 0
    fi

    print "fc-cache no esta disponible; instala fontconfig para refrescar cache."
}

install_fonts() {
    install_nerd_fonts
    install_maple_font
    refresh_font_cache
}

run_environment_setup() {
    install_fonts
    install_tmux_plugins
}

MODE=${1:-sync}
SELECTOR=${2:-$DEFAULT_MANIFEST}
MANIFEST=""

if [[ "$MODE" == "help" || "$MODE" == "--help" || "$MODE" == "-h" ]]; then
    show_usage
    exit 0
fi

if [[ "$MODE" != "bootstrap" && "$MODE" != "sync" && "$MODE" != "refresh" && "$MODE" != "setup" ]]; then
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
    run_environment_setup
elif [[ "$MODE" == "setup" ]]; then
    run_environment_setup
else
    apply_stow "$MANIFEST"
fi
