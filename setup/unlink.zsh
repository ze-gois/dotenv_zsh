unlink() {
    unlink_repo_files() {
        local target="$1"
        local repo_file="$2"
        local backupdir="$3"

        if [ -L "$target" ] && [ "$(realpath "$target")" = "$repo_file" ]; then
            echo "⏏ Removendo link: $target"
            rm -f "$target"

            cp "$repo_file" "$target"
            echo "⚠ Desligamos o gerenciamento do arquivo $target"
        else
            echo "✓ $target não aponta para o repositório (nada a desfazer)"
        fi
    }

    # Usuário
    for file in $ZSH_FILES; do
        unlink_repo_files "$ORIGINAL_HOME/.$file" \
                       "$DOTENV_ZSH_DIR/user/.$file" \
                       "$DOTENV_ZSH_DIR/user/backup"
    done

    # Sistema
    for file in $ZSH_FILES; do
        unlink_repo_files "/etc/zsh/$file" \
                       "$DOTENV_ZSH_DIR/system/$file" \
                       "$DOTENV_ZSH_DIR/system/backup"
    done

    # Root
    for file in $ZSH_FILES; do
        unlink_repo_files "/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/backup"
    done
}
