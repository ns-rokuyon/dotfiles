#!/bin/bash

BOOST_VERSION=1.58.0
BOOST_VERSION_NAME=`echo $BOOST_VERSION | tr '.' '_'`
BOOST_URL=https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_NAME}.tar.gz
#BOOST_URL=https://github.com/boostorg/boost/archive/boost-${BOOST_VERSION}.tar.gz
TMP_DIR=/tmp/boost
INSTALL_DIR=$HOME/local/boost-${BOOST_VERSION}

CREATE_USER_CONFIG=no
PYTHON_VERSION=3.5

create_user_config() {
    conffile=$HOME/user-config.jam
    if [ -f $conffile ]; then
        rm $conffile
    fi
    PYENV_PYTHONDIR=$HOME/.pyenv/versions/`pyenv global`

    echo "using python : $PYTHON_VERSION : $PYENV_PYTHONDIR : $PYENV_PYTHONDIR/include/python3.5m : $PYENV_PYTHONDIR/lib ;" > $conffile
}

main() {
    set -e

    if [ -d $TMP_DIR ]; then
        echo "remove $TMP_DIR ?"
        read -p "[Y/n]" ans
        if [ "$ans" = "Y" ]; then
            rm -rf $TMP_DIR
        else
            exit 1
        fi
    fi

    if [ ! -d $INSTALL_DIR ]; then
        mkdir -p $INSTALL_DIR
    fi

    mkdir -p $TMP_DIR
    cd $TMP_DIR

    wget $BOOST_URL
    tar zxvf boost*.tar.gz

    if [ "$CREATE_USER_CONFIG" = "yes" ]; then
        create_user_config
    fi

    cd boost_${BOOST_VERSION_NAME}
    ./bootstrap.sh | tee 1.log
    ./b2 install -j4 --prefix=$INSTALL_DIR | tee 2.log
}

main "$@"
