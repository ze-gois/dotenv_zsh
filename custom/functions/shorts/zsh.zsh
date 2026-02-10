
pathx() {
    for f in $(echo $PATH | tr ':' '\n'); do; find $f -maxdepth 1 -type f -executable; done
}
