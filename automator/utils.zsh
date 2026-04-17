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

trim_whitespace() {
    local value=$1
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    print -- "$value"
}

manifest_entries() {
    local manifest=$1
    local -a lines
    local -a parts
    local line module target raw_module raw_target

    lines=("${(@f)$(<"$manifest")}")

    for line in $lines; do
        if [[ "$line" =~ ^[[:space:]]*# || -z "${line//[[:space:]]/}" ]]; then
            continue
        fi

        if [[ "$line" == *"|"* ]]; then
            raw_module=${line%%|*}
            raw_target=${line#*|}
            module=$(trim_whitespace "$raw_module")
            target=$(trim_whitespace "$raw_target")
            target=${target:-$HOME}
        else
            parts=(${(z)line})
            module=$parts[1]
            target=${parts[2]:-$HOME}
        fi

        if [[ -z "$module" ]]; then
            print "Entrada invalida en manifiesto (modulo vacio): $line"
            return 1
        fi

        target=${~target}

        print -- "$module"$'\t'"$target"
    done
}

apply_module_stow() {
    local module=$1
    local target=$2
    local preview_output
    local preview_status

    preview_output=$(stow -n -R -t "$target" -d "$DOTFILES_DIR" "$module" 2>&1)
    preview_status=$?

    if (( preview_status != 0 )); then
        if [[ "$preview_output" == *"would cause conflicts"* ]]; then
            print "Conflictos detectados en $module; aplicando --adopt."
            if ! stow --adopt -R -t "$target" -d "$DOTFILES_DIR" "$module"; then
                print "Error en modulo durante adopcion: $module"
                return 1
            fi
            return 0
        fi

        print -- "$preview_output"
        print "Error validando modulo: $module"
        return 1
    fi

    if ! stow -R -t "$target" -d "$DOTFILES_DIR" "$module"; then
        print "Error en modulo: $module"
        return 1
    fi
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

        if ! apply_module_stow "$module" "$target"; then
            return 1
        fi
    done

    : >| "$state_file"
    if (( ${#current_entries[@]} > 0 )); then
        printf '%s\n' "${current_entries[@]}" >| "$state_file"
    fi
}
