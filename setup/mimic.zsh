mimic() {
    mimic_repo_files() {
        local target="$1"
        local repo_file="$2"
        local backupdir="$3"

        if [ -L "$target" ] && [ "$(realpath "$target")" = "$repo_file" ]; then
            echo "⏏ Removendo link: $target"
            rm -f "$target"

            cp "$repo_file" "$target"
            echo "⚠ Desligamos o gerenciamento do arquivo $target"
        else
            if [ -e "$target" ]; then
                echo -n "⚠ $target já existe, removendo..."
                rm "$target"
                echo "removido."
            else
                echo "⚠ $target não existe"

                if [ -L "$target" ]; then
                    rm "$target"
                fi
            fi

            cp "$repo_file" "$target"

            ls -la "$target"
        fi
    }

    # Usuário
    for file in $ZSH_FILES; do
        mimic_repo_files "$ORIGINAL_HOME/.$file" \
                       "$DOTENV_ZSH_DIR/user/.$file" \
                       "$DOTENV_ZSH_DIR/user/backup"
        chown "$ORIGINAL_USER" "$ORIGINAL_HOME/.$file"
        chgrp $(id -gn "$ORIGINAL_USER") "$ORIGINAL_HOME/.$file"
    done

    # Sistema
    for file in $ZSH_FILES; do
        mimic_repo_files "/etc/zsh/$file" \
                       "$DOTENV_ZSH_DIR/system/$file" \
                       "$DOTENV_ZSH_DIR/system/backup"
    done

    # Root
    for file in $ZSH_FILES; do
        mimic_repo_files "/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/backup"
    done
}
