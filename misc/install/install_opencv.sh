#!/bin/bash

function main() {
    local DIR=$(cd $(dirname $0) && pwd)

    local VERSION=2.4.9
    local OPENCV_URL="http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$VERSION/opencv-$VERSION.zip"

    local INSTALL_DIR=~/local
    local TMPDIR=$DIR/tmp
    local OPENCV_TMPDIR=$TMPDIR/opencv-$VERSION
    local OPENCV_BUILD_DIR=$OPENCV_TMPDIR/build

    ./install_prerequisite_packages_for_opencv.sh
    
    if [ ! -d $TMPDIR ]; then
        mkdir $TMPDIR
        echo "mkdir: $TMPDIR"
    fi
    if [ ! -d $INSTALL_DIR ]; then
        mkdir $INSTALL_DIR
        echo "mkdir: $INSTALL_DIR"
    fi

    cd $TMPDIR

    wget -O opencv.zip "$OPENCV_URL"
    if [ $? -ne 0 ]; then
        echo "opencv download error"
        exit 1
    fi
    unzip opencv.zip

    cd $OPENCV_TMPDIR
    cp $DIR/cmake_for_opencv.sh ./
    
    ./cmake_for_opencv.sh
    if [ $? -ne 0 ]; then
        echo "cmake: failed"
        exit 1
    fi

    cd $OPENCV_BUILD_DIR
    echo "`date`: make start"
    make
    if [ $? -ne 0 ]; then
        echo "make: failed"
        exit 1
    fi
    echo "`date`: make done"

    echo "install to $INSTALL_DIR ? [y/N]"
    read ans

    case $ans in
        y)  make install
            echo "install opencv: ok"
            ;;
        N)  echo "skip: install"
            ;;
        *)  echo "skip: install"
            ;;
    esac

    cd $DIR
    echo "opencv setup done"
    exit 0
}

main $*
