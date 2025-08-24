
status(){
    # Estrutura de pastas
    mkdir -p "$DOTENV_ZSH_DIR"/{private,system/backup,root/backup,user/backup}

    verify_existence () {
        local src="$1"   # arquivo existente (ex: ~/.zshrc)
        local dst="$2"   # alvo no repositório (ex: ~/dotfiles_zsh/user/.zshrc)
        local backupdir="$3"

        ls -la "$src"
        ls -la "$dst"
        # Resolve link real (se existir)
        [ -e "$src" ] && real_src="$(realpath "$src")" || real_src=""


        if [ "$real_src" = "$dst" ]; then
            echo "✓ $src já aponta para $dst"
        else
            if [ -e "$src" ]; then
                echo "📦 Backup de $src → $backup_file"
            fi
            echo "🔗 Link criado: $src → $dst"
        fi
    }

    # Usuário normal
    for file in $ZSH_FILES; do
        verify_existence  "$ORIGINAL_HOME/.$file" \
                        "$DOTENV_ZSH_DIR/user/.$file" \
                        "$DOTENV_ZSH_DIR/user/backup"
    done

    # Sistema
    for file in $ZSH_FILES; do
        verify_existence  "/etc/zsh/$file" \
                        "$DOTENV_ZSH_DIR/system/$file" \
                        "$DOTENV_ZSH_DIR/system/backup"
    done

    # Root
    for file in $ZSH_FILES; do
        verify_existence  "/root/.$file" \
                        "$DOTENV_ZSH_DIR/root/.$file" \
                        "$DOTENV_ZSH_DIR/root/backup"
    done
}
