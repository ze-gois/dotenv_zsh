source_batch() {
    if [ -z "$1" ]; then
        echo "Nothing to source"
    else
        for f in $@; do
            if [ -d "$f" ]; then
                for f in $f/**/*.zsh; do
                    echo source "$f"
                    source "$f"
                done
                continue
            fi
            if [ -e "$f" ]; then
                echo source "$f"
                source "$f"
                continue
            fi
            echo "$f not existing"
        done
    fi
}
