#!/bin/bash

PYENV_REPOS_URL=https://github.com/yyuu/pyenv.git
PYENV_VIRTUALENV_REPOS_URL=https://github.com/yyuu/pyenv-virtualenv.git

main() {
    if [ -d ~/.pyenv ]; then
        exit 1
    fi

    git clone $PYENV_REPOS_URL ~/.pyenv

    if [ -d ~/.pyenv/plugins/pyenv-virtualenv ]; then
        exit 1
    fi

    git clone $PYENV_VIRTUALENV_REPOS_URL ~/.pyenv/plugins/pyenv-virtualenv

}

main "$@"
