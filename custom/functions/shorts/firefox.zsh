f() {
    if [ -z "$1" ]; then
        if [ -f './index.html' ]; then
            firefox --new-window ./index.html
        else
            firefox --new-window .
        fi
    else
      firefox --new-window "$@"
    fi
}
