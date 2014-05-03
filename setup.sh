#!/bin/sh

cp ./.vimrc ~/
cp ./.zshrc ~/
cp ./.bashrc ~/

if [ -d ~/.vim ]; then
    cp -r ./.vim/colors ~/.vim/
fi

