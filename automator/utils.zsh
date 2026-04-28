install_packages() {
    [[ ! -f "$1" ]] && { print "Paquetes no encontrado: $1"; return 1; }
    
    local -a packages=()
    local line
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# || -z "${line//[[:space:]]/}" ]] && continue
        packages+=("$line")
    done < "$1"
    
    (( ${#packages[@]} > 0 )) && sudo pacman -S --needed --noconfirm "${packages[@]}"
}

trim_whitespace() {
    local value="$1"
    value="${value#"${value%%[![:space:]]*}"}"
    value="${value%"${value##*[![:space:]]}"}"
    print -- "$value"
}

normalize_manifest_entry() {
    local entry="$1"
    local module target
    
    if [[ "$entry" == *"|"* ]]; then
        module="${entry%%|*}"
        target="${entry#*|}"
    else
        module="$entry"
        target="$HOME"
    fi
    
    module=$(trim_whitespace "$module")
    target=$(trim_whitespace "$target")
    target=${~target}
    target=${target:-$HOME}
    
    [[ -z "$module" ]] && return 1
    print -- "$module"$'\t'"$target"
}

manifest_entries() {
    local manifest=$1
    local line module target
    
    [[ ! -f "$manifest" ]] && { print "Manifiesto no encontrado: $manifest" >&2; return 1; }
    
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# || -z "${line//[[:space:]]/}" ]] && continue
        
        if ! normalize_manifest_entry "$line"; then
            print "Entrada inválida: $line" >&2
            return 1
        fi
    done < "$manifest"
}

apply_stow() {
    local manifest="${1:A}"
    local -a current_entries
    local -A seen
    local entry module target
    
    [[ ! -f "$manifest" ]] && { print "Manifiesto no encontrado: $manifest"; return 1; }
    
    while IFS= read -r entry; do
        [[ -z "$entry" ]] && continue
        
        if [[ -n "${seen[$entry]}" ]]; then
            print "Duplicado: $entry"
            return 1
        fi
        seen[$entry]=1
        current_entries+=("$entry")
    done < <(manifest_entries "$manifest")
    
    for entry in "${current_entries[@]}"; do
        module=${entry%%$'\t'*}
        target=${entry#*$'\t'}
        
        [[ ! -d "$target" ]] && mkdir -p "$target"
        
        print "Aplicando stow: $module -t $target"
        
        if ! stow -n -R -t "$target" -d "$DOTFILES_DIR" "$module" 2>/dev/null; then
            print "Conflictos detectados; usando --adopt"
            stow --adopt -R -t "$target" -d "$DOTFILES_DIR" "$module" || {
                print "Error: $module"
                return 1
            }
        else
            stow -R -t "$target" -d "$DOTFILES_DIR" "$module" || {
                print "Error: $module"
                return 1
            }
        fi
    done
}
