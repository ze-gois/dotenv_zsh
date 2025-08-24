uninstall() {
    restore_backup() {
        local target="$1"
        local repo_file="$2"
        local backupdir="$3"

        if [ -L "$target" ] && [ "$(realpath "$target")" = "$repo_file" ]; then
            echo "⏏ Removendo link: $target"
            rm -f "$target"

            latest_backup=$(ls -t "$backupdir"/*_$(whoami)_$(basename "$target") 2>/dev/null | head -n 1)
            if [ -n "$latest_backup" ]; then
                cp "$latest_backup" "$target"
                echo "📦 Restaurado backup: $latest_backup → $target"
            else
                echo "⚠ Nenhum backup encontrado para $target"
                cp "$repo_file" "$target"
            fi
        else
            echo "✓ $target não aponta para o repositório (nada a desfazer)"
        fi
    }

    # Usuário
    for file in $ZSH_FILES; do
        restore_backup "$ORIGINAL_HOME/.$file" \
                       "$DOTENV_ZSH_DIR/user/.$file" \
                       "$DOTENV_ZSH_DIR/user/backup"
    done

    # Sistema
    for file in $ZSH_FILES; do
        restore_backup "/etc/zsh/$file" \
                       "$DOTENV_ZSH_DIR/system/$file" \
                       "$DOTENV_ZSH_DIR/system/backup"
    done

    # Root
    for file in $ZSH_FILES; do
        restore_backup "/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/backup"
    done
}
