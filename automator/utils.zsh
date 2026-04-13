install_packages() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        print "Archivo de paquetes no encontrado: $file"
        return 1
    fi

    local -a packages
    local -a lines
    local line
    lines=("${(@f)$(<"$file")}")

    for line in $lines; do
        if [[ "$line" =~ ^[[:space:]]*# || -z "${line//[[:space:]]/}" ]]; then
            continue
        fi
        packages+=("$line")
    done

    if (( ${#packages[@]} == 0 )); then
        print "No hay paquetes para instalar en: $file"
        return 0
    fi

    sudo pacman -S --needed --noconfirm "${packages[@]}"
}

manifest_state_file() {
    local state_root="${XDG_STATE_HOME:-$HOME/.local/state}/stowfiles"
    local state_hash

    state_hash=$(print -n -- "${DOTFILES_DIR:A}" | sha256sum | awk '{print $1}')
    mkdir -p "$state_root"
    print -- "$state_root/$state_hash.entries"
}

manifest_entries() {
    local manifest=$1
    local -a lines
    local -a parts
    local line module target

    lines=("${(@f)$(<"$manifest")}")

    for line in $lines; do
        if [[ "$line" =~ ^[[:space:]]*# || -z "${line//[[:space:]]/}" ]]; then
            continue
        fi

        parts=(${(z)line})
        module=$parts[1]
        target=${parts[2]:-$HOME}
        target=${~target}

        print -- "$module"$'\t'"$target"
    done
}

apply_stow() {
    local manifest="${1:A}"
    local state_file
    local -a current_entries
    local -a previous_entries
    local -A current_map
    local -A previous_map
    local entry module target

    if [[ ! -f "$manifest" ]]; then
        print "Manifiesto no encontrado: $manifest"
        return 1
    fi

    state_file=$(manifest_state_file)
    current_entries=("${(@f)$(manifest_entries "$manifest")}")
    previous_entries=()
    [[ -f "$state_file" ]] && previous_entries=("${(@f)$(<"$state_file")}")

    for entry in $current_entries; do
        if [[ -n "${current_map[$entry]}" ]]; then
            print "Entrada duplicada en manifiesto: $entry"
            return 1
        fi
        current_map["$entry"]=1
    done

    for entry in $previous_entries; do
        previous_map["$entry"]=1
    done

    for entry in ${(k)previous_map}; do
        if [[ -n "${current_map[$entry]}" ]]; then
            continue
        fi

        module=${entry%%$'\t'*}
        target=${entry#*$'\t'}

        print "Desactivando stow: $module -t $target"

        if ! stow -D -t "$target" -d "$DOTFILES_DIR" "$module"; then
            print "Error en modulo al desactivar: $module"
            return 1
        fi
    done

    for entry in $current_entries; do
        module=${entry%%$'\t'*}
        target=${entry#*$'\t'}

        print "Aplicando stow: $module -t $target"

        [[ ! -d "$target" ]] && mkdir -p "$target"

        if ! stow -R -t "$target" -d "$DOTFILES_DIR" "$module"; then
            print "Error en modulo: $module"
            return 1
        fi
    done

    : >| "$state_file"
    if (( ${#current_entries[@]} > 0 )); then
        printf '%s\n' "${current_entries[@]}" >| "$state_file"
    fi
}
