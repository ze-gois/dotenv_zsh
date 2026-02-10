#!/usr/bin/env zsh

gcorg() {
    ORG=$1
    DEPTH=$2

    if [[ -z "${ORG}" ]]; then
        echo "First and only argument is the org name"
        return 1
    fi

    DO_DEPTH=TRUE
    if [[ -z "${DEPTH}" ]]; then
        DO_DEPTH=FALSE
    fi

    mkdir -p "${ORG}"
    cd "${ORG}"
    for repo in $(curl -s "https://api.github.com/orgs/${ORG}/repos?per_page=333"  | jq -r '.[].clone_url'); do;
        if [[ "${DO_DEPTH}" == "TRUE" ]]; then
            git clone --depth "${DEPTH}" $repo
        else
            git clone $repo
        fi
    done
}
