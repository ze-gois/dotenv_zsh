f() {
    if [ -z $1 ]; then
      firefox --new-window .
    else
      firefox --new-window "$@"
    fi
}
