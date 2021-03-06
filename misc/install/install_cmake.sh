#!/bin/bash

function main() {
    local DIR=$(cd $(dirname $0) && pwd)

    local INSTALL_DIR=~/local
    local TMPDIR=$DIR/tmp
    local CMAKE_VERSION=2.8
    local CMAKE_FILENAME="cmake-2.8.12.2"
    local CMAKE_TMPDIR=$TMPDIR/$CMAKE_FILENAME
    
    if [ ! -d $TMPDIR ]; then
        mkdir $TMPDIR
        echo "mkdir: $TMPDIR"
    fi
    if [ ! -d $INSTALL_DIR ]; then
        mkdir $INSTALL_DIR
        echo "mkdir: $INSTALL_DIR"
    fi

    cd $TMPDIR

    wget -O cmake.tar.gz "http://www.cmake.org/files/v$CMAKE_VERSION/$CMAKE_FILENAME.tar.gz"
    if [ $? -ne 0 ]; then
        echo "cmake download error"
        exit 1
    fi
    tar xvf cmake.tar.gz

    cd $CMAKE_TMPDIR

    ./configure --prefix=$INSTALL_DIR
    make

    echo "make: done"
    echo "install to $INSTALL_DIR ? [y/N]"
    read ans

    case $ans in
        y)  make install
            echo "install cmake: ok"
            ;;
        N)  echo "skip: install"
            ;;
        *)  echo "skip: install"
            ;;
    esac

    cd $DIR
    echo "cmake setup done"
    exit 0
}

main $*
