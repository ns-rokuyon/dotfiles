#!/bin/bash

function main() {
    yum --version
    if [ $? -ne 0 ]; then
        echo "yum error"
        exit 1
    fi
    sudo yum -y install libpng-devel libjpeg-devel libtiff-devel libjasper-devel openexr-devel
    sudo yum -y install --enablerepo=rpmforge ffmpeg-devel

    pip --version
    if [ $? -ne 0 ]; then
        echo "pip notfound"
        exit 1
    fi
    sudo pip install numpy
}

main $*
