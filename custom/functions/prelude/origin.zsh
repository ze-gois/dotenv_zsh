origin() {
    SOURCE="$1"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      TARGET="$(readlink "$SOURCE")"
      if [[ $TARGET == /* ]]; then
        # echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
        SOURCE="$TARGET"
        echo "$TARGET"
      else
        DIR="$( dirname "$SOURCE" )"
        # echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
        SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        echo "$SOURCE"
      fi
    done
}

current() {
    CURRENT_ZSHRC="${(%):-%x}"
    echo "$(realpath $(origin $CURRENT_ZSHRC))"
}
