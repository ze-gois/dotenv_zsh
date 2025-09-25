ct() {
    url=$($DOTENV_PATH/sway/scripts/twitch/chromium_history.py | shuf -n1)
    chromium --new-window --app="https://www.twitch.tv/$url"
}
