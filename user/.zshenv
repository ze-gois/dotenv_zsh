export BACKUP_PATH="/backup"
export DOTENV_PATH=$BACKUP_PATH/dotenv
export DOTENV_ZSH_PATH=$DOTENV_PATH/zsh

ct() {
    $DOTENV_PATH/sway/scripts/twitch/seek.sh
}

. "$HOME/.cargo/env"
