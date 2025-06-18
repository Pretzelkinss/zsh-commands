index_zsh_commands() {
    local alias_dir="$HOME/.zsh_aliases"
    local index_file="$alias_dir/commands_index.zsh"
    local tmpfile
    tmpfile=$(mktemp)

    # Collect all alias names (allow letters, numbers, underscores, and dashes)
    grep -hE '^alias[[:space:]]+[-a-zA-Z0-9_]+=' "$alias_dir"/* 2>/dev/null \
        | sed -E 's/^alias[[:space:]]+([-a-zA-Z0-9_]+)=.*/\1/' > "$tmpfile"

    # Collect all function names (allow dashes as well)
    grep -hE '^[-a-zA-Z0-9_]+\s*\(\)\s*\{|^function[[:space:]]+[-a-zA-Z0-9_]+\s*\{' "$alias_dir"/* 2>/dev/null \
        | sed -E -e 's/^([-a-zA-Z0-9_]+)\s*\(\)\s*\{.*/\1/' \
                 -e 's/^function[[:space:]]+([-a-zA-Z0-9_]+)\s*\{.*/\1/' >> "$tmpfile"

    # Remove duplicates and sort
    sort -u "$tmpfile" > "$tmpfile.sorted"

    # Build the alias definition
    {
        echo "alias get-commands='echo \""
        echo "The following ALIASES and FUNCTIONS are available:"
        echo
        cat "$tmpfile.sorted"
        echo "\"'"
    } > "$index_file"

    # Clean up
    rm -f "$tmpfile" "$tmpfile.sorted"

    # Source ~/.zshrc to make the new alias available immediately
    source "$HOME/.zshrc"
}
