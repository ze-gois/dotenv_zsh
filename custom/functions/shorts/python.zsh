p() {
    export PYTHONSTARTUP=~/back/lang/python/startup/main.py
    ipython "$@"
}

j() {
    export PYTHONSTARTUP=~/back/lang/python/startup/main.py
    jupyter lab
}
