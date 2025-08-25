
install(){
    # Estrutura de pastas
    mkdir -p "$DOTENV_ZSH_DIR"/{private,system/backup,root/backup,user/backup}

    link_with_backup() {
        local src="$1"   # arquivo existente (ex: ~/.zshrc)
        local dst="$2"   # alvo no repositório (ex: ~/dotfiles_zsh/user/.zshrc)
        local backupdir="$3"

        # Resolve link real (se existir)
        [ -e "$src" ] && real_src="$(realpath "$src")" || real_src=""

        if [ "$real_src" = "$dst" ]; then
            echo "✓ $src já aponta para $dst"
        else
            if [ -e "$src" ]; then
                backup_file="$backupdir/$(date +%Y%m%d%H%M%S)_$(whoami)_$(basename "$src")"
                cp "$src" "$backup_file"
                echo "📦 Backup de $src → $backup_file"
                rm -f "$src"
            fi
            ln -s "$dst" "$src"
            echo "🔗 Link criado: $src → $dst"
        fi
    }

    # Usuário normal
    for file in $ZSH_FILES; do
        link_with_backup "$ORIGINAL_HOME/.$file" \
                        "$DOTENV_ZSH_DIR/user/.$file" \
                        "$DOTENV_ZSH_DIR/user/backup"
                        sudo chown -h "$ORIGINAL_USER":"$(id -gn "$ORIGINAL_USER")" "$ORIGINAL_HOME/.$file"
    done

    # Sistema
    for file in $ZSH_FILES; do
        link_with_backup "/etc/zsh/$file" \
                        "$DOTENV_ZSH_DIR/system/$file" \
                        "$DOTENV_ZSH_DIR/system/backup"
        # sudo chown -h "$ORIGINAL_USER":"$(id -gn "$ORIGINAL_USER")" "$ORIGINAL_HOME/.$file"
    done

    # Root
    for file in $ZSH_FILES; do
        link_with_backup "/root/.$file" \
                        "$DOTENV_ZSH_DIR/root/.$file" \
                        "$DOTENV_ZSH_DIR/root/backup"
        # sudo chown -h "$ORIGINAL_USER":"$(id -gn "$ORIGINAL_USER")" "$ORIGINAL_HOME/.$file"
    done
}
