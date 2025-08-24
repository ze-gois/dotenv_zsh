chpath() {
    if [ -z "$1" ]; then
        echo "PATH=$PATH"
        return 1
    fi
    if [ -z "$2" ]; then
        if [ "$1" = "c" ]; then
            export PATH=""
            return 0
        fi
        echo "path_add requires two arguments"
        return 2
    fi

    if [ "$1" = "c" ]; then
        echo "[c]lear can only be evoked with single argument"
        return 1
    fi

    if [ -z "$3" ]; then
        # echo "ok followup"
    else
        echo "path_add do only do 2 arguments"
        return 3
    fi

    if [ -d "$2" ]; then
        if [ "$1" = "p" ]; then
            export PATH="$2":$PATH
            return 0
        fi

        if [ "$1" = "a" ]; then
            export PATH=$PATH:"$2"
            return 0
        fi

        if [ "$1" = "x" ]; then
            export PATH=$PATH
        fi

        echo "first argument shall be either [a]ppend or [p]repend"
    else
        echo "path_add: $2 is not a directory"
    fi
}
