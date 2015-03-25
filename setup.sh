#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)

copy_file(){
    filename=$1

    cp $DIR/$filename ~/
    echo "cp $filename : done"
}

copy_directory(){
    dir=$1

    if [ -d ~/$dir ]; then
        cp -r $DIR/$dir/* ~/$dir/
    else
        cp -r $DIR/$dir ~/$dir
    fi
    echo "cp $dir : done"
}

make_directory(){
    dir=$1

    if [ ! -d ~/$dir ]; then
        mkdir ~/$dir
        echo "mkdir $dir : done"
    fi
}

main(){
    copy_file .vimrc
    copy_file .zshrc
    copy_file .bashrc
    copy_file .tmux.conf

    copy_directory misc

    make_directory .vim
    copy_directory .vim/colors
}

main "$@"

