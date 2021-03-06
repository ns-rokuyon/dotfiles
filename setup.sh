#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)

usage(){
    echo "Usage: ./setup.sh [OPTIONS]"
    echo "  Options:"
    echo "      -l  :   Linux"
    echo "      -L  :   Linux (with updating base packages)"
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
    copy_directory .vim/rc


    if [ `uname -a | grep Ubuntu > /dev/null; echo $?` = 0 ]; then
        # copy_file Ubuntu/.Xmodmap
	:
    fi

    install_zplug
    install_pyenv

    echo "Linux settings done"
}

linux_settings_and_basepackages() {
    linux_settings

    if [ `uname -a | grep Ubuntu > /dev/null; echo $?` = 0 ]; then
        install_base_packages ubuntu
    fi
}

mac_settings(){
    ./MacOS/setup.sh
    copy_directory .vim/rc
    install_zplug
    echo "MacOSX settings done"
}

cygwin_settings(){
    copy_file .vimrc
    copy_file Windows/cygwin/.bashrc
    copy_file Windows/cygwin/.minttyrc

    copy_directory misc

    make_directory .vim
    copy_directory .vim/colors
    copy_directory .vim/rc

    install_neobundle

    echo "Cygwin settings done"
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
                exit 0
                ;;
            L)
                linux_settings_and_basepackages
                exit 0
                ;;
            m)
                mac_settings
                exit 0
                ;;
            w)
                cygwin_settings
                exit 0
                ;;
            \?)
                usage
                ;;
        esac
    done
    usage
}

main "$@"

