
checkoutMaster() {
    git submodule foreach '
        git checkout master
        git pull --rebase
    '
}

syncCode() {
    git pull --rebase
    git submodule update --init --rebase
}

syncCode
checkoutMaster
