#!/usr/bin/zsh
# Caminho absoluto deste script (resolve symlink se houver)
ZSH_FILES=("zlogin" "zlogout" "zprofile" "zshenv" "zshrc")

current() {
    CURRENT_ZSHRC="${(%):-%x}"
    echo "$(realpath "$CURRENT_ZSHRC")"
}

DOTENV_ZSH_SETUP_DIR=$(dirname "$(current)")
DOTENV_ZSH_DIR=$(dirname $DOTENV_ZSH_SETUP_DIR)
DOTENV_ZSH_DIR="$DOTENV_ZSH_DIR/zsh"
echo $DOTENV_ZSH_DIR
# echo $(realpath "$DOTENV_ZSH_DIR/..")

# Rodar como root, se necessário
if [ "$(id -u)" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

# Detectar usuário original
ORIGINAL_USER=${SUDO_USER:-$(whoami)}
ORIGINAL_HOME=$(eval echo "~$ORIGINAL_USER")

source "$DOTENV_ZSH_DIR/setup/status.zsh"
source "$DOTENV_ZSH_DIR/setup/install.zsh"
source "$DOTENV_ZSH_DIR/setup/uninstall.zsh"
source "$DOTENV_ZSH_DIR/setup/unlink.zsh"
source "$DOTENV_ZSH_DIR/setup/mimic.zsh"
source "$DOTENV_ZSH_DIR/setup/wipe.zsh"
# Dispatcher
case "$1" in
    wipe)
        wipe
        ;;
    status)
        status
        ;;
    install)
        install
        ;;
    uninstall)
        uninstall
        ;;
    unlink)
        unlink
        ;;
    mimic)
        mimic
        ;;
    *)
        echo "Uso: $0 {install|uninstall|unlink|mimic}"
        exit 1
        ;;
esac
