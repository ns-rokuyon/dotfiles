#!/bin/sh

cp ./.vimrc ~/
echo "cp .vimrc : done"

cp ./.zshrc ~/
echo "cp .zshrc : done"

cp ./.bashrc ~/
echo "cp .bashrc : done"

cp ./.tmux.conf ~/
echo "cp .tmux.conf : done"

if [ -d ~/misc ]; then
    cp -r ./misc/* ~/misc/
    echo "update misc : done"
else 
    cp -r ./misc ~/
    echo "cp misc directory : done"
fi

if [ -d ~/.vim ]; then
    cp -r ./.vim/colors ~/.vim/
fi

