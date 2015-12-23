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

    install_neobundle
    install_ohmyzsh

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

    install_neobundle

    echo "Cygwin settings done"
    exit 0
}

install_neobundle() {
    if [ -d ~/.vim/bundle ]; then
        return
    fi

    installer=neobundle_installer.sh
    cd $DIR
    wget https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh -O $installer
    chmod 755 $installer
    bash $installer
    rm $installer
}

install_ohmyzsh() {
    if [ -d ~/.oh-my-zsh ]; then
        return
    fi

    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

main(){
    while getopts lmwh OPT
    do
        case $OPT in
            h)
                usage
                ;;
            l)
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

