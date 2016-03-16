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


    if [ `uname -a | grep Ubuntu > /dev/null; echo $?` = 0 ]; then
        copy_file Ubuntu/.Xmodmap
        install_base_packages ubuntu
    fi

    install_zplug
    install_neobundle
    install_ohmyzsh
    install_pyenv

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

install_pyenv() {
    $DIR/misc/install/install_pyenv.sh
}

install_base_packages() {
    if [ $1 = "ubuntu" ]; then
        sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev \
            libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev
    fi
}

install_zplug() {
    if [ ! -d ~/.zplug ]; then
        read -p "Install zplug? [y/N]" ans
        if [ "$ans" = "y" ]; then
            git clone https://github.com/b4b4r07/zplug ~/.zplug
        fi
    fi
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

