z() {
    if [ -z $1 ]; then
        zed --new .
    else
        if [ -e $1 ]; then
            zed --new "$@"
        else
            zed --new . "$@"
        fi
    fi
}
