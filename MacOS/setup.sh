#!/bin/bash

DIR=$( cd $(dirname $0) && pwd)
cd $DIR
echo "$DIR : setup"

if [ ! -d ~/.oh-my-zsh ]; then
    echo "install oh-my-zsh? [y/N]"
    read ans
    case $ans in
        y)
            git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
            ;;
        N)
            echo "skip: install oh-my-zsh"
            ;;
        *)
            echo "skip: install oh-my-zsh"
            ;;
    esac
fi

cp $DIR/../.vimrc ~/
echo "update: .vimrc"

cp $DIR/.gvimrc ~/
echo "update: .gvimrc"

cp $DIR/.zshrc ~/
echo "update: .zshrc"

cp $DIR/.bashrc ~/
echo "update: .bashrc"

if [ -d ~/.vim ]; then
    cp -r $DIR/../.vim/colors ~/.vim/
fi

