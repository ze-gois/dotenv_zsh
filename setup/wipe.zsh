wipe() {
    delete_all_files() {
        local target="$1"
        local repo_file="$2"
        local backupdir="$3"
        local backupuser="$4"

        if [ -e "$target" ]; then
            backup_file="$backupdir/$(date +%Y%m%d%H%M%S)_"$backupuser"_$(basename "$target")"
            cp "$target" "$backup_file"
            echo "📦 Backup de $target → $backup_file"
        fi

        rm -f "$target"
    }

    # Usuário
    for file in $ZSH_FILES; do
        delete_all_files "$ORIGINAL_HOME/.$file" \
                        "$DOTENV_ZSH_DIR/user/.$file" \
                        "$DOTENV_ZSH_DIR/user/backup" \
                        "$ORIGINAL_USER"
    done

    # Sistema
    for file in $ZSH_FILES; do
        delete_all_files "/etc/zsh/$file" \
                       "$DOTENV_ZSH_DIR/system/$file" \
                       "$DOTENV_ZSH_DIR/system/backup" \
                       "root"
    done

    # Root
    for file in $ZSH_FILES; do
        delete_all_files "/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/.$file" \
                       "$DOTENV_ZSH_DIR/root/backup" \
                       "root"
    done
}
