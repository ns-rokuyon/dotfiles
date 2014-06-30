#!/bin/sh

cp ./.vimrc ~/
cp ./.zshrc ~/
cp ./.bashrc ~/
cp ./.tmux.conf ~/

if [ -d ~/.vim ]; then
    cp -r ./.vim/colors ~/.vim/
fi

