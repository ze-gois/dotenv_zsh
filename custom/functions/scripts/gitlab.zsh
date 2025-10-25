glab_group_fetch() {
    # Group you want to clone
    GROUP=${1:-"lappsufrn"}

    # Directory to store clones
    DEST_DIR=${2:-"$HOME/gitlab/$GROUP"}

    mkdir -p "$DEST_DIR"
    cd "$DEST_DIR" || exit

    # List all projects in the group and clone each
    # glab repo list "$GROUP" --all --json ssh_url_to_repo --jq '.[].ssh_url_to_repo' |

    repo=$(glab repo search -s "lappsufrn" | grep 'http[^ ]\+' -o)
    while read -r repo; do
        dir=$(basename "$repo" .git)
        if [ -d "$dir" ]; then
            echo "Updating $dir..."
            git -C "$dir" pull
        else
            echo "Cloning $repo..."
            git clone "$repo"
        fi
    done
}
