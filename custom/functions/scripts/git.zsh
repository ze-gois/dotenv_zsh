#!/usr/bin/env zsh

gcorg() {
    ORG=$1

    if [[ -z "${ORG}" ]]; then
        echo "First and only argument is the org name"
        exit 1
    fi

    mkdir -p "${ORG}"
    cd "${ORG}"
    for repo in $(curl -s "https://api.github.com/orgs/${ORG}/repos?per_page=333"  | jq -r '.[].clone_url'); do; git clone $repo; done
}
