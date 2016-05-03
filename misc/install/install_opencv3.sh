#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)

config(){
    echo "configure ... "

    # インストールするディレクトリ
    INSTALL_DIR=/usr/local/OpenCV3.0    # !!!!!!!!!確認!!!!!!!!!!

    # OpenCVのgithubリポジトリ
    VERSION_TAG=3.0.0-beta
    OPENCV_URL="https://github.com/Itseez/opencv/archive/$VERSION_TAG.zip"
    OPENCV_CONTRIB_URL="https://github.com/Itseez/opencv_contrib/archive/master.zip"

    # 作業ディレクトリ
    TMPDIR=$DIR/tmp

    # OpenCVのzipを展開したディレクトリ
    OPENCV_TMPDIR=$TMPDIR/opencv-$VERSION_TAG

    # buildを行うディレクトリ
    OPENCV_BUILD_DIR=$OPENCV_TMPDIR/build
}

makeDir(){
    echo "make directory ..."
    dir=$1
    if [ ! -d $dir ]; then
        mkdir -p $dir
        if [ $? -ne 0 ]; then
            echo "mkdir: error"
            exit 1
        fi
        echo "mkdir: $dir"
    else
        echo "error: $dir already exists"
        exit 1
    fi
}

downloadOpenCV(){
    echo "download OpenCV repos ..."

    wget -O opencv.zip "$OPENCV_URL"
    if [ $? -ne 0 ]; then
        echo "opencv download error"
        exit 1
    fi
    unzip opencv.zip

    wget "$OPENCV_CONTRIB_URL"
    if [ $? -ne 0 ]; then
        echo "opencv contrib download error"
    fi
    unzip master
    mv opencv_contrib-master $OPENCV_TMPDIR/
}

installAll(){
    echo "install OpenCV3.0 to $INSTALL_DIR ? [y/N]"
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
}

main(){
    echo "OpenCV $VERSION_TAG setup start ..."
    config

    ./install_prerequisite_packages_for_opencv.sh

    makeDir $TMPDIR
    cd $TMPDIR

    downloadOpenCV

    cd $OPENCV_TMPDIR
    cp $DIR/cmake_for_opencv3.sh ./
    
    ./cmake_for_opencv3.sh "$INSTALL_DIR" "$OPENCV_TMPDIR/opencv_contrib-master"
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

    installAll

    cd $DIR
    echo "opencv setup done"
    exit 0
}

main "$@"
