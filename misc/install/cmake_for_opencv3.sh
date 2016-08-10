#!/bin/bash

CMAKE=~/local/bin/cmake
BUILD_DIR=build
DIR=$(cd $(dirname $0) && pwd)

usage(){
    echo "$0 <install_dir> <oepncv_contrib_dir>"
    exit 1
}

checkCmakeVersion() {
    echo "check cmake ..."
    $CMAKE --version
    if [ $? -ne 0 ]; then
        echo "cmake: NG"
        exit 1
    else
        echo "cmake: OK"
    fi
}

makeDir() {
    echo "make directory $BUILD_DIR ..."
    if [ ! -d $BUILD_DIR ]; then
        mkdir $BUILD_DIR
        echo "mkdir: $BUILD_DIR"
    fi
    cd $DIR/$BUILD_DIR
    pwd
}

execCmake() {
    echo "run cmake ... "
    echo "directory: `pwd`"
    $CMAKE \
    -D CMAKE_C_COMPILER=/usr/bin/gcc \
    -D CMAKE_CXX_COMPILER=/usr/bin/g++ \
    -D CMAKE_C_FLAGS="-march=native -I/usr/local/include" \
    -D CMAKE_CXX_FLAGS="-march=native -I/usr/local/include" \
    -D CMAKE_INSTALL_PREFIX=$install_dir \
    -D PYTHON_EXECUTABLE=/usr/local/bin/python \
    -D PYTHON_LIBRARY=/usr/local/lib/libpython2.7.so \
    -D PYTHON_INCLUDE_PATH=/usr/local/include/python2.7 \
    -D WITH_QT=OFF \
    -D HAVE_OPENMP=ON \
    -D WITH_OPENCL=OFF \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D OPENCV_EXTRA_MODULES_PATH=$opencv_contrib_dir/modules ..
}

main() {
    install_dir=$1
    opencv_contrib_dir=$2
    echo "$0 start ..."
    echo "params:"
    echo "    install_dir=$install_dir"
    echo "    oepncv_contrib_dir=$opencv_contrib_dir"

    checkCmakeVersion
    makeDir
    execCmake
}

main "$@"

