#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)

usage(){
    echo "Usage: ./setup.sh [OPTIONS]"
    echo "  Options:"
    echo "      -l  :   Linux"
    echo "      -m  :   Mac"
    echo "      -w  :   Windows"
    exit 1
}

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

linux_settings(){
    copy_file .vimrc
    copy_file .zshrc
    copy_file .bashrc
    copy_file .tmux.conf

    copy_directory misc

    make_directory .vim
    copy_directory .vim/colors
    echo "Linux settings done"
    exit 0
}

mac_settings(){
    ./MacOSX/setup.sh
    echo "MacOSX settings done"
    exit 0
}

cygwin_settings(){
    copy_file .vimrc
    copy_file Windows/cygwin/.bashrc
    copy_file Windows/cygwin/.minttyrc

    copy_directory misc

    make_directory .vim
    copy_directory .vim/colors
    echo "Cygwin settings done"
    exit 0
}

main(){
    while getopts lmwh OPT
    do
        case $OPT in
            h)
                usage
                ;;
            u)
                linux_settings
                ;;
            m)
                mac_settings
                ;;
            w)
                cygwin_settings
                ;;
            \?)
                usage
                ;;
        esac
    done
    usage
}

main "$@"

