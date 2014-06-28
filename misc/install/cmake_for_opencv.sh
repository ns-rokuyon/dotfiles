#!/bin/bash

CMAKE=~/local/bin/cmake
BUILD_DIR=build
INSTALL_DIR=$HOME/local
DIR=$(cd $(dirname $0) && pwd)

function checkCmakeVersion() {
    $CMAKE --version
    if [ $? -ne 0 ]; then
        echo "cmake: NG"
        exit 1
    else
        echo "cmake: OK"
    fi
}

function makeDir() {
    if [ ! -d $BUILD_DIR ]; then
        mkdir $BUILD_DIR
        echo "mkdir: $BUILD_DIR"
    fi
    cd $DIR/$BUILD_DIR
    pwd
}

function execCmake() {
    pwd
    $CMAKE \
    -D CMAKE_C_COMPILER=/usr/bin/gcc \
    -D CMAKE_CXX_COMPILER=/usr/bin/g++ \
    -D CMAKE_C_FLAGS="-march=native -I/usr/local/include" \
    -D CMAKE_CXX_FLAGS="-march=native -I/usr/local/include" \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=$INSTALL_DIR \
    -D BUILD_opencv_world=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D PYTHON_EXECUTABLE=/usr/local/bin/python \
    -D PYTHON_LIBRARY=/usr/local/lib/libpython2.7.so \
    -D PYTHON_INCLUDE_PATH=/usr/local/include/python2.7 \
    -D WITH_QT=OFF \
    -D HAVE_OPENMP=ON \
    -D WITH_OPENCL=OFF \
    -D BUILD_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON ..

}


function main() {
    checkCmakeVersion
    makeDir
    execCmake
}

main $*
