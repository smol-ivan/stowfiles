install_packages() {
    local file=$1
    sudo pacman -S --needed --noconfirm $(<"$file")
}

apply_stow() {
    local manifesto=$1

    if [[ ! -f "$manifesto" ]]; then
        print "Manifiesto no encontrado: $manifesto"
        return 1
    fi

    local lines=("${(@f)$(<"$manifesto")}")

    for line in $lines; do
        if [[ "$line" =~ ^[[:space:]]*# || -z "${line// }" ]]; then
            continue
        fi

        local parts=(${(z)line})
        local module=$parts[1]
        local target=${parts[2]:-$HOME}

        # Expandir ~ a la ruta completa de casa si existe
        target=${~target}

        print "Aplicando stow:$module -t $target"

        [[ ! -d "$target" ]] && mkdir -p "$target"

        if ! stow -R -t "$target" -d "$DOTFILES_DIR" "$module"; then
            print "Error en modulo: $module"
            return 1
        fi
    done
}
